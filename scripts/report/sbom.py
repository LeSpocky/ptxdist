#!/usr/bin/env python3
#
# Copyright (C) 2023 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

from os import path
import re

from report.report import ReportException
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

    def git_blob_prefix(self, pkg):
        # https://github.com/linux4sam/at91bootstrap/raw/e05486a6d65745cb7a66770c3398186ebb8f71b3/LICENSES/MIT.txt
        git_commit = pkg.get('git-commit', None)

        for url in pkg.get('url', []):
            if m := self.GITHUB_TAG.match(url):
                version = git_commit if git_commit else m.group(4)
                return f'https://github.com/{m.group(1)}/{m.group(2)}/raw/{version}/'
            elif m := self.GITHUB_RELEASE.match(url):
                version = git_commit if git_commit else m.group(3)
                return f'https://github.com/{m.group(1)}/{m.group(2)}/raw/{version}/'
        return None

    def patches(self, pkg):
        if 'patches' not in pkg:
            return []
        patch_dir = pkg['patches']
        series = path.join(patch_dir, 'series')
        if not path.exists(series):
            return

        patches = []
        tag = 'base'
        TAG = re.compile('#tag:([^ ]) .*')
        with open(series) as f:
            for line in f:
                line = line.strip()
                if not line:
                    continue
                if m := TAG.match(line):
                    tag = m.group(1)
                if line.startswith('#'):
                    continue
                patch = path.join(patch_dir, line.rstrip())
                if not path.exists(patch):
                    raise ReportException(
                        f'Patch missing for {pkg["name"]}: {patch}')
                patches.append((tag, patch))
        return patches

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
