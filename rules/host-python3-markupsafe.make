# -*-makefile-*-
#
# Copyright (C) 2024 by Roland Hieber <rhi@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_PYTHON3_MARKUPSAFE) += host-python3-markupsafe

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# python3
#
HOST_PYTHON3_MARKUPSAFE_CONF_TOOL	:= python3

# vim: syntax=make
