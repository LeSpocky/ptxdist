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
PACKAGES-$(PTXCONF_HOST_PYTHON3_PYEXCEL_IO) += host-python3-pyexcel-io

#
# Paths and names
#
HOST_PYTHON3_PYEXCEL_IO_VERSION		:= 0.6.6
HOST_PYTHON3_PYEXCEL_IO_MD5		:= e06252a039ccee3d9d2ebd0696fbc453
HOST_PYTHON3_PYEXCEL_IO			:= pyexcel-io-$(HOST_PYTHON3_PYEXCEL_IO_VERSION)
HOST_PYTHON3_PYEXCEL_IO_SUFFIX		:= tar.gz
HOST_PYTHON3_PYEXCEL_IO_URL		:= $(call ptx/mirror-pypi, pyexcel-io, $(HOST_PYTHON3_PYEXCEL_IO).$(HOST_PYTHON3_PYEXCEL_IO_SUFFIX))
HOST_PYTHON3_PYEXCEL_IO_SOURCE		:= $(SRCDIR)/$(HOST_PYTHON3_PYEXCEL_IO).$(HOST_PYTHON3_PYEXCEL_IO_SUFFIX)
HOST_PYTHON3_PYEXCEL_IO_DIR		:= $(HOST_BUILDDIR)/$(HOST_PYTHON3_PYEXCEL_IO)
HOST_PYTHON3_PYEXCEL_IO_LICENSE		:= BSD-3-Clause
HOST_PYTHON3_PYEXCEL_IO_LICENSE_FILES	:= \
	file://README.rst;startline=244;md5=1ba5f3aa42dab728d580a19d742471a2 \
	file://LICENSE;md5=3508ad9ab698c16f7ffac9fda4b0aa01

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_PYTHON3_PYEXCEL_IO_CONF_TOOL	:= python3

# vim: syntax=make
