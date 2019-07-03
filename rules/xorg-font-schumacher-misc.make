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
PACKAGES-$(PTXCONF_XORG_FONT_SCHUMACHER_MISC) += xorg-font-schumacher-misc

#
# Paths and names
#
XORG_FONT_SCHUMACHER_MISC_VERSION	:= 1.1.2
XORG_FONT_SCHUMACHER_MISC_MD5		:= e805feb7c4f20e6bfb1118d19d972219
XORG_FONT_SCHUMACHER_MISC		:= font-schumacher-misc-$(XORG_FONT_SCHUMACHER_MISC_VERSION)
XORG_FONT_SCHUMACHER_MISC_SUFFIX	:= tar.bz2
XORG_FONT_SCHUMACHER_MISC_URL		:= $(call ptx/mirror, XORG, individual/font/$(XORG_FONT_SCHUMACHER_MISC).$(XORG_FONT_SCHUMACHER_MISC_SUFFIX))
XORG_FONT_SCHUMACHER_MISC_SOURCE	:= $(SRCDIR)/$(XORG_FONT_SCHUMACHER_MISC).$(XORG_FONT_SCHUMACHER_MISC_SUFFIX)
XORG_FONT_SCHUMACHER_MISC_DIR		:= $(BUILDDIR)/$(XORG_FONT_SCHUMACHER_MISC)

ifdef PTXCONF_XORG_FONT_SCHUMACHER_MISC
$(STATEDIR)/xorg-fonts.targetinstall.post: $(STATEDIR)/xorg-font-schumacher-misc.targetinstall
endif

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_FONT_SCHUMACHER_MISC_PATH	:= PATH=$(CROSS_PATH)
XORG_FONT_SCHUMACHER_MISC_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_FONT_SCHUMACHER_MISC_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-schumacher-misc.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-schumacher-misc.targetinstall:
	@$(call targetinfo)

	@mkdir -p $(XORG_FONTS_DIR_INSTALL)/misc

	@find $(XORG_FONT_SCHUMACHER_MISC_DIR) \
		-name "*.pcf.gz" -a \! -name "*ISO8859*" -a \! -name "*KOI*" \
		-o -name "*ISO8859-1.pcf.gz" \
		-o -name "*ISO8859-15.pcf.gz" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/misc; \
	done

# FIXME: care about KOI fonts

ifdef PTXCONF_XORG_FONT_SCHUMACHER_MISC_TRANS
	@find $(XORG_FONT_SCHUMACHER_MISC_DIR) \
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
