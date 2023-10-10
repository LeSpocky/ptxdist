# -*-makefile-*-
#
# Copyright (C) 2023 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_PYTHON3_FLIT_CORE) += host-python3-flit-core

#
# Paths and names
#
HOST_PYTHON3_FLIT_CORE_VERSION		:= 3.8.0
HOST_PYTHON3_FLIT_CORE_MD5		:= 7c41da13273f7787709a24f74e0f5a99
HOST_PYTHON3_FLIT_CORE			:= flit_core-$(HOST_PYTHON3_FLIT_CORE_VERSION)
HOST_PYTHON3_FLIT_CORE_SUFFIX		:= tar.gz
HOST_PYTHON3_FLIT_CORE_URL		:= $(call ptx/mirror-pypi, flit-core, $(HOST_PYTHON3_FLIT_CORE).$(HOST_PYTHON3_FLIT_CORE_SUFFIX))
HOST_PYTHON3_FLIT_CORE_SOURCE		:= $(SRCDIR)/$(HOST_PYTHON3_FLIT_CORE).$(HOST_PYTHON3_FLIT_CORE_SUFFIX)
HOST_PYTHON3_FLIT_CORE_DIR		:= $(HOST_BUILDDIR)/$(HOST_PYTHON3_FLIT_CORE)
HOST_PYTHON3_FLIT_CORE_LICENSE		:= BSD-3-Clause
HOST_PYTHON3_FLIT_CORE_LICENSE_FILES	:= \
	file://LICENSE;md5=41eb78fa8a872983a882c694a8305f08

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_PYTHON3_FLIT_CORE_CONF_TOOL	:= python3

# vim: syntax=make
