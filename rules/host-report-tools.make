# -*-makefile-*-
#
# Copyright (C) 2025 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
LAZY_PACKAGES-$(PTXCONF_HOST_REPORT_TOOLS) += host-report-tools
HOST_REPORT_TOOLS_VERSION := 1
HOST_REPORT_TOOLS_LICENSE := ignore

# vim: syntax=make
