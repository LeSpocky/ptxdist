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
PACKAGES-$(PTXCONF_BROTLI) += brotli

#
# Paths and names
#
BROTLI_VERSION		:= 1.1.0
BROTLI_MD5		:= 3a6a3dba82a3604792d3cb0bd41bca60
BROTLI			:= brotli-$(BROTLI_VERSION)
BROTLI_SUFFIX		:= tar.gz
BROTLI_URL		:= https://github.com/google/brotli/archive/refs/tags/v$(BROTLI_VERSION).$(BROTLI_SUFFIX)
BROTLI_SOURCE		:= $(SRCDIR)/$(BROTLI).$(BROTLI_SUFFIX)
BROTLI_DIR		:= $(BUILDDIR)/$(BROTLI)
BROTLI_LICENSE		:= MIT
BROTLI_LICENSE_FILES	:= \
	file://LICENSE;md5=941ee9cd1609382f946352712a319b4b

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# cmake
#
BROTLI_CONF_TOOL	:= cmake
BROTLI_CONF_OPT	:=  \
	$(CROSS_CMAKE_USR) \
	-DBUILD_SHARED_LIBS=ON \
	-DBUILD_TESTING=OFF

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/brotli.targetinstall:
	@$(call targetinfo)

	@$(call install_init, brotli)
	@$(call install_fixup, brotli,PRIORITY,optional)
	@$(call install_fixup, brotli,SECTION,base)
	@$(call install_fixup, brotli,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, brotli,DESCRIPTION,missing)

	@$(call install_lib, brotli, 0, 0, 0644, libbrotlicommon)
	@$(call install_lib, brotli, 0, 0, 0644, libbrotlidec)
	@$(call install_lib, brotli, 0, 0, 0644, libbrotlienc)

	@$(call install_finish, brotli)

	@$(call touch)

# vim: syntax=make
