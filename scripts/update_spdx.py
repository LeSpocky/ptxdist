#!/usr/bin/env python3
#
# Copyright (C) 2018 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

import json
import sys
from os.path import basename

data = json.load(open(sys.argv[1]))
ex_data = json.load(open(sys.argv[2]))

outfile = open(sys.argv[3], 'w')

outfile.write("""
#!/bin/bash
#
# Copyright (C) 2018 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# WARNING: This file is generated with '%s' from
# '%s' and '%s'.
#
# The source files can be found in the SPDX data repository:
# https://github.com/spdx/license-list-data.git

ptxd_make_spdx() {
    license="${1}"

    case "${license}" in
""" % (basename(sys.argv[0]), basename(sys.argv[1]), basename(sys.argv[2])))

lines = []
for l in data['licenses']:
    arg = ''
    if l['isDeprecatedLicenseId']:
        arg = 'deprecated="true" '
    elif l['isOsiApproved']:
        arg = 'osi="true" '
    lines.append("	{}) {};;\n".format(l['licenseId'], arg))

lines.sort(key=str.casefold)
for line in lines:
    outfile.write(line)

lines=[]
for l in ex_data['exceptions']:
    if l['isDeprecatedLicenseId']:
        continue
    lines.append("	{}) exception=\"true\" ;;\n".format(l['licenseExceptionId']))

lines.sort(key=str.casefold)
for line in lines:
    outfile.write(line)

outfile.write("""	*) return 1 ;;
    esac
}
export -f ptxd_make_spdx
""")
outfile.close()
