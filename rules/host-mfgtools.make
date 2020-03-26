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
HOST_MFGTOOLS_VERSION	:= 1.3.154
HOST_MFGTOOLS_MD5	:= dd97a479db92b70a36c15d834f1e503c
HOST_MFGTOOLS		:= mfgtools-$(HOST_MFGTOOLS_VERSION)
HOST_MFGTOOLS_SUFFIX	:= tar.gz
HOST_MFGTOOLS_URL	:= https://github.com/NXPmicro/mfgtools/archive/uuu_$(HOST_MFGTOOLS_VERSION).$(HOST_MFGTOOLS_SUFFIX)
HOST_MFGTOOLS_SOURCE	:= $(SRCDIR)/$(HOST_MFGTOOLS).$(HOST_MFGTOOLS_SUFFIX)
HOST_MFGTOOLS_DIR	:= $(HOST_BUILDDIR)/$(HOST_MFGTOOLS)
HOST_MFGTOOLS_LICENSE	:= BSD-3-Clause
HOST_MFGTOOLS_LICENSE_FILES	:= \
	file://LICENSE;md5=38ec0c18112e9a92cffc4951661e85a5

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/host-mfgtools.extract.post:
	@$(call targetinfo)
	@$(call world/patchin/post, HOST_MFGTOOLS)
	@echo "uuu_$(HOST_MFGTOOLS_VERSION)" > $(HOST_MFGTOOLS_DIR)/.tarball-version
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_MFGTOOLS_CONF_TOOL	:= cmake

# vim: syntax=make
