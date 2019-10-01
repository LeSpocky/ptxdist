# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_FONT_ENCODINGS) += xorg-font-encodings

#
# Paths and names
#
XORG_FONT_ENCODINGS_VERSION	:= 1.0.5
XORG_FONT_ENCODINGS_MD5		:= bbae4f247b88ccde0e85ed6a403da22a
XORG_FONT_ENCODINGS		:= encodings-$(XORG_FONT_ENCODINGS_VERSION)
XORG_FONT_ENCODINGS_SUFFIX	:= tar.bz2
XORG_FONT_ENCODINGS_URL		:= $(call ptx/mirror, XORG, individual/font/$(XORG_FONT_ENCODINGS).$(XORG_FONT_ENCODINGS_SUFFIX))
XORG_FONT_ENCODINGS_SOURCE	:= $(SRCDIR)/$(XORG_FONT_ENCODINGS).$(XORG_FONT_ENCODINGS_SUFFIX)
XORG_FONT_ENCODINGS_DIR		:= $(BUILDDIR)/$(XORG_FONT_ENCODINGS)

ifdef PTXCONF_XORG_FONT_ENCODINGS
$(STATEDIR)/xorg-fonts.targetinstall.post: $(STATEDIR)/xorg-font-encodings.targetinstall
endif

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_FONT_ENCODINGS_PATH	:= PATH=$(CROSS_PATH)
XORG_FONT_ENCODINGS_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_FONT_ENCODINGS_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-encodingsdir=$(XORG_FONTDIR)/encodings

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-encodings.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-encodings.targetinstall:
	@$(call targetinfo)

	@mkdir -p $(XORG_FONTS_DIR_INSTALL)/encodings

# FIXME: handle encodings/large

	@find $(XORG_FONT_ENCODINGS_DIR) \
		-maxdepth 1 \
		-name "*.enc.gz" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/encodings; \
	done

	@$(call touch)

# vim: syntax=make
