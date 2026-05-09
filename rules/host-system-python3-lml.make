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
HOST_PACKAGES-$(PTXCONF_HOST_SYSTEM_PYTHON3_LML) += host-system-python3-lml

#
# Paths and names
#
HOST_SYSTEM_PYTHON3_LML_VERSION		:= 0.1.0
HOST_SYSTEM_PYTHON3_LML_SHA256		:= 57a085a29bb7991d70d41c6c3144c560a8e35b4c1030ffb36d85fa058773bcc5
HOST_SYSTEM_PYTHON3_LML			:= lml-$(HOST_SYSTEM_PYTHON3_LML_VERSION)
HOST_SYSTEM_PYTHON3_LML_SUFFIX		:= tar.gz
HOST_SYSTEM_PYTHON3_LML_URL		:= $(call ptx/mirror-pypi, lml, $(HOST_SYSTEM_PYTHON3_LML).$(HOST_SYSTEM_PYTHON3_LML_SUFFIX))
HOST_SYSTEM_PYTHON3_LML_SOURCE		:= $(SRCDIR)/$(HOST_SYSTEM_PYTHON3_LML).$(HOST_SYSTEM_PYTHON3_LML_SUFFIX)
HOST_SYSTEM_PYTHON3_LML_DIR		:= $(HOST_BUILDDIR)/$(HOST_SYSTEM_PYTHON3_LML)
HOST_SYSTEM_PYTHON3_LML_LICENSE		:= BSD-3-Clause
HOST_SYSTEM_PYTHON3_LML_LICENSE_FILES	:= \
	file://LICENSE;md5=d198151b332e43a8c14f362d29fbcce3 \
	file://README.rst;startline=119;md5=f740ef1e2236d5b27ed6a0498d939e75

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_SYSTEM_PYTHON3_LML_CONF_TOOL	:= python3

# vim: syntax=make
