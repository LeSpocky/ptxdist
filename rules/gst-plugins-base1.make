# -*-makefile-*-
#
# Copyright (C) 2008 by Robert Schwebel
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GST_PLUGINS_BASE1) += gst-plugins-base1

#
# Paths and names
#
GST_PLUGINS_BASE1_VERSION	:= 1.26.8
GST_PLUGINS_BASE1_MD5		:= fc2107e60d944d9409e4289f9b73e417
GST_PLUGINS_BASE1		:= gst-plugins-base-$(GST_PLUGINS_BASE1_VERSION)
GST_PLUGINS_BASE1_SUFFIX	:= tar.xz
GST_PLUGINS_BASE1_URL		:= https://gstreamer.freedesktop.org/src/gst-plugins-base/$(GST_PLUGINS_BASE1).$(GST_PLUGINS_BASE1_SUFFIX)
GST_PLUGINS_BASE1_SOURCE	:= $(SRCDIR)/$(GST_PLUGINS_BASE1).$(GST_PLUGINS_BASE1_SUFFIX)
GST_PLUGINS_BASE1_DIR		:= $(BUILDDIR)/$(GST_PLUGINS_BASE1)
GST_PLUGINS_BASE1_LICENSE	:= LGPL-2.0-or-later AND BSD-3-Clause AND MIT
GST_PLUGINS_BASE1_LICENSE_FILES	:= \
	file://COPYING;md5=69333daa044cb77e486cc36129f7a770 \
	file://gst/app/gstapp.c;startline=2;endline=17;md5=c47da05839f8e21a07fbcba7078022de \
	file://gst-libs/gst/fft/kiss_fft_f32.c;startline=2;endline=6;md5=ff5063ce1d915132cfd77da26adde1a2 \
	file://gst-libs/gst/rtsp/gstrtspdefs.c;startline=20;endline=40;md5=de3595ce8d06d57e25af36b10af7b67d

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GST_PLUGINS_BASE1_ENABLE-$(PTXCONF_GST_PLUGINS_BASE1_ADDER)		+= adder
GST_PLUGINS_BASE1_ENABLE-$(PTXCONF_GST_PLUGINS_BASE1_ALSA)		+= alsa
GST_PLUGINS_BASE1_ENABLE-$(PTXCONF_GST_PLUGINS_BASE1_APP)		+= app
GST_PLUGINS_BASE1_ENABLE-$(PTXCONF_GST_PLUGINS_BASE1_AUDIOCONVERT)	+= audioconvert
GST_PLUGINS_BASE1_ENABLE-$(PTXCONF_GST_PLUGINS_BASE1_AUDIOMIXER)	+= audiomixer
GST_PLUGINS_BASE1_ENABLE-$(PTXCONF_GST_PLUGINS_BASE1_AUDIORATE)		+= audiorate
GST_PLUGINS_BASE1_ENABLE-$(PTXCONF_GST_PLUGINS_BASE1_AUDIORESAMPLE)	+= audioresample
GST_PLUGINS_BASE1_ENABLE-$(PTXCONF_GST_PLUGINS_BASE1_AUDIOTESTSRC)	+= audiotestsrc
GST_PLUGINS_BASE1_ENABLE-$(PTXCONF_GST_PLUGINS_BASE1_CDPARANOIA)	+= cdparanoia
GST_PLUGINS_BASE1_ENABLE-$(PTXCONF_GST_PLUGINS_BASE1_COMPOSITOR)	+= compositor
GST_PLUGINS_BASE1_ENABLEC-$(PTXCONF_GST_PLUGINS_BASE1_DEBUGUTILS)	+= debugutils
GST_PLUGINS_BASE1_ENABLEP-$(PTXCONF_GST_PLUGINS_BASE1_DEBUGUTILS)	+= basedebug
GST_PLUGINS_BASE1_ENABLE-$(PTXCONF_GST_PLUGINS_BASE1_DSD)		+= dsd
GST_PLUGINS_BASE1_ENABLE-$(PTXCONF_GST_PLUGINS_BASE1_ENCODING)		+= encoding
GST_PLUGINS_BASE1_ENABLE-$(PTXCONF_GST_PLUGINS_BASE1_GIO)		+= gio
GST_PLUGINS_BASE1_ENABLEC-$(PTXCONF_GST_PLUGINS_BASE1_GIO)		+= gio-typefinder
GST_PLUGINS_BASE1_ENABLEC-$(PTXCONF_GST_PLUGINS_BASE1_GL)		+= gl
GST_PLUGINS_BASE1_ENABLEP-$(PTXCONF_GST_PLUGINS_BASE1_GL)		+= opengl
GST_PLUGINS_BASE1_ENABLE-$(PTXCONF_GST_PLUGINS_BASE1_LIBVISUAL)		+= libvisual
GST_PLUGINS_BASE1_ENABLE-$(PTXCONF_GST_PLUGINS_BASE1_OGG)		+= ogg
GST_PLUGINS_BASE1_ENABLE-$(PTXCONF_GST_PLUGINS_BASE1_OPUS)		+= opus
GST_PLUGINS_BASE1_ENABLE-$(PTXCONF_GST_PLUGINS_BASE1_OVERLAYCOMPOSITION)	+= overlaycomposition
GST_PLUGINS_BASE1_ENABLE-$(PTXCONF_GST_PLUGINS_BASE1_PANGO)		+= pango
GST_PLUGINS_BASE1_ENABLE-$(PTXCONF_GST_PLUGINS_BASE1_PBTYPES)		+= pbtypes
GST_PLUGINS_BASE1_ENABLE-$(PTXCONF_GST_PLUGINS_BASE1_PLAYBACK)		+= playback
GST_PLUGINS_BASE1_ENABLE-$(PTXCONF_GST_PLUGINS_BASE1_RAWPARSE)		+= rawparse
GST_PLUGINS_BASE1_ENABLE-$(PTXCONF_GST_PLUGINS_BASE1_SUBPARSE)		+= subparse
GST_PLUGINS_BASE1_ENABLE-$(PTXCONF_GST_PLUGINS_BASE1_TCP)		+= tcp
GST_PLUGINS_BASE1_ENABLE-$(PTXCONF_GST_PLUGINS_BASE1_THEORA)		+= theora
GST_PLUGINS_BASE1_ENABLEC-$(PTXCONF_GST_PLUGINS_BASE1_TREMOR)		+= tremor
GST_PLUGINS_BASE1_ENABLEP-$(PTXCONF_GST_PLUGINS_BASE1_TREMOR)		+= ivorbisdec
GST_PLUGINS_BASE1_ENABLEC-$(PTXCONF_GST_PLUGINS_BASE1_TYPEFIND)		+= typefind
GST_PLUGINS_BASE1_ENABLEP-$(PTXCONF_GST_PLUGINS_BASE1_TYPEFIND)		+= typefindfunctions
GST_PLUGINS_BASE1_ENABLE-$(PTXCONF_GST_PLUGINS_BASE1_VIDEOCONVERTSCALE)	+= videoconvertscale
GST_PLUGINS_BASE1_ENABLE-$(PTXCONF_GST_PLUGINS_BASE1_VIDEORATE)		+= videorate
GST_PLUGINS_BASE1_ENABLE-$(PTXCONF_GST_PLUGINS_BASE1_VIDEOTESTSRC)	+= videotestsrc
GST_PLUGINS_BASE1_ENABLE-$(PTXCONF_GST_PLUGINS_BASE1_VOLUME)		+= volume
GST_PLUGINS_BASE1_ENABLE-$(PTXCONF_GST_PLUGINS_BASE1_VORBIS)		+= vorbis
GST_PLUGINS_BASE1_ENABLEC-$(PTXCONF_GST_PLUGINS_BASE1_X)		+= xshm xvideo xi
GST_PLUGINS_BASE1_ENABLEP-$(PTXCONF_GST_PLUGINS_BASE1_X)		+= ximagesink xvimagesink

