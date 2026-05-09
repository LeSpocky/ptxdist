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
HOST_PACKAGES-$(PTXCONF_HOST_SYSTEM_PYTHON3_DEFUSEDXML) += host-system-python3-defusedxml

#
# Paths and names
#
HOST_SYSTEM_PYTHON3_DEFUSEDXML_VERSION		:= 0.7.1
HOST_SYSTEM_PYTHON3_DEFUSEDXML_SHA256		:= 1bb3032db185915b62d7c6209c5a8792be6a32ab2fedacc84e01b52c51aa3e69
HOST_SYSTEM_PYTHON3_DEFUSEDXML			:= defusedxml-$(HOST_SYSTEM_PYTHON3_DEFUSEDXML_VERSION)
HOST_SYSTEM_PYTHON3_DEFUSEDXML_SUFFIX		:= tar.gz
HOST_SYSTEM_PYTHON3_DEFUSEDXML_URL		:= $(call ptx/mirror-pypi, defusedxml, $(HOST_SYSTEM_PYTHON3_DEFUSEDXML).$(HOST_SYSTEM_PYTHON3_DEFUSEDXML_SUFFIX))
HOST_SYSTEM_PYTHON3_DEFUSEDXML_SOURCE		:= $(SRCDIR)/$(HOST_SYSTEM_PYTHON3_DEFUSEDXML).$(HOST_SYSTEM_PYTHON3_DEFUSEDXML_SUFFIX)
HOST_SYSTEM_PYTHON3_DEFUSEDXML_DIR		:= $(HOST_BUILDDIR)/$(HOST_SYSTEM_PYTHON3_DEFUSEDXML)
HOST_SYSTEM_PYTHON3_DEFUSEDXML_LICENSE		:= PSF-2.0
HOST_SYSTEM_PYTHON3_DEFUSEDXML_LICENSE_FILES	:= \
	file://LICENSE;md5=056fea6a4b395a24d0d278bf5c80249e \
	file://README.txt;startline=744;endline=751;md5=1dd9120c8d54c15916a5b246f5797f40

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# python3
#
HOST_SYSTEM_PYTHON3_DEFUSEDXML_CONF_TOOL	:= python3

# vim: syntax=make
