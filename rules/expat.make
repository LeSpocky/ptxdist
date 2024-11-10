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
EXPAT_VERSION		:= 2.6.4
EXPAT_MD5		:= f1acfb75967648230d37629e02afbadc
EXPAT			:= expat-$(EXPAT_VERSION)
EXPAT_SUFFIX		:= tar.bz2
EXPAT_RELEASE		:= R_$(subst .,_,$(EXPAT_VERSION))
EXPAT_URL		:= https://github.com/libexpat/libexpat/releases/download/$(EXPAT_RELEASE)/$(EXPAT).$(EXPAT_SUFFIX)
EXPAT_SOURCE		:= $(SRCDIR)/$(EXPAT).$(EXPAT_SUFFIX)
EXPAT_DIR		:= $(BUILDDIR)/$(EXPAT)
EXPAT_LICENSE		:= MIT
EXPAT_LICENSE_FILES	:= \
	file://COPYING;md5=7b3b078238d0901d3b339289117cb7fb

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
	--enable-xml-attr-info \
	--enable-xml-context \
	--without-xmlwf \
	--without-examples \
	--without-tests \
	--without-libbsd \
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
