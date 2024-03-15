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
import argparse
import jinja2
import re
import yaml
import subprocess
import hashlib


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
        self.__template = args.template
        self.__data = args.input
        self.__output = args.output
        self.__env = args.env or []
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
        for tmp in self.__env:
            tmp = tmp.split('=', 2)
            env.globals[tmp[0]] = tmp[1]
        return env

    def build(self, data, loader):
        env = self.setup_env(loader)
        header = env.get_template("header" + self.input_suffix)
        body = env.get_template("body" + self.input_suffix)
        footer = env.get_template("footer" + self.input_suffix)
        return header.render(**data) + body.render(**data) + footer.render(**data)

    def finalize(self, document, output):
        makedirs(path.dirname(output), exist_ok=True)
        with open(output, mode='w') as f:
            f.write(document)
        return output

    def run(self):
        data = self.load(self.__data)
        try:
            document = self.build(data, self.create_loader())
        except jinja2.exceptions.TemplateNotFound:
            raise ReportException(f'Invalid template "{self.__template}"!')
        if self.__output:
            output = self.__output
            if not output.endswith(self.output_suffix):
                output += self.output_suffix
        else:
            output = self.__template + self.output_suffix
        return self.finalize(document, output)


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


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('-t', '--template', help='Template to use')
    parser.add_argument(
        '-p', '--path', help='Colon separated search path that contain the templates')
    parser.add_argument('-o', '--output', help='Output file name')
    parser.add_argument('-i', '--input', help='Input file name')
    parser.add_argument(
        '-e', '--env', help='Extra variables for the jinja2 env', action='append')
    parser.add_argument('-g', '--generator',
                        help='Generator to use (plain, latex)')
    parser.add_argument('-v', '--verbose', action='store_true')

    args = parser.parse_args()

    args.path = [path.abspath(path.join(d, args.template))
                         for d in args.path.split(':')] if args.path else ['']

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
    else:
        raise ReportException(f'Invalid generator type: "{args.generator}"')

    generator.run()


if __name__ == "__main__":
    try:
        main()
    except ReportException as e:
        print(f'Report Generation failed: {e.args[0]}')
        exit(1)
