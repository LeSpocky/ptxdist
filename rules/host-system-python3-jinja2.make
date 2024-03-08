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
HOST_PACKAGES-$(PTXCONF_HOST_SYSTEM_PYTHON3_JINJA2) += host-system-python3-jinja2

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_SYSTEM_PYTHON3_JINJA2_CONF_TOOL	:= python3

# vim: syntax=make
