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
PACKAGES-$(PTXCONF_XORG_FONT_SCREEN_CYRILLIC) += xorg-font-screen-cyrillic

#
# Paths and names
#
XORG_FONT_SCREEN_CYRILLIC_VERSION	:= 1.0.4
XORG_FONT_SCREEN_CYRILLIC_MD5		:= 6f3fdcf2454bf08128a651914b7948ca
XORG_FONT_SCREEN_CYRILLIC		:= font-screen-cyrillic-$(XORG_FONT_SCREEN_CYRILLIC_VERSION)
XORG_FONT_SCREEN_CYRILLIC_SUFFIX	:= tar.bz2
XORG_FONT_SCREEN_CYRILLIC_URL		:= $(call ptx/mirror, XORG, individual/font/$(XORG_FONT_SCREEN_CYRILLIC).$(XORG_FONT_SCREEN_CYRILLIC_SUFFIX))
XORG_FONT_SCREEN_CYRILLIC_SOURCE	:= $(SRCDIR)/$(XORG_FONT_SCREEN_CYRILLIC).$(XORG_FONT_SCREEN_CYRILLIC_SUFFIX)
XORG_FONT_SCREEN_CYRILLIC_DIR		:= $(BUILDDIR)/$(XORG_FONT_SCREEN_CYRILLIC)

ifdef PTXCONF_XORG_FONT_SCREEN_CYRILLIC
$(STATEDIR)/xorg-fonts.targetinstall.post: $(STATEDIR)/xorg-font-screen-cyrillic.targetinstall
endif

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_FONT_SCREEN_CYRILLIC_PATH	:= PATH=$(CROSS_PATH)
XORG_FONT_SCREEN_CYRILLIC_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_FONT_SCREEN_CYRILLIC_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-fontdir=$(XORG_FONTDIR)/cyrillic

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-screen-cyrillic.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-screen-cyrillic.targetinstall:
	@$(call targetinfo)

	@mkdir -p $(XORG_FONTS_DIR_INSTALL)/cyrillic

	@find $(XORG_FONT_SCREEN_CYRILLIC_DIR) \
		-name "*.pcf.gz" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/cyrillic; \
	done

	@$(call touch)

# vim: syntax=make
