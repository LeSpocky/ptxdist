#!/usr/bin/env python3
#
# Copyright (C) 2023 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#


from os import path, environ, makedirs
from chardet.universaldetector import UniversalDetector
from datetime import datetime
from multiprocessing import Pool
from dot2tex import dot2tex
from shutil import copy
import argparse
import jinja2
import re
import yaml
import subprocess
import hashlib
import spdx
import uuid


class ReportException(BaseException):
    pass


def find_file(search_path, name):
    for file in [path.join(d, name) for d in search_path]:
        if path.exists(file):
            return file
    return None


class Generator:
    def __init__(self, args):
        self.input_suffix = '.txt'
        self.output_suffix = '.txt'
        self._data = args.input
        self.__template = args.template
        self.__output = args.output
        self._output_dir = args.output_dir or ''
        self._env = args.env or []
        self._open_mode = 'w'
        self.verbose = args.verbose
        self.detector = UniversalDetector()
        self.path = args.path

    def create_loader(self):
        return jinja2.ChoiceLoader([jinja2.FileSystemLoader(d) for d in self.path])

    def escape(self, text):
        return text

    def raise_exception(self, message):
        raise ReportException(message)

    def build_chapter(self, pkg):
        chapter = self.escape(pkg.get('name'))
        chapter = chapter.removeprefix('host-').removeprefix('cross-')
        if pkg.get('licenses', '').find('proprietary') >= 0:
            chapter += ' *** Proprietary License!'
        if pkg.get('licenses', '').find('unknown') >= 0:
            chapter += ' *** Unknown License!'
        return chapter

    def source_file(self, name):
        raw = True
        if path.exists(name + '.utf-8'):
            name = name + '.utf-8'
            raw = False
        if self.verbose:
            print(f'Reading "{name}" ...')
        if raw:
            raw_data = open(name, 'rb').read()
            try:
                data = raw_data.decode('UTF-8')
            except UnicodeDecodeError:
                self.detector.reset()
                self.detector.feed(raw_data)
                self.detector.close()
                encoding = self.detector.result['encoding']
                if self.verbose:
                    print(f'Assuming encoding {encoding}.')
                data = raw_data.decode(encoding)
        else:
            data = open(name, encoding='utf-8').read()
        return data.replace('\f', '\n')

    def create_dot_recurse(self, pkgs, pkg, level, hit_deps):
        if level > 3:
            return ''

        display_name = self.escape(
            pkg['name'].removeprefix('host-').removeprefix('cross-'))
        licenses = self.escape(pkg['licenses']).split()
        licenses = ' '.join(i + '\\\\' * (w % 3 == 2)
                            for w, i in enumerate(licenses))

        data = """"%s" [ shape=box style="rounded corners" fixedsize=false texlbl="\\small\\begin{tabular}{c}{\\Large\\hyperref[%s]{%s}}\\\\%s\\end{tabular}" ];
""" % (pkg['name'], pkg['name'], self.escape(pkg['name']), licenses)

        if 'builddeps' not in pkg:
            return data

        for dep in pkg['builddeps']:
            if f'{pkg["name"]} {dep}' in hit_deps:
                continue
            if dep not in pkgs:
                continue
            hit_deps.add(f'{pkg["name"]} {dep}')
            data += """"%s" -> "%s"[dir=back];
""" % (pkg['name'], dep)
            data += self.create_dot_recurse(pkgs,
                                            pkgs[dep], level + 1, hit_deps)
        return data

    def create_dot(self, pkgs, pkg):
        dot = """
digraph "%s" {
rankdir=LR;
ratio=compress;
nodesep=0.1;
ranksep=0.1;
node [ shape=point fixedsize=true width=0.1 ];
""" % pkg['name']
        dot += self.create_dot_recurse(pkgs, pkg, 0, set())
        dot += """}
"""
        return dot

    def load(self, data):
        return yaml.load(open(data).read(), Loader=yaml.SafeLoader)

    def setup_env(self, loader):
        env = jinja2.Environment(
            loader=loader, autoescape=jinja2.select_autoescape())

        def _find_file(name):
            return find_file(self.path, name)

        def regex_replace(s, find, replace):
            return re.sub(find, replace, s)

        env.globals['find_file'] = _find_file
        env.globals['source_file'] = self.source_file
        env.globals['escape'] = self.escape
        env.globals['raise'] = self.raise_exception
        env.globals['build_chapter'] = self.build_chapter
        env.globals['now'] = datetime.now().strftime('%c')
        env.filters['regex_replace'] = regex_replace
        for tmp in self._env:
            tmp = tmp.split('=', 2)
            env.globals[tmp[0]] = tmp[1]
        return env

    def build(self, data, loader):
        env = self.setup_env(loader)
        header = env.get_template("header" + self.input_suffix)
        body = env.get_template("body" + self.input_suffix)
        footer = env.get_template("footer" + self.input_suffix)
        return header.render(**data) + body.render(**data) + footer.render(**data)

    def write(self, file, document):
        file.write(document)

    def finalize(self, document, output):
        if directory := path.dirname(output):
            makedirs(directory, exist_ok=True)
        with open(output, mode=self._open_mode) as f:
            self.write(f, document)
        return output

    def output_name(self):
        if self.__output:
            output = self.__output
            if not output.endswith(self.output_suffix):
                output += self.output_suffix
        else:
            output = self.__template + self.output_suffix
        return output

    def run(self):
        data = self.load(self._data)
        try:
            document = self.build(data, self.create_loader())
        except jinja2.exceptions.TemplateNotFound:
            raise ReportException(f'Invalid template "{self.__template}"!')
        return self.finalize(document, self.output_name())


