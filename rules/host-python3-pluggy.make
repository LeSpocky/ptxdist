# -*-makefile-*-
#
# Copyright (C) 2024 by Lars Pedersen <lapeddk@gmail.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_PYTHON3_PLUGGY) += host-python3-pluggy

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_PYTHON3_PLUGGY_CONF_TOOL	:= python3

# vim: syntax=make
