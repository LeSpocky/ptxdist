#!/usr/bin/env python3
#
# Copyright (C) 2023 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

from os import path


def find_file(search_path, name):
    for file in [path.join(d, name) for d in search_path]:
        if path.exists(file):
            return file
    return None


class ReportException(BaseException):
    pass
