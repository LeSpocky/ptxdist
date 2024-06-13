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
HOST_PACKAGES-$(PTXCONF_HOST_PYTHON3_DUNAMAI) += host-python3-dunamai

#
# Paths and names
#
HOST_PYTHON3_DUNAMAI_VERSION		:= 1.21.1
HOST_PYTHON3_DUNAMAI_MD5		:= 43868303aea63df705bedff7f77bd2c6
HOST_PYTHON3_DUNAMAI			:= dunamai-$(HOST_PYTHON3_DUNAMAI_VERSION)
HOST_PYTHON3_DUNAMAI_SUFFIX		:= tar.gz
HOST_PYTHON3_DUNAMAI_URL		:= $(call ptx/mirror-pypi, dunamai, $(HOST_PYTHON3_DUNAMAI).$(HOST_PYTHON3_DUNAMAI_SUFFIX))
HOST_PYTHON3_DUNAMAI_SOURCE		:= $(SRCDIR)/$(HOST_PYTHON3_DUNAMAI).$(HOST_PYTHON3_DUNAMAI_SUFFIX)
HOST_PYTHON3_DUNAMAI_DIR		:= $(HOST_BUILDDIR)/$(HOST_PYTHON3_DUNAMAI)
HOST_PYTHON3_DUNAMAI_LICENSE		:= MIT
HOST_PYTHON3_DUNAMAI_LICENSE_FILES	:= \
	file://PKG-INFO;startline=6;endline=6;md5=8227180126797a0148f94f483f3e1489 \
	file://LICENSE;md5=059eed55dbfd3fea022510ea62c95dc1

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_PYTHON3_DUNAMAI_CONF_TOOL	:= python3

# vim: syntax=make