GST_PLUGINS_BASE1_ENABLEC- += $(GST_PLUGINS_BASE1_ENABLE-)
GST_PLUGINS_BASE1_ENABLEC-y += $(GST_PLUGINS_BASE1_ENABLE-y)
GST_PLUGINS_BASE1_ENABLEP-y += $(GST_PLUGINS_BASE1_ENABLE-y)

GST_PLUGINS_BASE1_GL_API :=
ifdef PTXCONF_GST_PLUGINS_BASE1_GLES2
GST_PLUGINS_BASE1_GL_API += gles2
endif
ifdef PTXCONF_GST_PLUGINS_BASE1_OPENGL
GST_PLUGINS_BASE1_GL_API += opengl
endif
GST_PLUGINS_BASE1_GL_API := $(subst $(space),$(comma),$(strip $(GST_PLUGINS_BASE1_GL_API)))

GST_PLUGINS_BASE1_GL_PLATFORM :=
ifdef PTXCONF_GST_PLUGINS_BASE1_EGL
GST_PLUGINS_BASE1_GL_PLATFORM += egl
endif
ifdef PTXCONF_GST_PLUGINS_BASE1_GLX
GST_PLUGINS_BASE1_GL_PLATFORM += glx
endif
GST_PLUGINS_BASE1_GL_PLATFORM := $(subst $(space),$(comma),$(strip $(GST_PLUGINS_BASE1_GL_PLATFORM)))

