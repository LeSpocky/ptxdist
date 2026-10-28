# -*-makefile-*-
#
# Copyright (C) 2018 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_FRIBIDI) += fribidi

#
# Paths and names
#
FRIBIDI_VERSION	:= 1.0.17
FRIBIDI_SHA256	:= 6949dcde27d41cebad1fd741fcafc36d55a1020d2d872d4a6eb3914caabbada2
FRIBIDI		:= fribidi-$(FRIBIDI_VERSION)
FRIBIDI_SUFFIX	:= tar.xz
FRIBIDI_URL	:= https://github.com/fribidi/fribidi/releases/download/v$(FRIBIDI_VERSION)/$(FRIBIDI).$(FRIBIDI_SUFFIX)
FRIBIDI_SOURCE	:= $(SRCDIR)/$(FRIBIDI).$(FRIBIDI_SUFFIX)
FRIBIDI_DIR	:= $(BUILDDIR)/$(FRIBIDI)
FRIBIDI_LICENSE	:= LGPL-2.1-or-later
FRIBIDI_LICENSE_FILES := \
	file://lib/fribidi.c;startline=1;endline=28;md5=9e89265732e8f4f99b1267a1ffd15787 \
	file://COPYING;md5=4bf661c1e3793e55c8d1051bc5e0ae21

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# meson
#
FRIBIDI_CONF_TOOL	:= meson
FRIBIDI_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Dbin=false \
	-Ddeprecated=false \
	-Ddocs=false \
	-Dtests=false

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/fribidi.targetinstall:
	@$(call targetinfo)

	@$(call install_init, fribidi)
	@$(call install_fixup, fribidi,PRIORITY,optional)
	@$(call install_fixup, fribidi,SECTION,base)
	@$(call install_fixup, fribidi,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, fribidi,DESCRIPTION,missing)

	@$(call install_lib, fribidi, 0, 0, 0644, libfribidi)

	@$(call install_finish, fribidi)

	@$(call touch)

# vim: syntax=make
