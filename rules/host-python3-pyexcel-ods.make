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
PACKAGES-$(PTXCONF_HOST_PYTHON3_PYEXCEL_ODS) += host-python3-pyexcel-ods

#
# Paths and names
#
HOST_PYTHON3_PYEXCEL_ODS_VERSION	:= 0.6.0
HOST_PYTHON3_PYEXCEL_ODS_MD5		:= bf9ebbe4ad0eb39b45e836a09dbc3c01
HOST_PYTHON3_PYEXCEL_ODS		:= pyexcel-ods-$(HOST_PYTHON3_PYEXCEL_ODS_VERSION)
HOST_PYTHON3_PYEXCEL_ODS_SUFFIX		:= tar.gz
HOST_PYTHON3_PYEXCEL_ODS_URL		:= $(call ptx/mirror-pypi, pyexcel-ods, $(HOST_PYTHON3_PYEXCEL_ODS).$(HOST_PYTHON3_PYEXCEL_ODS_SUFFIX))
HOST_PYTHON3_PYEXCEL_ODS_SOURCE		:= $(SRCDIR)/$(HOST_PYTHON3_PYEXCEL_ODS).$(HOST_PYTHON3_PYEXCEL_ODS_SUFFIX)
HOST_PYTHON3_PYEXCEL_ODS_DIR		:= $(HOST_BUILDDIR)/$(HOST_PYTHON3_PYEXCEL_ODS)
HOST_PYTHON3_PYEXCEL_ODS_LICENSE	:= BSD-3-Clause
HOST_PYTHON3_PYEXCEL_ODS_LICENSE_FILES	:= \
	file://README.rst;startline=317;endline=320;md5=1ba5f3aa42dab728d580a19d742471a2 \
	file://LICENSE;md5=03acf66140522d48eb77c81a7a02f15a

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_PYTHON3_PYEXCEL_ODS_CONF_TOOL	:= python3

# vim: syntax=make
