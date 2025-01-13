#!/usr/bin/env python3
#
# Copyright (C) 2023 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

from report.generator import Generator


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
