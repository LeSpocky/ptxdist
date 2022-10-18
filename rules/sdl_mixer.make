# -*-makefile-*-
#
# Copyright (C) 2008 by Marek Moeckel
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SDL_MIXER) += sdl_mixer

#
# Paths and names
#
SDL_MIXER_VERSION	:= 1.2.11
SDL_MIXER_MD5		:= 65ada3d997fe85109191a5fb083f248c
SDL_MIXER		:= SDL_mixer-$(SDL_MIXER_VERSION)
SDL_MIXER_SUFFIX	:= tar.gz
SDL_MIXER_URL		:= http://www.libsdl.org/projects/SDL_mixer/release/$(SDL_MIXER).$(SDL_MIXER_SUFFIX)
SDL_MIXER_SOURCE	:= $(SRCDIR)/$(SDL_MIXER).$(SDL_MIXER_SUFFIX)
SDL_MIXER_DIR		:= $(BUILDDIR)/$(SDL_MIXER)
SDL_MIXER_LICENSE	:= LGPL-2.1-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
SDL_MIXER_CONF_TOOL := autoconf
SDL_MIXER_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--with-sdl-prefix=$(SYSROOT)/usr \
	--disable-music-mp3 \
	--$(call ptx/endis, PTXCONF_SDL_MIXER_WAVE)-music-wave \
	--$(call ptx/endis, PTXCONF_SDL_MIXER_MOD)-music-mod \
	--$(call ptx/endis, PTXCONF_SDL_MIXER_MIDI_TIMIDITY)-music-timidity-midi \
	--$(call ptx/endis, PTXCONF_SDL_MIXER_MIDI_NATIVE)-music-native-midi-gpl \
	--$(call ptx/endis, PTXCONF_SDL_MIXER_OGG)-music-ogg \
	--$(call ptx/endis, PTXCONF_SDL_MIXER_FLAC)-music-flac \
	--$(call ptx/endis, PTXCONF_SDL_MIXER_MP3)-music-mp3-mad-gpl

ifneq ($(PTXCONF_SDL_MIXER_MIDI_TIMIDITY)$(PTXCONF_SDL_MIXER_MIDI_NATIVE),)
SDL_MIXER_CONF_OPT += --enable-music-midi
else
SDL_MIXER_CONF_OPT += --disable-music-midi
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/sdl_mixer.targetinstall:
	@$(call targetinfo)

	@$(call install_init, sdl_mixer)
	@$(call install_fixup, sdl_mixer,PRIORITY,optional)
	@$(call install_fixup, sdl_mixer,SECTION,base)
	@$(call install_fixup, sdl_mixer,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, sdl_mixer,DESCRIPTION,missing)

	@$(call install_lib, sdl_mixer, 0, 0, 0644, libSDL_mixer-1.2)

	@$(call install_finish, sdl_mixer)

	@$(call touch)

# vim: syntax=make
