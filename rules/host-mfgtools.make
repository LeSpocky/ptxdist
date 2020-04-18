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
HOST_MFGTOOLS_VERSION	:= 1.3.167
HOST_MFGTOOLS_MD5	:= 08fba433dd11525c9b425ad1ff91b85b
HOST_MFGTOOLS		:= mfgtools-$(HOST_MFGTOOLS_VERSION)
HOST_MFGTOOLS_SUFFIX	:= tar.gz
HOST_MFGTOOLS_URL	:= https://github.com/NXPmicro/mfgtools/releases/download/uuu_$(HOST_MFGTOOLS_VERSION)/uuu_source-$(HOST_MFGTOOLS_VERSION).$(HOST_MFGTOOLS_SUFFIX)
HOST_MFGTOOLS_SOURCE	:= $(SRCDIR)/$(HOST_MFGTOOLS).$(HOST_MFGTOOLS_SUFFIX)
HOST_MFGTOOLS_DIR	:= $(HOST_BUILDDIR)/$(HOST_MFGTOOLS)
# needed to handle broken archive
HOST_MFGTOOLS_SUBDIR	:= uuu_source-$(HOST_MFGTOOLS_VERSION)
HOST_MFGTOOLS_STRIP_LEVEL := 0
HOST_MFGTOOLS_LICENSE	:= BSD-3-Clause
HOST_MFGTOOLS_LICENSE_FILES	:= \
	file://$(HOST_MFGTOOLS_SUBDIR)/LICENSE;md5=38ec0c18112e9a92cffc4951661e85a5

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/host-mfgtools.extract.post:
	@$(call targetinfo)
	@$(call world/patchin/post, HOST_MFGTOOLS)
#	# .tarball-version is in the wrong subdirectory
	@cp $(HOST_MFGTOOLS_DIR)/uuu-$(HOST_MFGTOOLS_VERSION)/.tarball-version \
		$(HOST_MFGTOOLS_DIR)/$(HOST_MFGTOOLS_SUBDIR)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_MFGTOOLS_CONF_TOOL	:= cmake
HOST_MFGTOOLS_CONF_OPT := \
	$(HOST_CMAKE_OPT) \
	-DBUILD_DOC=OFF

# vim: syntax=make