class LatexGenerator(Generator):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.input_suffix = '.tex'
        self.output_suffix = '.pdf'

    def escape(self, text):
        return text.replace('_', '\\_').replace('&', '\\&')

    def dot(self, pkg):
        return self.__dot.get(pkg, None)

    def format_dot(self, args):
        dot = self.create_dot(args[0], args[1])
        return (args[1]['name'], dot2tex(dot, docpreamble='\\usepackage[xetex]{hyperref}', figonly=True,
                                         format='pgf', autosize=True))

    def init_dot(self, pkgs, limit):
        from dot2tex import dot2tex

        if limit:
            packages = {pkg: pkgs[pkg] for pkg in limit}
        else:
            packages = pkgs

        with Pool() as pool:
            dots = pool.map(self.format_dot, [
                            (packages, pkg) for pkg in packages.values()])
        self.__dot = {}
        for pkg, dot in dots:
            self.__dot[pkg] = dot

    def setup_env(self, loader):
        env = super().setup_env(loader)
        env.globals['init_dot'] = self.init_dot
        env.globals['dot'] = self.dot
        return env

    def finalize(self, document, output):
        base = output.removesuffix(self.output_suffix)
        tmp = super().finalize(document, base + self.input_suffix)
        env = environ.copy()
        env['max_print_line'] = '1000'
        output_directory = path.dirname(tmp) or '.'
        aux_hash = None
        print(f'generating {output}...')
        while True:
            ret = subprocess.run(['xelatex', '-halt-on-error', path.basename(tmp)], env=env,
                                 capture_output=not self.verbose, text=True, cwd=path.realpath(output_directory))
            if ret.returncode != 0:
                if not self.verbose:
                    print(ret.stdout + ret.stderr)
                raise ReportException('Failed to execute xelatex')

            new_aux_hash = hashlib.sha256(
                open(base + '.aux', 'rb').read()).hexdigest()
            if aux_hash == new_aux_hash:
                break
            aux_hash = new_aux_hash


class SbomGenerator(Generator):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.output_suffix = '.json'

    def setup_env(self):
        env = {}
        for tmp in self._env:
            tmp = tmp.split('=', 2)
            env[tmp[0]] = tmp[1]
        return env

    def run(self):
        data = self.load(self._data)
        document = self.build(data)
        return self.finalize(document, self.output_name())


