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
HOST_PACKAGES-$(PTXCONF_HOST_PYTHON3_PYBUILD) += host-python3-pybuild

#
# Paths and names
#
HOST_PYTHON3_PYBUILD_VERSION		:= 0.10.0
HOST_PYTHON3_PYBUILD_SHA256		:= d5b71264afdb5951d6704482aac78de887c80691c52b88a9ad195983ca2c9269
HOST_PYTHON3_PYBUILD			:= build-$(HOST_PYTHON3_PYBUILD_VERSION)
HOST_PYTHON3_PYBUILD_SUFFIX		:= tar.gz
HOST_PYTHON3_PYBUILD_URL		:= $(call ptx/mirror-pypi, build, $(HOST_PYTHON3_PYBUILD).$(HOST_PYTHON3_PYBUILD_SUFFIX))
HOST_PYTHON3_PYBUILD_SOURCE		:= $(SRCDIR)/$(HOST_PYTHON3_PYBUILD).$(HOST_PYTHON3_PYBUILD_SUFFIX)
HOST_PYTHON3_PYBUILD_DIR		:= $(HOST_BUILDDIR)/$(HOST_PYTHON3_PYBUILD)
HOST_PYTHON3_PYBUILD_LICENSE		:= MIT
HOST_PYTHON3_PYBUILD_LICENSE_FILES	:= \
	file://LICENSE;md5=310439af287b0fb4780b2ad6907c256c

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_PYTHON3_PYBUILD_CONF_TOOL	:= python3

# vim: syntax=make