GST_PLUGINS_BASE1_GL_WINSYS :=
ifdef PTXCONF_GST_PLUGINS_BASE1_EGL
GST_PLUGINS_BASE1_GL_WINSYS := egl gbm
endif
ifdef PTXCONF_GST_PLUGINS_BASE1_EGL_WAYLAND
GST_PLUGINS_BASE1_GL_WINSYS += wayland
endif
ifdef PTXCONF_GST_PLUGINS_BASE1_X11
GST_PLUGINS_BASE1_GL_WINSYS += x11
endif
GST_PLUGINS_BASE1_GL_WINSYS := $(subst $(space),$(comma),$(strip $(GST_PLUGINS_BASE1_GL_WINSYS)))

#
# meson
#
GST_PLUGINS_BASE1_CONF_TOOL	= meson
GST_PLUGINS_BASE1_CONF_OPT	= \
	$(CROSS_MESON_USR) \
	$(call GSTREAMER1_GENERIC_CONF_OPT,GStreamer Base Plug-ins) \
	-Daudioresample_format=auto \
	-Ddrm=enabled \
	-Degl_module_name=libEGL \
	-Dexamples=disabled \
	-Dgl-graphene=$(call ptx/endis, PTXCONF_GST_PLUGINS_BASE1_GL)d \
	-Dgl-jpeg=$(call ptx/endis, PTXCONF_GST_PLUGINS_BASE1_GL)d \
	-Dgl-png=$(call ptx/endis, PTXCONF_GST_PLUGINS_BASE1_GL)d \
	-Dgl_api=$(GST_PLUGINS_BASE1_GL_API) \
	-Dgl_platform=$(GST_PLUGINS_BASE1_GL_PLATFORM) \
	-Dgl_winsys=$(GST_PLUGINS_BASE1_GL_WINSYS) \
	-Dgles2_module_name=libGLESv2.so \
	-Dinstall_plugins_helper= \
	-Dintrospection=$(call ptx/endis,PTXCONF_GSTREAMER1_INTROSPECTION)d \
	-Diso-codes=disabled \
	-Dnls=disabled \
	-Dopengl_module_name=libGL \
	-Dorc=enabled \
	-Dqt5=disabled \
	-Dtools=$(call ptx/endis, PTXCONF_GST_PLUGINS_BASE1_INSTALL_TOOLS)d \
	-Dx11=$(call ptx/endis, PTXCONF_GST_PLUGINS_BASE1_X11)d

ifneq ($(call remove_quotes,$(GST_PLUGINS_BASE1_ENABLEC-y)),)
GST_PLUGINS_BASE1_CONF_OPT +=  $(addsuffix =enabled, $(addprefix -D, $(GST_PLUGINS_BASE1_ENABLEC-y)))
endif

ifneq ($(call remove_quotes,$(GST_PLUGINS_BASE1_ENABLEC-)),)
GST_PLUGINS_BASE1_CONF_OPT +=  $(addsuffix =disabled, $(addprefix -D, $(GST_PLUGINS_BASE1_ENABLEC-)))
endif

ifdef PTXCONF_ARCH_ARM
ifndef PTXCONF_ARCH_ARM_V6
GST_PLUGINS_BASE1_CONF_ENV += LDFLAGS=-latomic
endif
endif
ifdef PTXCONF_ARCH_PPC
GST_PLUGINS_BASE1_CONF_ENV += LDFLAGS=-latomic
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gst-plugins-base1.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  gst-plugins-base1)
	@$(call install_fixup, gst-plugins-base1,PRIORITY,optional)
	@$(call install_fixup, gst-plugins-base1,SECTION,base)
	@$(call install_fixup, gst-plugins-base1,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, gst-plugins-base1,DESCRIPTION,missing)

ifdef PTXCONF_GST_PLUGINS_BASE1_INSTALL_TOOLS
	@$(call install_copy, gst-plugins-base1, 0, 0, 0755, -, \
		/usr/bin/gst-device-monitor-1.0)

	@$(call install_copy, gst-plugins-base1, 0, 0, 0755, -, \
		/usr/bin/gst-discoverer-1.0)

	@$(call install_copy, gst-plugins-base1, 0, 0, 0755, -, \
		/usr/bin/gst-play-1.0)
endif

	# install all activated libs
	@$(foreach lib,$(basename $(notdir $(wildcard $(GST_PLUGINS_BASE1_PKGDIR)/usr/lib/*-1.0.so))), \
		$(call install_lib, gst-plugins-base1, 0, 0, 0644, $(lib))$(ptx/nl))

	@$(foreach plugin, $(GST_PLUGINS_BASE1_ENABLEP-y), \
		$(call install_copy, gst-plugins-base1, 0, 0, 0644, -, \
			/usr/lib/gstreamer-1.0/libgst$(plugin).so)$(ptx/nl))

ifdef PTXCONF_GSTREAMER1_INTROSPECTION
	@$(call install_tree, gst-plugins-base1, 0, 0, -, \
		/usr/lib/girepository-1.0)
endif

	@$(call install_finish, gst-plugins-base1)

	@$(call touch)

# vim: syntax=make
