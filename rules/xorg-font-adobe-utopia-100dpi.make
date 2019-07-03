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
PACKAGES-$(PTXCONF_XORG_FONT_ADOBE_UTOPIA_100DPI) += xorg-font-adobe-utopia-100dpi

#
# Paths and names
#
XORG_FONT_ADOBE_UTOPIA_100DPI_VERSION	:= 1.0.4
XORG_FONT_ADOBE_UTOPIA_100DPI_MD5	:= 66fb6de561648a6dce2755621d6aea17
XORG_FONT_ADOBE_UTOPIA_100DPI		:= font-adobe-utopia-100dpi-$(XORG_FONT_ADOBE_UTOPIA_100DPI_VERSION)
XORG_FONT_ADOBE_UTOPIA_100DPI_SUFFIX	:= tar.bz2
XORG_FONT_ADOBE_UTOPIA_100DPI_URL	:= $(call ptx/mirror, XORG, individual/font/$(XORG_FONT_ADOBE_UTOPIA_100DPI).$(XORG_FONT_ADOBE_UTOPIA_100DPI_SUFFIX))
XORG_FONT_ADOBE_UTOPIA_100DPI_SOURCE	:= $(SRCDIR)/$(XORG_FONT_ADOBE_UTOPIA_100DPI).$(XORG_FONT_ADOBE_UTOPIA_100DPI_SUFFIX)
XORG_FONT_ADOBE_UTOPIA_100DPI_DIR	:= $(BUILDDIR)/$(XORG_FONT_ADOBE_UTOPIA_100DPI)

ifdef PTXCONF_XORG_FONT_ADOBE_UTOPIA_100DPI
$(STATEDIR)/xorg-fonts.targetinstall.post: $(STATEDIR)/xorg-font-adobe-utopia-100dpi.targetinstall
endif

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_FONT_ADOBE_UTOPIA_100DPI_PATH	:= PATH=$(CROSS_PATH)
XORG_FONT_ADOBE_UTOPIA_100DPI_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_FONT_ADOBE_UTOPIA_100DPI_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-fontdir=$(XORG_FONTDIR)/100dpi


# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-adobe-utopia-100dpi.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-adobe-utopia-100dpi.targetinstall:
	@$(call targetinfo)

	@mkdir -p $(XORG_FONTS_DIR_INSTALL)/100dpi

	@cd $(XORG_FONT_ADOBE_UTOPIA_100DPI_DIR); \
	find . -name "*.pcf.gz" -a \! -name "*ISO8859*" \
		-o -name "*ISO8859-1.pcf.gz" \
		-o -name "*ISO8859-15.pcf.gz" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/100dpi; \
	done

ifdef PTXCONF_XORG_FONT_ADOBE_UTOPIA_100DPI_TRANS
	@cd $(XORG_FONT_ADOBE_UTOPIA_100DPI_DIR); \
	find . -name "*ISO8859-2.pcf.gz" \
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
