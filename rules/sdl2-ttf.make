# -*-makefile-*-
#
# Copyright (C) 2018 by Michael Grzeschik <mgr@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SDL2_TTF) += sdl2-ttf

#
# Paths and names
#
SDL2_TTF_VERSION	:= 2.20.2
SDL2_TTF_MD5		:= 4815838c87410346226983f4e0a85fd4
SDL2_TTF		:= SDL2_ttf-$(SDL2_TTF_VERSION)
SDL2_TTF_SUFFIX		:= tar.gz
SDL2_TTF_URL		:= https://www.libsdl.org/projects/SDL_ttf/release/$(SDL2_TTF).$(SDL2_TTF_SUFFIX)
SDL2_TTF_SOURCE		:= $(SRCDIR)/$(SDL2_TTF).$(SDL2_TTF_SUFFIX)
SDL2_TTF_DIR		:= $(BUILDDIR)/$(SDL2_TTF)
SDL2_TTF_LICENSE	:= zlib
SDL2_TTF_LICENSE_FILES	:= \
	file://LICENSE.txt;md5=a41cbf59bdea749fe34c1af6d3615f68

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SDL2_TTF_CONF_TOOL	:= autoconf
SDL2_TTF_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-freetype-builtin \
	--disable-freetypetest \
	--$(call ptx/endis,PTXCONF_SDL2_TTF_HARFBUZZ)-harfbuzz \
	--disable-harfbuzz-builtin \
	--disable-sdltest

ifdef PTXCONF_SDL2_PULSEAUDIO
SDL2_TTF_LDFLAGS	:= \
	-Wl,-rpath-link,$(SYSROOT)/usr/lib/pulseaudio
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/sdl2-ttf.targetinstall:
	@$(call targetinfo)

	@$(call install_init, sdl2-ttf)
	@$(call install_fixup, sdl2-ttf,PRIORITY,optional)
	@$(call install_fixup, sdl2-ttf,SECTION,base)
	@$(call install_fixup, sdl2-ttf,AUTHOR,"Michael Grzeschik <mgr@pengutronix.de>")
	@$(call install_fixup, sdl2-ttf,DESCRIPTION,missing)

	@$(call install_lib, sdl2-ttf, 0, 0, 0644, libSDL2_ttf-2.0)

	@$(call install_finish, sdl2-ttf)

	@$(call touch)

# vim: syntax=make
