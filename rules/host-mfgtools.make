# -*-makefile-*-
#
# Copyright (C) 2020 by Denis Osterland-Heim <Denis.Osterland@diehl.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

HOST_PACKAGES-$(PTXCONF_HOST_MFGTOOLS) += host-mfgtools

#
# Paths and names
#
HOST_MFGTOOLS_VERSION	:= 1.4.43
HOST_MFGTOOLS_MD5	:= a2bebba983cf9ecce1499c86d38afa78
HOST_MFGTOOLS		:= mfgtools-$(HOST_MFGTOOLS_VERSION)
HOST_MFGTOOLS_SUFFIX	:= tar.gz
HOST_MFGTOOLS_URL	:= https://github.com/NXPmicro/mfgtools/releases/download/uuu_$(HOST_MFGTOOLS_VERSION)/uuu_source-$(HOST_MFGTOOLS_VERSION).$(HOST_MFGTOOLS_SUFFIX)
HOST_MFGTOOLS_SOURCE	:= $(SRCDIR)/$(HOST_MFGTOOLS).$(HOST_MFGTOOLS_SUFFIX)
HOST_MFGTOOLS_DIR	:= $(HOST_BUILDDIR)/$(HOST_MFGTOOLS)
HOST_MFGTOOLS_LICENSE	:= BSD-3-Clause
HOST_MFGTOOLS_LICENSE_FILES	:= \
	file://LICENSE;md5=38ec0c18112e9a92cffc4951661e85a5

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_MFGTOOLS_CONF_TOOL	:= cmake
HOST_MFGTOOLS_CONF_OPT := \
	$(HOST_CMAKE_OPT) \
	-DBUILD_DOC=OFF

# vim: syntax=make
