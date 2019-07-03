# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_FONT_MISC_MISC) += xorg-font-misc-misc

#
# Paths and names
#
XORG_FONT_MISC_MISC_VERSION	:= 1.1.2
XORG_FONT_MISC_MISC_MD5		:= c88eb44b3b903d79fb44b860a213e623
XORG_FONT_MISC_MISC		:= font-misc-misc-$(XORG_FONT_MISC_MISC_VERSION)
XORG_FONT_MISC_MISC_SUFFIX	:= tar.bz2
XORG_FONT_MISC_MISC_URL		:= $(call ptx/mirror, XORG, individual/font/$(XORG_FONT_MISC_MISC).$(XORG_FONT_MISC_MISC_SUFFIX))
XORG_FONT_MISC_MISC_SOURCE	:= $(SRCDIR)/$(XORG_FONT_MISC_MISC).$(XORG_FONT_MISC_MISC_SUFFIX)
XORG_FONT_MISC_MISC_DIR		:= $(BUILDDIR)/$(XORG_FONT_MISC_MISC)

ifdef PTXCONF_XORG_FONT_MISC_MISC
$(STATEDIR)/xorg-fonts.targetinstall.post: $(STATEDIR)/xorg-font-misc-misc.targetinstall
endif

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_FONT_MISC_MISC_PATH	:= PATH=$(CROSS_PATH)
XORG_FONT_MISC_MISC_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_FONT_MISC_MISC_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-fontdir=$(XORG_FONTDIR)/misc

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-misc-misc.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-misc-misc.targetinstall:
	@$(call targetinfo)

	@mkdir -p $(XORG_FONTS_DIR_INSTALL)/misc

	@find $(XORG_FONT_MISC_MISC_DIR) \
		-name "*.pcf.gz" -a \! -name "*ISO8859*" -a \! -name "*KOI*" \
		-o -name "*ISO8859-1.pcf.gz" \
		-o -name "*ISO8859-15.pcf.gz" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/misc; \
	done

# FIXME: care about KOI fonts

ifdef PTXCONF_XORG_FONT_MISC_MISC_TRANS
	@find $(XORG_FONT_MISC_MISC_DIR) \
		-name "*ISO8859-2.pcf.gz" \
		-o -name "*ISO8859-3.pcf.gz" \
		-o -name "*ISO8859-4.pcf.gz" \
		-o -name "*ISO8859-5.pcf.gz" \
		-o -name "*ISO8859-6.pcf.gz" \
		-o -name "*ISO8859-7.pcf.gz" \
		-o -name "*ISO8859-8.pcf.gz" \
		-o -name "*ISO8859-9.pcf.gz" \
		-o -name "*ISO8859-10.pcf.gz" \
		-o -name "*ISO8859-13.pcf.gz" \
		-o -name "*ISO8859-14.pcf.gz" \
		-o -name "*ISO8859-16.pcf.gz" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/misc; \
	done
endif

	@$(call touch)

# vim: syntax=make