class SpdxSbomGenerator(SbomGenerator):

    PYPI_RELEASE = re.compile(
        'https://files.pythonhosted.org/packages/source/./([^/]*)/.*-([^-]*).(tar\\..*|zip)')
    GITHUB_TAG = re.compile(
        'https://github.com/([^/]*)/([^/]*)/archive/(refs/tags/)?([^/]*).(tar\\..*|zip)')
    GITHUB_RELEASE = re.compile(
        'https://github.com/([^/]*)/([^/]*)/releases/download/([^/]*)/.*')
    CARGO_RELEASE = re.compile(
        'https://crates.io/api/v1/crates/([^/]*)/([^/]*)/download')

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self._open_mode = 'wb'
        self.format = 'spdx'

    def write(self, file, document):
        document.to_json(file, sort_keys=True, indent=2)

    def add_packages(self, pkgs):
        for pkg in pkgs:
            if pkg not in self.spdx_pkgs and pkg != self.current_pkg:
                self.pkgs.add(pkg)

    def build_package(self, document, pkg):
        pkg_name = pkg['name']
        if pkg_name in self.spdx_pkgs:
            return None

        if 'source-packages' in pkg:
            if pkg['source-packages'][0]['name'] == pkg_name:
                pkg.update(pkg['source-packages'].pop(0))

        self.add_packages(pkg.get('builddeps', []))
        self.add_packages(pkg.get('rundeps', []))

        spdx_pkg = spdx.SPDXPackage()
        spdx_pkg.name = pkg_name
        spdx_pkg.SPDXID = 'SPDXRef-' + pkg_name
        if 'version' in pkg:
            spdx_pkg.versionInfo = pkg['version']
        if 'url' in pkg:
            spdx_pkg.downloadLocation = pkg['url'][0]
        if 'licenses' in pkg:
            spdx_pkg.licenseDeclared = pkg['licenses']
        if 'source' in pkg:
            spdx_pkg.packageFileName = path.basename(pkg['source'])
            if 'md5' in pkg:
                checksum = spdx.SPDXChecksum()
                checksum.algorithm = 'MD5'
                checksum.checksumValue = pkg['md5'].split(maxsplit=1)[0]
                spdx_pkg.checksums.append(checksum)

        document.packages.append(spdx_pkg)
        self.spdx_pkgs[pkg_name] = spdx_pkg

        for source in pkg.get('source-packages', []):
            spdx_source = self.build_package(document, source)
            if spdx_source:
                document.add_relationship(
                    spdx_source, 'BUILD_DEPENDENCY_OF', spdx_pkg)

        return spdx_pkg

    def add_dependencies(self, document, pkg, spdx_pkg):
        for dep in pkg.get('builddeps', []):
            if dep not in self.spdx_pkgs:
                raise ReportException(f'Missing packge "{dep}"')
            spdx_dep = self.spdx_pkgs[dep]
            if dep in pkg.get('rundeps', []):
                document.add_relationship(spdx_dep, 'DEPENDENCY_OF', spdx_pkg)
            else:
                document.add_relationship(
                    spdx_dep, 'BUILD_DEPENDENCY_OF', spdx_pkg)
        for dep in pkg.get('rundeps', []):
            if dep not in self.spdx_pkgs:
                raise ReportException(f'Missing packge "{dep}"')
            spdx_dep = self.spdx_pkgs[dep]
            if dep not in pkg.get('builddeps', []):
                document.add_relationship(
                    spdx_dep, 'RUNTIME_DEPENDENCY_OF', spdx_pkg)
        for dep in pkg.get('pkgs', []):
            if dep not in self.spdx_pkgs:
                raise ReportException(f'Missing packge "{dep}"')
            spdx_dep = self.spdx_pkgs[dep]
            document.add_relationship(spdx_pkg, 'CONTAINS', spdx_dep)

    def generate_purls(self, pkg):
        purls = []
        for url in pkg.get('url', []):
            if m := self.PYPI_RELEASE.match(url):
                if m.group(2) != pkg['version']:
                    ReportException(
                        f'{pkg["name"]}: version mismatch: pkg: {pkg["version"]} url: {m.group(2)}')
                purls.append(f'pkg:pypi/{m.group(1)}@{m.group(2)}')

            elif m := self.GITHUB_TAG.match(url):
                purls.append(
                    f'pkg:github/{m.group(1)}/{m.group(2)}@{m.group(4)}')

            elif m := self.GITHUB_RELEASE.match(url):
                purls.append(
                    f'pkg:github/{m.group(1)}/{m.group(2)}@{m.group(3)}')

            elif m := self.CARGO_RELEASE.match(url):
                purls.append(f'pkg:cargo/{m.group(1)}@{m.group(2)}')

            else:
                if url.startswith('https://files.pythonhosted.org') or url.startswith('https://github.com') or url.startswith('https://crates.io'):
                    raise ReportException(
                        f'{pkg["name"]}: url "{url}" should match purl pattern')

        return purls

    def import_pkg_spdx(self, pkg):
        if 'spdx-sbom' not in pkg:
            return (None, None, None)
        src = pkg['spdx-sbom']
        dst = path.join(self._output_dir, f'spdx-sbom-{pkg["name"]}.json')
        copy(src, dst)
        with open(dst, 'rb') as f:
            doc = spdx.SPDXDocument.from_json(f)
            f.seek(0)
            sha1 = hashlib.file_digest(f, 'sha1')
        return (doc, dst, sha1.hexdigest())

    def add_external_refs(self, document, pkg, spdx_pkg):
        purls = self.generate_purls(pkg)
        for purl in purls:
            ref = spdx.SPDXExternalReference()
            ref.referenceCategory = 'PACKAGE-MANAGER'
            ref.referenceType = 'purl'
            ref.referenceLocator = purl
            spdx_pkg.externalRefs.append(ref)

        if 'git-commit' in pkg:
            ref = spdx.SPDXExternalReference()
            ref.referenceCategory = 'PERSISTENT-ID'
            ref.referenceType = 'gitoid'
            ref.referenceLocator = f'gitoid:commit:sha1:{pkg["git-commit"]}'
            spdx_pkg.externalRefs.append(ref)

        pkg_doc, pkg_doc_path, pkg_doc_sha1 = self.import_pkg_spdx(pkg)
        if pkg_doc:
            ref = spdx.SPDXExternalDocumentRef()
            ref.externalDocumentId = "DocumentRef-package-" + pkg_doc.name
            ref.spdxDocument = pkg_doc.documentNamespace
            ref.checksum.algorithm = "SHA1"
            ref.checksum.checksumValue = pkg_doc_sha1
            document.externalDocumentRefs.append(ref)
            document.add_relationship(
                ref.externalDocumentId, 'AMENDS', spdx_pkg)

    def build(self, data):
        creationInfo = spdx.SPDXCreationInfo()
        creationInfo.created = datetime.now().isoformat()
        creationInfo.creators = [data['bsp']['vendor']]
        document = spdx.SPDXDocument()
        document.creationInfo = creationInfo
        document.name = data['bsp']['project']
        namespace_uuid = uuid.uuid5(uuid.NAMESPACE_DNS, 'sbom.ptxdist.org')
        document.documentNamespace = f'http://spdx.org/spdxdoc/{document.name}/{namespace_uuid}'

        self.pkgs = set()
        self.current_pkg = None
        self.spdx_pkgs = {}

        env = self.setup_env()
        if target := env.get('TARGET'):
            self.add_packages([target])
        else:
            self.add_packages(data['images'].keys())
            self.add_packages(data['packages'].keys())

        while self.pkgs:
            self.current_pkg = self.pkgs.pop()
            if self.current_pkg in data['images']:
                self.add_packages(
                    set(data['images'][self.current_pkg].get('pkgs', ())))
                self.build_package(document, data['images'][self.current_pkg])
            else:
                self.build_package(
                    document, data['packages'][self.current_pkg])

        for pkg_name in self.spdx_pkgs:
            if pkg_name in data['packages']:
                pkg = data['packages'][pkg_name]
            elif pkg_name in data['images']:
                pkg = data['images'][pkg_name]
            else:
                # source packages are not globaly listed and have no dependencies
                continue

            spdx_pkg = self.spdx_pkgs[pkg_name]
            self.add_dependencies(document, pkg, spdx_pkg)
            self.add_external_refs(document, pkg, spdx_pkg)

        if target:
            document.add_relationship(
                document, 'DESCRIBES', self.spdx_pkgs[target])

        return document


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('-t', '--template', help='Template to use')
    parser.add_argument(
        '-p', '--path', help='Colon separated search path that contain the templates')
    parser.add_argument('-o', '--output', help='Output file name')
    parser.add_argument('-d', '--output-dir',
                        help='Output directory for additional')
    parser.add_argument('-i', '--input', help='Input file name')
    parser.add_argument(
        '-e', '--env', help='Extra variables for the jinja2 env', action='append')
    parser.add_argument('-g', '--generator',
                        help='Generator to use (plain, latex)')
    parser.add_argument('-v', '--verbose', action='store_true')

    args = parser.parse_args()

    args.path = [path.abspath(path.join(d, args.template))
                 for d in args.path.split(':')] if args.path else ['']

    if not args.generator and args.template in ('spdx-sbom'):
        args.generator = args.template

    if not args.output_dir and args.output:
        args.output_dir = path.dirname(args.output)

    if not args.generator:
        file = find_file(args.path, 'generator')
        if file:
            args.generator = open(file).read().strip()
        else:
            args.generator = 'latex'

    if args.generator == 'plain':
        generator = Generator(args)
    elif args.generator == 'latex':
        generator = LatexGenerator(args)
    elif args.generator == 'spdx-sbom':
        generator = SpdxSbomGenerator(args)
    else:
        raise ReportException(f'Invalid generator type: "{args.generator}"')

    generator.run()


if __name__ == "__main__":
    try:
        main()
    except ReportException as e:
        print(f'Report Generation failed: {e.args[0]}')
        exit(1)
