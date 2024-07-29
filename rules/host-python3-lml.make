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
PACKAGES-$(PTXCONF_HOST_PYTHON3_LML) += host-python3-lml

#
# Paths and names
#
HOST_PYTHON3_LML_VERSION	:= 0.1.0
HOST_PYTHON3_LML_MD5		:= df74fb9e2298f416d3364d382912a7d3
HOST_PYTHON3_LML		:= lml-$(HOST_PYTHON3_LML_VERSION)
HOST_PYTHON3_LML_SUFFIX		:= tar.gz
HOST_PYTHON3_LML_URL		:= $(call ptx/mirror-pypi, lml, $(HOST_PYTHON3_LML).$(HOST_PYTHON3_LML_SUFFIX))
HOST_PYTHON3_LML_SOURCE		:= $(SRCDIR)/$(HOST_PYTHON3_LML).$(HOST_PYTHON3_LML_SUFFIX)
HOST_PYTHON3_LML_DIR		:= $(HOST_BUILDDIR)/$(HOST_PYTHON3_LML)
HOST_PYTHON3_LML_LICENSE	:= BSD-3-Clause
HOST_PYTHON3_LML_LICENSE_FILES	:= \
	file://LICENSE;md5=d198151b332e43a8c14f362d29fbcce3 \
	file://README.rst;startline=119;md5=f740ef1e2236d5b27ed6a0498d939e75

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_PYTHON3_LML_CONF_TOOL	:= python3

# vim: syntax=make
