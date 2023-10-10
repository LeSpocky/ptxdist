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
HOST_PACKAGES-$(PTXCONF_HOST_PYTHON3_PACKAGING) += host-python3-packaging

#
# Paths and names
#
HOST_PYTHON3_PACKAGING_VERSION		:= 23.1
HOST_PYTHON3_PACKAGING_MD5		:= f7d5c39c6f92cc2dfa1293ba8f6c097c
HOST_PYTHON3_PACKAGING			:= packaging-$(HOST_PYTHON3_PACKAGING_VERSION)
HOST_PYTHON3_PACKAGING_SUFFIX		:= tar.gz
HOST_PYTHON3_PACKAGING_URL		:= $(call ptx/mirror-pypi, packaging, $(HOST_PYTHON3_PACKAGING).$(HOST_PYTHON3_PACKAGING_SUFFIX))
HOST_PYTHON3_PACKAGING_SOURCE		:= $(SRCDIR)/$(HOST_PYTHON3_PACKAGING).$(HOST_PYTHON3_PACKAGING_SUFFIX)
HOST_PYTHON3_PACKAGING_DIR		:= $(HOST_BUILDDIR)/$(HOST_PYTHON3_PACKAGING)
HOST_PYTHON3_PACKAGING_LICENSE		:= Apache-2.0 OR BSD-2-Clause
HOST_PYTHON3_PACKAGING_LICENSE_FILES	:= \
	file://LICENSE;md5=faadaedca9251a90b205c9167578ce91 \
	file://LICENSE.APACHE;md5=2ee41112a44fe7014dce33e26468ba93 \
	file://LICENSE.BSD;md5=7bef9bf4a8e4263634d0597e7ba100b8

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_PYTHON3_PACKAGING_CONF_TOOL	:= python3

# vim: syntax=make
