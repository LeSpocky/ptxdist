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
PACKAGES-$(PTXCONF_XORG_FONT_MICRO_MISC) += xorg-font-micro-misc

#
# Paths and names
#
XORG_FONT_MICRO_MISC_VERSION	:= 1.0.3
XORG_FONT_MICRO_MISC_SHA256	:= 9a3381c10f32d9511f0ad4179df395914c50779103c16cddf7017f5220ed8db6
XORG_FONT_MICRO_MISC		:= font-micro-misc-$(XORG_FONT_MICRO_MISC_VERSION)
XORG_FONT_MICRO_MISC_SUFFIX	:= tar.bz2
XORG_FONT_MICRO_MISC_URL	:= $(call ptx/mirror, XORG, individual/font//$(XORG_FONT_MICRO_MISC).$(XORG_FONT_MICRO_MISC_SUFFIX))
XORG_FONT_MICRO_MISC_SOURCE	:= $(SRCDIR)/$(XORG_FONT_MICRO_MISC).$(XORG_FONT_MICRO_MISC_SUFFIX)
XORG_FONT_MICRO_MISC_DIR	:= $(BUILDDIR)/$(XORG_FONT_MICRO_MISC)

ifdef PTXCONF_XORG_FONT_MICRO_MISC
$(STATEDIR)/xorg-fonts.targetinstall.post: $(STATEDIR)/xorg-font-micro-misc.targetinstall
endif

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_FONT_MICRO_MISC_CONF_TOOL	:= autoconf
XORG_FONT_MICRO_MISC_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--with-fontdir=$(XORG_FONTDIR)/misc

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-micro-misc.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-micro-misc.targetinstall:
	@$(call targetinfo)

	@mkdir -p $(XORG_FONTS_DIR_INSTALL)/misc

	@find $(XORG_FONT_MICRO_MISC_DIR) \
		-name "*.pcf.gz" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/misc; \
	done

	@$(call touch)

# vim: syntax=make
