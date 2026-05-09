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
PACKAGES-$(PTXCONF_PYTHON3_PYBIND11) += python3-pybind11

#
# Paths and names
#
PYTHON3_PYBIND11_VERSION	:= 2.13.6
PYTHON3_PYBIND11_SHA256		:= e08cb87f4773da97fa7b5f035de8763abc656d87d5773e62f6da0587d1f0ec20
PYTHON3_PYBIND11		:= pybind11-$(PYTHON3_PYBIND11_VERSION)
PYTHON3_PYBIND11_SUFFIX		:= tar.gz
PYTHON3_PYBIND11_URL		:= https://github.com/pybind/pybind11/archive/refs/tags/v$(PYTHON3_PYBIND11_VERSION).$(PYTHON3_PYBIND11_SUFFIX)
PYTHON3_PYBIND11_SOURCE		:= $(SRCDIR)/$(PYTHON3_PYBIND11).$(PYTHON3_PYBIND11_SUFFIX)
PYTHON3_PYBIND11_DIR		:= $(BUILDDIR)/$(PYTHON3_PYBIND11)
PYTHON3_PYBIND11_LICENSE	:= BSD-3-Clause
PYTHON3_PYBIND11_LICENSE_FILES	:= \
	file://LICENSE;md5=774f65abd8a7fe3124be2cdf766cd06f

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_PYBIND11_CONF_TOOL	:= cmake
PYTHON3_PYBIND11_CONF_OPT	:= \
	$(CROSS_CMAKE_USR) \
	-DPYBIND11_FINDPYTHON=ON \
	-DPYBIND11_TEST=OFF

# vim: syntax=make
