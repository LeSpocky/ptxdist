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
HOST_PACKAGES-$(PTXCONF_HOST_PYTHON3_INSTALLER) += host-python3-installer

#
# Paths and names
#
HOST_PYTHON3_INSTALLER_VERSION		:= 0.7.0
HOST_PYTHON3_INSTALLER_SHA256		:= a26d3e3116289bb08216e0d0f7d925fcef0b0194eedfa0c944bcaaa106c4b631
HOST_PYTHON3_INSTALLER			:= installer-$(HOST_PYTHON3_INSTALLER_VERSION)
HOST_PYTHON3_INSTALLER_SUFFIX		:= tar.gz
HOST_PYTHON3_INSTALLER_URL		:= $(call ptx/mirror-pypi, installer, $(HOST_PYTHON3_INSTALLER).$(HOST_PYTHON3_INSTALLER_SUFFIX))
HOST_PYTHON3_INSTALLER_SOURCE		:= $(SRCDIR)/$(HOST_PYTHON3_INSTALLER).$(HOST_PYTHON3_INSTALLER_SUFFIX)
HOST_PYTHON3_INSTALLER_DIR		:= $(HOST_BUILDDIR)/$(HOST_PYTHON3_INSTALLER)
HOST_PYTHON3_INSTALLER_LICENSE		:= MIT
HOST_PYTHON3_INSTALLER_LICENSE_FILES	:= \
	file://LICENSE;md5=5038641aec7a77451e31da828ebfae00

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_PYTHON3_INSTALLER_CONF_TOOL	:= python3

# vim: syntax=make
