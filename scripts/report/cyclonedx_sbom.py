#!/usr/bin/env python3
#
# Copyright (C) 2023 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

from base64 import b64encode
from cyclonedx.exception.factory import InvalidSpdxLicenseException
from cyclonedx.factory.license import LicenseFactory
from cyclonedx.model import AttachedText, Encoding, ExternalReference, ExternalReferenceType, HashType, HashAlgorithm, Property
from cyclonedx.model.bom import Bom, BomMetaData
from cyclonedx.model.bom_ref import BomRef
from cyclonedx.model.component import Commit, Component, ComponentEvidence, ComponentType, Diff, Patch, PatchClassification, Pedigree
from cyclonedx.output.json import JsonV1Dot6
from cyclonedx.spdx import fixup_id as spdx_id
from datetime import datetime
from os import path
from packageurl import PackageURL
from shutil import copy
from sortedcontainers import SortedSet
import hashlib
import json
import re
import uuid

from report.sbom import SbomGenerator
from report.report import ReportException


class CycloneDXSbomGenerator(SbomGenerator):

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self._open_mode = 'wb'
        self.format = 'cyclonedx'
        self.lc_factory = LicenseFactory()

    def write(self, file, bom):
        outputter = JsonV1Dot6(bom)
        file.write(outputter.output_as_string(indent=2).encode('utf-8'))

    def add_packages(self, pkgs):
        for pkg in pkgs:
            if pkg not in self.cyclonedx_pkgs and pkg != self.current_pkg:
                self.pkgs.add(pkg)

    def build_package(self, document, pkg, parent=None):
        pkg_name = pkg['name']
        if pkg_name in self.cyclonedx_pkgs:
            return None

        if source_packages := pkg.get('source-packages', []):
            if source_packages[0]['name'] == pkg_name:
                pkg.update(source_packages.pop(0))

        self.add_packages(pkg.get('builddeps', []))
        self.add_packages(pkg.get('rundeps', []))

        if 'image' in pkg:
            type = ComponentType.FIRMWARE
        else:
            type = ComponentType.LIBRARY
        version = pkg.get('version', None)
        bom_ref = f'{pkg_name}@{version}' if version else pkg_name
        component = Component(
            type=type,
            name=pkg_name,
            version=pkg.get('version', None),
            bom_ref=BomRef(bom_ref)
        )

        if licenses := pkg.get('licenses', None):
            if licenses != 'ignore':
                component.licenses = [
                    self.lc_factory.make_from_string(licenses)]

        if license_files := pkg.get('license-files', {}):
            license_list = []
            for license in license_files.values():
                filename = license['file']
                if not path.exists(filename):
                    raise ReportException(
                        f'License file "{filename}" is missing')
                with open(filename, 'rb') as f:
                    content = b64encode(f.read()).decode()
                text = AttachedText(content=content, encoding=Encoding.BASE_64)
                file_path = license['path']
                lic = self.lc_factory.make_with_name(
                    path.basename(file_path), text=text)
                if prefix := self.git_blob_prefix(pkg):
                    lic.url = prefix + file_path
                license_list.append(lic)
            component.evidence = ComponentEvidence(licenses=license_list)

        if urls := pkg.get('url', None):
            component.external_references = [
                ExternalReference(type=ExternalReferenceType.DISTRIBUTION, url=url) for url in urls
            ]

        cpe_ids = self.create_cpe_ids(pkg)
        if cpe_ids:
            component.cpe = cpe_ids[0]
            # TODO: store additional CPE IDs in component.evidence.identity
            # but that is not yet supported by the bindings:
            # https://github.com/CycloneDX/cyclonedx-python-lib/issues/737

        if md5s := pkg.get('md5', None):
            hashes = SortedSet()
            for md5 in md5s.split():
                hashes.add(HashType(alg=HashAlgorithm.MD5, content=md5))
            component.hashes = hashes

        if self.target and self.target == pkg_name:
            document.metadata.component = component
        elif parent:
            parent.components.add(component)
        else:
            document.components.add(component)

        self.cyclonedx_pkgs[pkg_name] = component

        for source in source_packages:
            source_component = self.build_package(document, source, component)

        return component

    def add_dependencies(self, document, pkg, component):
        for dep in pkg.get('builddeps', []):
            if dep not in self.cyclonedx_pkgs:
                raise ReportException(f'Missing packge "{dep}"')
            sbom_dep = self.cyclonedx_pkgs[dep]
            if dep in pkg.get('rundeps', []):
                document.register_dependency(component, [sbom_dep])
            else:
                document.register_dependency(component, [sbom_dep])
        for dep in pkg.get('rundeps', []):
            if dep not in self.cyclonedx_pkgs:
                raise ReportException(f'Missing packge "{dep}"')
            sbom_dep = self.cyclonedx_pkgs[dep]
            if dep not in pkg.get('builddeps', []):
                document.register_dependency(component, [sbom_dep])
        for dep in pkg.get('pkgs', []):
            if dep not in self.cyclonedx_pkgs:
                raise ReportException(f'Missing packge "{dep}"')
            sbom_dep = self.cyclonedx_pkgs[dep]
            document.register_dependency(component, [sbom_dep])

    def import_pkg_cyclonedx(self, pkg):
        if 'cyclonedx-sbom' not in pkg:
            return None
        src = pkg['cyclonedx-sbom']
        dst = path.join(self._output_dir, f'cyclonedx-sbom-{pkg["name"]}.json')
        copy(src, dst)
        with open(src, 'rb') as f:
            doc = Bom.from_json(json.load(f))
        return doc

    def add_external_refs(self, document, pkg, component):
        purls = self.generate_purls(pkg)
        if purls:
            component.purl = PackageURL.from_string(purls[0])

        commits = None
        if git_commit := pkg.get('git-commit', None):
            commits = SortedSet([Commit(uid=git_commit)])

        patches = None
        patch_files = self.patches(pkg)
        if patch_files:
            patches = SortedSet()
            for tag, file in patch_files:
                if tag.startswith('upstream'):
                    type = PatchClassification.BACKPORT
                else:
                    type = PatchClassification.UNOFFICIAL
                filename = path.basename(file)
                with open(file, 'rb') as f:
                    content = b64encode(f.read()).decode()

                text = AttachedText(content=content, encoding=Encoding.BASE_64)
                patches.add(Patch(type=type, diff=Diff(
                    text=text, url=f'file://{filename}')))

        if commits or patches:
            component.pedigree = Pedigree(commits=commits, patches=patches)

        pkg_doc = self.import_pkg_cyclonedx(pkg)
        if pkg_doc:
            if pkg_doc.metadata and pkg_doc.metadata.component:
                comp = f'#{pkg_doc.metadata.component.bom_ref}'
            else:
                comp = ''
            ref = ExternalReference(type=ExternalReferenceType.BOM,
                                    url=f'urn:cdx:{pkg_doc.serial_number}/{pkg_doc.version}{comp}')
            component.external_references.add(ref)

    def build(self, data):
        document = Bom()

        document.metadata = BomMetaData(
            timestamp=datetime.now(),
            properties=SortedSet([
                Property(name='vendor', value=data['bsp']['vendor']),
                Property(name='project', value=data['bsp']['project']),
                Property(name='version',
                         value=data['bsp']['project-version'].lstrip('-')),
            ])
        )

        self.pkgs = set()
        self.current_pkg = None
        self.cyclonedx_pkgs = {}

        env = self.setup_env()
        self.target = env.get('target')
        if self.target:
            self.add_packages([self.target])
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

        for pkg_name in self.cyclonedx_pkgs:
            if pkg_name in data['packages']:
                pkg = data['packages'][pkg_name]
            elif pkg_name in data['images']:
                pkg = data['images'][pkg_name]
            else:
                # source packages are not globaly listed and have no dependencies
                continue

            component = self.cyclonedx_pkgs[pkg_name]
            self.add_dependencies(document, pkg, component)
            self.add_external_refs(document, pkg, component)

        return document
