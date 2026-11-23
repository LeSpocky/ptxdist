# -*-makefile-*-
#
# Copyright (C) 2012 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LAME) += lame

#
# Paths and names
#
LAME_VERSION	:= 4.0
LAME_SHA256	:= 3df5124d5ad3a98312ffd7ba6a9b36230e4f8a3e66d3ce0f425e336c32d216eb
LAME		:= lame-$(LAME_VERSION)
LAME_SUFFIX	:= tar.gz
LAME_URL	:= $(call ptx/mirror, SF, lame/$(LAME).$(LAME_SUFFIX))
LAME_SOURCE	:= $(SRCDIR)/$(LAME).$(LAME_SUFFIX)
LAME_DIR	:= $(BUILDDIR)/$(LAME)
LAME_LICENSE	:= LGPL-2.0-or-later
LAME_LICENSE_FILES	:= \
	file://COPYING;md5=a03aed0afc52dd24ed99db06d64a9fa3 \
	file://libmp3lame/lame.c;startline=2;endline=25;md5=30681e9c7a6576faf9f51ea2eae70500

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# The VBR histogram of the frontend uses termcap from whatever curses
# library configure finds. Don't pick it up by accident.
#
LAME_CONF_ENV	:= \
	$(CROSS_ENV) \
	ac_cv_lib_termcap_initscr=no \
	ac_cv_lib_curses_initscr=no \
	ac_cv_lib_ncurses_initscr=no

#
# autoconf
#
# Note: regardless of --{en,dis}able-nasm and --{en,dis}able-ieeehack 
# configure always enables them, so avoid passing these options.
#
LAME_CONF_TOOL	:= autoconf
LAME_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-static \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-rpath \
	--disable-cpml \
	--disable-gtktest \
	--disable-efence \
	--disable-analyzer-hooks \
	--$(call ptx/endis, PTXCONF_LAME_DECODER)-decoder \
	--$(call ptx/endis, PTXCONF_LAME_FRONTEND)-frontend \
	--disable-mp3x \
	--enable-mp3rtp \
	--$(call ptx/endis, PTXCONF_GLOBAL_IPV6)-ipv6 \
	--enable-dynamic-frontends \
	--enable-expopt \
	--disable-debug \
	--$(call ptx/endis, PTXDIST_Y2038)-year2038 \
	--without-dot \
	--without-dmalloc \
	--with-fileio=lame

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/lame.targetinstall:
	@$(call targetinfo)

	@$(call install_init, lame)
	@$(call install_fixup, lame,PRIORITY,optional)
	@$(call install_fixup, lame,SECTION,base)
	@$(call install_fixup, lame,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, lame,DESCRIPTION,missing)

	@$(call install_lib, lame, 0, 0, 0644, libmp3lame)
ifdef PTXCONF_LAME_FRONTEND
	@$(call install_copy, lame, 0, 0, 0755, -, /usr/bin/lame)
endif

	@$(call install_finish, lame)

	@$(call touch)

# vim: syntax=make
