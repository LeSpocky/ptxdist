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
HOST_PACKAGES-$(PTXCONF_HOST_SYSTEM_PYTHON3_CHARDET) += host-system-python3-chardet

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_SYSTEM_PYTHON3_CHARDET_CONF_TOOL	:= python3

# vim: syntax=make
