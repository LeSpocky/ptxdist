# -*-makefile-*-
#
# Copyright (C) 2025 by Thorsten Scherer <t.scherer@eckelmann.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_SYSTEM_PYTHON3_XMLTODICT) += host-system-python3-xmltodict

#
# Paths and names
#
HOST_SYSTEM_PYTHON3_XMLTODICT_VERSION		:= 1.0.2
HOST_SYSTEM_PYTHON3_XMLTODICT_MD5		:= 82d8cb5a934a057e6a8a3449b1d87cce
HOST_SYSTEM_PYTHON3_XMLTODICT			:= xmltodict-$(HOST_SYSTEM_PYTHON3_XMLTODICT_VERSION)
HOST_SYSTEM_PYTHON3_XMLTODICT_SUFFIX		:= tar.gz
HOST_SYSTEM_PYTHON3_XMLTODICT_URL		:= $(call ptx/mirror-pypi, xmltodict, $(HOST_SYSTEM_PYTHON3_XMLTODICT).$(HOST_SYSTEM_PYTHON3_XMLTODICT_SUFFIX))
HOST_SYSTEM_PYTHON3_XMLTODICT_SOURCE		:= $(SRCDIR)/$(HOST_SYSTEM_PYTHON3_XMLTODICT).$(HOST_SYSTEM_PYTHON3_XMLTODICT_SUFFIX)
HOST_SYSTEM_PYTHON3_XMLTODICT_DIR		:= $(HOST_BUILDDIR)/$(HOST_SYSTEM_PYTHON3_XMLTODICT)
HOST_SYSTEM_PYTHON3_XMLTODICT_LICENSE		:= MIT
HOST_SYSTEM_PYTHON3_XMLTODICT_LICENSE_FILES	:= \
	file://LICENSE;md5=01441d50dc74476db58a41ac10cb9fa2

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_SYSTEM_PYTHON3_XMLTODICT_CONF_TOOL	:= python3

# vim: ft=make
