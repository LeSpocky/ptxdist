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
PACKAGES-$(PTXCONF_XORG_FONT_ADOBE_100DPI) += xorg-font-adobe-100dpi

#
# Paths and names
#
XORG_FONT_ADOBE_100DPI_VERSION	:= 1.0.3
XORG_FONT_ADOBE_100DPI_MD5	:= 1347c3031b74c9e91dc4dfa53b12f143
XORG_FONT_ADOBE_100DPI		:= font-adobe-100dpi-$(XORG_FONT_ADOBE_100DPI_VERSION)
XORG_FONT_ADOBE_100DPI_SUFFIX	:= tar.bz2
XORG_FONT_ADOBE_100DPI_URL	:= $(call ptx/mirror, XORG, individual/font/$(XORG_FONT_ADOBE_100DPI).$(XORG_FONT_ADOBE_100DPI_SUFFIX))
XORG_FONT_ADOBE_100DPI_SOURCE	:= $(SRCDIR)/$(XORG_FONT_ADOBE_100DPI).$(XORG_FONT_ADOBE_100DPI_SUFFIX)
XORG_FONT_ADOBE_100DPI_DIR	:= $(BUILDDIR)/$(XORG_FONT_ADOBE_100DPI)

ifdef PTXCONF_XORG_FONT_ADOBE_100DPI
$(STATEDIR)/xorg-fonts.targetinstall.post: $(STATEDIR)/xorg-font-adobe-100dpi.targetinstall
endif

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_FONT_ADOBE_100DPI_CONF_TOOL := autoconf
XORG_FONT_ADOBE_100DPI_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--with-fontdir=$(XORG_FONTDIR)/100dpi

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-adobe-100dpi.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-adobe-100dpi.targetinstall:
	@$(call targetinfo)

	@mkdir -p $(XORG_FONTS_DIR_INSTALL)/100dpi

	@find $(XORG_FONT_ADOBE_100DPI_DIR) \
		-name "*.pcf.gz" -a \! -name "*ISO8859*" \
		-o -name "*ISO8859-1.pcf.gz" \
		-o -name "*ISO8859-15.pcf.gz" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/100dpi; \
	done

ifdef PTXCONF_XORG_FONT_ADOBE_100DPI_TRANS
	@find $(XORG_FONT_ADOBE_100DPI_DIR) \
		-name "*ISO8859-2.pcf.gz" \
		-o -name "*ISO8859-3.pcf.gz" \
		-o -name "*ISO8859-4.pcf.gz" \
		-o -name "*ISO8859-9.pcf.gz" \
		-o -name "*ISO8859-10.pcf.gz" \
		-o -name "*ISO8859-13.pcf.gz" \
		-o -name "*ISO8859-14.pcf.gz" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/100dpi; \
	done
endif

	@$(call touch)

# vim: syntax=make
