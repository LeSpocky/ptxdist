# -*-makefile-*-
#
# Copyright (C) 2022 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_PYTHON3_PIP) += host-python3-pip

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# python3
#
HOST_PYTHON3_PIP_CONF_TOOL	:= python3

# vim: syntax=make
