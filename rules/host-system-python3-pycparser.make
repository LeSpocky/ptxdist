# -*-makefile-*-
#
# Copyright (C) 2024 by Philipp Zabel <p.zabel@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_SYSTEM_PYTHON3_PYCPARSER) += host-system-python3-pycparser

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_SYSTEM_PYTHON3_PYCPARSER_CONF_TOOL	:= python3

# vim: syntax=make
