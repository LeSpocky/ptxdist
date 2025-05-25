#!/usr/bin/env python3
#
# Copyright (C) 2023 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

from multiprocessing import Pool
from os import path, environ
import hashlib
import subprocess

from report.report import find_file, ReportException
from report.generator import Generator


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
        from dot2tex import dot2tex

        dot = self.create_dot(args[0], args[1])
        return (args[1]['name'], dot2tex(dot, docpreamble='\\usepackage[xetex]{hyperref}', figonly=True,
                                         format='pgf', autosize=True))

    def init_dot(self, pkgs, limit):
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
        print(f'generating {output} ...')
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
