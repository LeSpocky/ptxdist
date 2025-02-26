#!/usr/bin/env python3
#
# Copyright (C) 2023 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

from chardet.universaldetector import UniversalDetector
from datetime import datetime
from os import path, makedirs
import jinja2
import re
import yaml

from report.report import find_file, ReportException


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

    def get_cve_products(self, pkg):
        products = pkg.get('cve-product', [pkg['name'].removeprefix(
            'host-system-').removeprefix('host-').removeprefix('cross-')])
        cve_products = []
        for product in products:
            if ':' in product:
                vendor, product = product.split(":", 1)
            else:
                vendor = '*'
            if 'cve-product' not in pkg and product.startswith('python3-'):
                vendor = 'python'
                product = product.removeprefix('python3-')
            cve_products.append((vendor, product))
        return cve_products

    def get_cve_version(self, pkg):
        version = pkg.get('cve-version', pkg.get('version', '*'))
        tmp = version.split(':')
        if len(tmp) > 2:
            raise ReportException(
                f'cve-version "{version}" contains more than on ":"')
        return tmp[0], tmp[1] if len(tmp) > 1 else '*'

    def create_cpe_ids(self, pkg):
        # if there is nothing to download then a CPE ID makes no sense
        if 'url' not in pkg:
            return []
        version, update = self.get_cve_version(pkg)
        return [f'cpe:2.3:*:{vendor}:{product}:{version}:{update}:*:*:*:*:*:*' for vendor, product in self.get_cve_products(pkg)]

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
