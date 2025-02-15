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
HOST_PACKAGES-$(PTXCONF_HOST_PYTHON3_EXPANDVARS) += host-python3-expandvars

#
# Paths and names
#
HOST_PYTHON3_EXPANDVARS_VERSION		:= 0.12.0
HOST_PYTHON3_EXPANDVARS_MD5		:= 8091f578a547e2b4b9df59100a179266
HOST_PYTHON3_EXPANDVARS			:= expandvars-$(HOST_PYTHON3_EXPANDVARS_VERSION)
HOST_PYTHON3_EXPANDVARS_SUFFIX		:= tar.gz
HOST_PYTHON3_EXPANDVARS_URL		:= $(call ptx/mirror-pypi, expandvars, $(HOST_PYTHON3_EXPANDVARS).$(HOST_PYTHON3_EXPANDVARS_SUFFIX))
HOST_PYTHON3_EXPANDVARS_SOURCE		:= $(SRCDIR)/$(HOST_PYTHON3_EXPANDVARS).$(HOST_PYTHON3_EXPANDVARS_SUFFIX)
HOST_PYTHON3_EXPANDVARS_DIR		:= $(HOST_BUILDDIR)/$(HOST_PYTHON3_EXPANDVARS)
HOST_PYTHON3_EXPANDVARS_LICENSE		:= MIT
HOST_PYTHON3_EXPANDVARS_LICENSE_FILES	:= file://LICENSE;md5=8b2e744064bd184728ac09dbfb52aaf4

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_PYTHON3_EXPANDVARS_CONF_TOOL	:= python3

# vim: syntax=make
