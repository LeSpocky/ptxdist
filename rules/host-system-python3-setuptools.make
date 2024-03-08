# -*-makefile-*-
#
# Copyright (C) 2024 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_SYSTEM_PYTHON3_SETUPTOOLS) += host-system-python3-setuptools

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_SYSTEM_PYTHON3_SETUPTOOLS_CONF_TOOL	:= python3

# vim: syntax=make
