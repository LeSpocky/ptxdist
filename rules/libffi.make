# -*-makefile-*-
#
# Copyright (C) 2008 by Robert Schwebel <r.schwebel@pengutronix.de>
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBFFI) += libffi

#
# Paths and names
#
LIBFFI_VERSION	:= 3.4.2
LIBFFI_MD5	:= 294b921e6cf9ab0fbaea4b639f8fdbe8
LIBFFI		:= libffi-$(LIBFFI_VERSION)
LIBFFI_SUFFIX	:= tar.gz
LIBFFI_SOURCE	:= $(SRCDIR)/$(LIBFFI).$(LIBFFI_SUFFIX)
LIBFFI_DIR	:= $(BUILDDIR)/$(LIBFFI)
LIBFFI_URL	:= \
	https://github.com/libffi/libffi/releases/download/v$(LIBFFI_VERSION)/$(LIBFFI).$(LIBFFI_SUFFIX) \
	ftp://sourceware.org/pub/libffi/$(LIBFFI).$(LIBFFI_SUFFIX)
LIBFFI_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBFFI_CONF_TOOL := autoconf
LIBFFI_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--disable-static \
	--enable-portable-binary \
	--disable-pax_emutramp \
	--disable-debug \
	--enable-structs \
	--enable-raw-api \
	--disable-purify-safety \
	--without-gcc-arch

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libffi.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libffi)
	@$(call install_fixup, libffi,PRIORITY,optional)
	@$(call install_fixup, libffi,SECTION,base)
	@$(call install_fixup, libffi,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libffi,DESCRIPTION,missing)

	@$(call install_lib, libffi, 0, 0, 0644, libffi)

	@$(call install_finish, libffi)

	@$(call touch)

# vim: syntax=make
