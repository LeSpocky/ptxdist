#!/usr/bin/env python3
#
# Copyright (C) 2023 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

from collections import defaultdict
from cpe.cpe2_3 import CPE2_3
from cpe.cpeset2_3 import CPESet2_3
from os import path
from xml.etree import ElementTree
import pickle
import yaml


from report.sbom import SbomGenerator
from report.report import ReportException


class CPECheckGenerator(SbomGenerator):

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self._open_mode = 'w'
        self.format = 'cpe-check'
        self.output_suffix = '.yaml'

    def write(self, file, result):
        for value in result.values():
            if isinstance(value, list):
                value.sort()
        file.write(yaml.dump(dict(result)))

    def _load_dictionary(self, env):
        filename = env.get('cpe_dictionary')
        cache_filename = env.get('cpe_dictionary_cache')
        if not filename and not cache_filename:
            raise ReportException(
                'cpe_dictionary= or cpe_dictionary_cache= env must be specified!')

        if filename and not path.exists(filename):
            raise ReportException(
                f'CPE dictionary file "{filename}" is missing!')

        if cache_filename and path.exists(cache_filename) and (not filename or path.getmtime(cache_filename) > path.getmtime(filename)):
            try:
                print(
                    f'Loading CPE dictionary from cache {cache_filename} ...')
                self.cpe_db = pickle.load(open(cache_filename, 'rb'))
                return
            except EOFError:
                print('Loading CPE dictionary cache failed, ignoring.')
                pass

        self.cpe_db = defaultdict(lambda: defaultdict(list))
        print(f'Loading CPE dictionary from file {filename} ...')
        tree = ElementTree.parse(filename)
        for item in tree.findall('./{http://cpe.mitre.org/dictionary/2.0}cpe-item'):
            if item.attrib.get('deprecated', "false") == "true":
                continue
            cpe_id = item.find(
                './{http://scap.nist.gov/schema/cpe-extension/2.3}cpe23-item').attrib['name']
            cpe = CPE2_3(cpe_id)
            self.cpe_db[cpe.get_product()[0]][cpe.get_vendor()
                                              [0]].append(cpe_id)

        if cache_filename:
            self.cpe_db = dict(self.cpe_db)
            pickle.dump(self.cpe_db, open(cache_filename, 'wb'))

    def _match_cpe(self, cpe1, cpe2):
        version = False
        found = True
        for attr, result in CPESet2_3.compare_wfns(cpe1, cpe2):
            match (attr, result):
                case ('version', CPESet2_3.LOGICAL_VALUE_DISJOINT):
                    version = False
                case ('version', CPESet2_3.LOGICAL_VALUE_EQUAL):
                    version = True
                case (_, CPESet2_3.LOGICAL_VALUE_DISJOINT):
                    found = False
                case (_, _):
                    pass
        return found, found and version

    def check_package(self, result, pkg):
        pkg_name = pkg['name']
        if pkg_name in self.checked_pkgs:
            return

        self.checked_pkgs.add(pkg_name)

        if source_packages := pkg.get('source-packages', []):
            if source_packages[0]['name'] == pkg_name:
                pkg.update(source_packages.pop(0))

            for source in source_packages:
                self.check_package(result, source)

        self.pkgs.update(set(pkg.get('builddeps', [])))
        self.pkgs.update(set(pkg.get('rundeps', [])))

        cpe_ids = self.create_cpe_ids(pkg)
        if not cpe_ids:
            result['skipped'].append(pkg_name)
            return

        result['all'][pkg_name] = cpe_ids

        version, update = self.get_cve_version(pkg)
        for vendor, product in self.get_cve_products(pkg):
            if product not in self.cpe_db:
                result['unknown-product'][pkg_name] = product
                continue
            cpe = CPE2_3(
                f'cpe:2.3:*:{vendor}:{product}:{version}:{update}:*:*:*:*:*:*')
            product_db = self.cpe_db[product]
            if vendor == '*':
                vendors = product_db.keys()
            else:
                if vendor not in product_db:
                    result['unknown-vendor'][pkg_name] = vendor
                    continue
                vendors = [vendor]
            exact_match = set()
            noversion_match = set()
            for v in vendors:
                vendor_db = product_db[v]
                without_version = False
                found = False
                with_version = False
                for cpe_id in vendor_db:
                    found, with_version = self._match_cpe(CPE2_3(cpe_id), cpe)
                    if found and with_version:
                        break
                    if found:
                        without_version = True
                if found and with_version:
                    exact_match.add(v)
                elif without_version:
                    noversion_match.add(v)
                else:
                    raise ReportException(
                        f'cpe matching logic error for {pkg_name}')
            if len(exact_match) == 1:
                result['ok'].append(pkg_name)
            elif len(noversion_match) == 1:
                result['unknown-version'][pkg_name] = version
            if len(exact_match) > 1 or len(noversion_match) > 1:
                if vendor != '*':
                    raise ReportException(
                        f'cpe vendor matching logic error for {pkg_name}')
                result['ambiguous-vendor'][pkg_name] = list(
                    exact_match.union(noversion_match))

        for key, value in result.items():
            if key not in ('unknown-product', 'unknown-vendor', 'unknown-version', 'ambiguous-vendor'):
                continue

            for name in list(value.keys()):
                base_name = self.base_name(name)
                if name != base_name and base_name in value:
                    value.pop(name)

    def build(self, data):
        result = defaultdict(dict)
        result['ok'] = []
        result['skipped'] = []

        self.pkgs = set()
        self.current_pkg = None
        self.checked_pkgs = set()

        env = self.setup_env()
        self.target = env.get('target')
        if self.target:
            self.pkgs.add(self.target)
        else:
            self.pkgs.update(set(data['packages'].keys()))

        self._load_dictionary(env)

        while self.pkgs:
            self.current_pkg = self.pkgs.pop()
            if self.current_pkg in data['images']:
                self.pkgs.update(
                    set(data['images'][self.current_pkg].get('pkgs', ())))
            else:
                self.check_package(
                    result, data['packages'][self.current_pkg])

        return result
