#!/usr/bin/env python3
#
# Copyright (C) 2023 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

import re

from report.generator import Generator


class SbomGenerator(Generator):

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
        self.output_suffix = '.json'

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
