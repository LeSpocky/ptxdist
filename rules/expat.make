# -*-makefile-*-
#
# Copyright (C) 2003 by Robert Schwebel <r.schwebel@pengutronix.de>
#                       Pengutronix <info@pengutronix.de>, Germany
#               2007, 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_EXPAT) += expat

#
# Paths and names
#
EXPAT_VERSION		:= 2.8.0
EXPAT_SHA256		:= 586494499ac3ad46d87f3beda7b1f770c1c8026a9b60e151593f8b29089a52ca
EXPAT			:= expat-$(EXPAT_VERSION)
EXPAT_SUFFIX		:= tar.bz2
EXPAT_RELEASE		:= R_$(subst .,_,$(EXPAT_VERSION))
EXPAT_URL		:= https://github.com/libexpat/libexpat/releases/download/$(EXPAT_RELEASE)/$(EXPAT).$(EXPAT_SUFFIX)
EXPAT_SOURCE		:= $(SRCDIR)/$(EXPAT).$(EXPAT_SUFFIX)
EXPAT_DIR		:= $(BUILDDIR)/$(EXPAT)
EXPAT_LICENSE		:= MIT
EXPAT_LICENSE_FILES	:= \
	file://COPYING;md5=f4fedd6116da0e171f7cb4d2923d7ac2
EXPAT_CVE_PRODUCT	:= libexpat_project:libexpat

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
EXPAT_CONF_TOOL	:= autoconf
EXPAT_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-static \
	--disable-symbol-versioning \
	--enable-xml-attr-info \
	--enable-xml-context \
	--without-xmlwf \
	--without-examples \
	--without-tests \
	--with-getrandom \
	--without-sys-getrandom \
	--without-docbook

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/expat.targetinstall:
	@$(call targetinfo)

	@$(call install_init, expat)
	@$(call install_fixup, expat,PRIORITY,optional)
	@$(call install_fixup, expat,SECTION,base)
	@$(call install_fixup, expat,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, expat,DESCRIPTION,missing)

	@$(call install_lib, expat, 0, 0, 0644, libexpat)

	@$(call install_finish, expat)

	@$(call touch)

# vim: syntax=make
