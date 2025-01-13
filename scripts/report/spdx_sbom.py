#!/usr/bin/env python3
#
# Copyright (C) 2023 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

from datetime import datetime
from os import path
from shutil import copy
import hashlib
import re
import uuid

from report.sbom import SbomGenerator
from report import spdx


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
