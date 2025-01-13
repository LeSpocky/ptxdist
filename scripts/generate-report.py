#!/usr/bin/env python3
#
# Copyright (C) 2023 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#


from os import path
import argparse

from report.report import find_file, ReportException


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

    if not args.generator and args.template in ('spdx-sbom', 'cyclonedx-sbom'):
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
        from report.generator import Generator
        generator = Generator(args)
    elif args.generator == 'latex':
        from report.latex import LatexGenerator
        generator = LatexGenerator(args)
    elif args.generator == 'spdx-sbom':
        from report.spdx_sbom import SpdxSbomGenerator
        generator = SpdxSbomGenerator(args)
    elif args.generator == 'cyclonedx-sbom':
        from report.cyclonedx_sbom import CycloneDXSbomGenerator
        generator = CycloneDXSbomGenerator(args)
    else:
        raise ReportException(f'Invalid generator type: "{args.generator}"')

    generator.run()


if __name__ == "__main__":
    try:
        main()
    except ReportException as e:
        print(f'Report Generation failed: {e.args[0]}')
        exit(1)
