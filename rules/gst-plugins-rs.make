# -*-makefile-*-
#
# Copyright (C) 2022 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GST_PLUGINS_RS) += gst-plugins-rs

#
# Paths and names
#
GST_PLUGINS_RS_VERSION		:= 1.24.9
GST_PLUGINS_RS_TAG		:= gstreamer-$(GST_PLUGINS_RS_VERSION)
GST_PLUGINS_RS_MD5		:= 9f378d4ec8c7d3bb0eee2ff89b5828b9
GST_PLUGINS_RS			:= gst-plugins-rs-$(GST_PLUGINS_RS_VERSION)
GST_PLUGINS_RS_SUFFIX		:= tar.bz2
GST_PLUGINS_RS_URL		:= https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/archive/$(GST_PLUGINS_RS_TAG)/gst-plugins-rs-$(GST_PLUGINS_RS_TAG).$(GST_PLUGINS_RS_SUFFIX)
GST_PLUGINS_RS_SOURCE		:= $(SRCDIR)/$(GST_PLUGINS_RS).$(GST_PLUGINS_RS_SUFFIX)
GST_PLUGINS_RS_DIR		:= $(BUILDDIR)/$(GST_PLUGINS_RS)
GST_PLUGINS_RS_CARGO_LOCK	:= Cargo.lock
GST_PLUGINS_RS_LICENSE		:= LGPL-2.0-or-later AND ( Apache-2.0 OR MIT ) AND MPL-2.0 AND MIT AND unknown
GST_PLUGINS_RS_LICENSE_FILES	:= \
	file://LICENSE-LGPLv2;md5=4fbd65380cdd255951079008b364516c \
	file://LICENSE-APACHE;md5=1836efb2eb779966696f473ee8540542 \
	file://LICENSE-MIT;md5=b377b220f43d747efdec40d69fcaa69d \
	file://LICENSE-MPL-2.0;md5=815ca599c9df247a0c7f619bab123dad \
	file://video/closedcaption/src/c/caption.c;startline=1;endline=23;md5=e3e1cf3731e608bfef2c87e68d006dfb

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------


GST_PLUGINS_RS_ENABLEC-$(PTXCONF_GST_PLUGINS_RS_AUDIOFX)		+= audiofx
GST_PLUGINS_RS_ENABLEP-$(PTXCONF_GST_PLUGINS_RS_AUDIOFX)		+= rsaudiofx
GST_PLUGINS_RS_ENABLE-$(PTXCONF_GST_PLUGINS_RS_AWS)			+= aws
GST_PLUGINS_RS_ENABLE-$(PTXCONF_GST_PLUGINS_RS_CDG)			+= cdg
GST_PLUGINS_RS_ENABLE-$(PTXCONF_GST_PLUGINS_RS_CLAXON)			+= claxon
GST_PLUGINS_RS_ENABLEC-$(PTXCONF_GST_PLUGINS_RS_CLOSEDCAPTION)		+= closedcaption
GST_PLUGINS_RS_ENABLEP-$(PTXCONF_GST_PLUGINS_RS_CLOSEDCAPTION)		+= rsclosedcaption
GST_PLUGINS_RS_ENABLE-$(PTXCONF_GST_PLUGINS_RS_CSOUND)			+= csound
GST_PLUGINS_RS_ENABLE-$(PTXCONF_GST_PLUGINS_RS_DAV1D)			+= dav1d
GST_PLUGINS_RS_ENABLE-$(PTXCONF_GST_PLUGINS_RS_FALLBACKSWITCH)		+= fallbackswitch
GST_PLUGINS_RS_ENABLE-$(PTXCONF_GST_PLUGINS_RS_FFV1)			+= ffv1
GST_PLUGINS_RS_ENABLEC-$(PTXCONF_GST_PLUGINS_RS_FILE)			+= file
GST_PLUGINS_RS_ENABLEP-$(PTXCONF_GST_PLUGINS_RS_FILE)			+= rsfile
GST_PLUGINS_RS_ENABLEC-$(PTXCONF_GST_PLUGINS_RS_FLAVORS)		+= flavors
GST_PLUGINS_RS_ENABLEP-$(PTXCONF_GST_PLUGINS_RS_FLAVORS)		+= rsflv
GST_PLUGINS_RS_ENABLE-$(PTXCONF_GST_PLUGINS_RS_FMP4)			+= fmp4
GST_PLUGINS_RS_ENABLE-$(PTXCONF_GST_PLUGINS_RS_GIF)			+= gif
GST_PLUGINS_RS_ENABLE-$(PTXCONF_GST_PLUGINS_RS_GTK4)			+= gtk4
GST_PLUGINS_RS_ENABLE-$(PTXCONF_GST_PLUGINS_RS_HLSSINK3)		+= hlssink3
GST_PLUGINS_RS_ENABLE-$(PTXCONF_GST_PLUGINS_RS_HSV)			+= hsv
GST_PLUGINS_RS_ENABLEC-$(PTXCONF_GST_PLUGINS_RS_INTER)			+= inter
GST_PLUGINS_RS_ENABLEP-$(PTXCONF_GST_PLUGINS_RS_INTER)			+= rsinter
GST_PLUGINS_RS_ENABLE-$(PTXCONF_GST_PLUGINS_RS_JSON)			+= json
GST_PLUGINS_RS_ENABLE-$(PTXCONF_GST_PLUGINS_RS_LEWTON)			+= lewton
GST_PLUGINS_RS_ENABLE-$(PTXCONF_GST_PLUGINS_RS_LIVESYNC)		+= livesync
GST_PLUGINS_RS_ENABLE-$(PTXCONF_GST_PLUGINS_RS_MP4)			+= mp4
GST_PLUGINS_RS_ENABLE-$(PTXCONF_GST_PLUGINS_RS_NDI)			+= ndi
GST_PLUGINS_RS_ENABLEC-$(PTXCONF_GST_PLUGINS_RS_ONVIF)			+= onvif
GST_PLUGINS_RS_ENABLEP-$(PTXCONF_GST_PLUGINS_RS_ONVIF)			+= rsonvif
GST_PLUGINS_RS_ENABLEC-$(PTXCONF_GST_PLUGINS_RS_PNG)			+= png
GST_PLUGINS_RS_ENABLEP-$(PTXCONF_GST_PLUGINS_RS_PNG)			+= rspng
GST_PLUGINS_RS_ENABLE-$(PTXCONF_GST_PLUGINS_RS_RAPTORQ)			+= raptorq
GST_PLUGINS_RS_ENABLE-$(PTXCONF_GST_PLUGINS_RS_RAV1E)			+= rav1e
GST_PLUGINS_RS_ENABLE-$(PTXCONF_GST_PLUGINS_RS_REGEX)			+= regex
GST_PLUGINS_RS_ENABLE-$(PTXCONF_GST_PLUGINS_RS_REQWEST)			+= reqwest
GST_PLUGINS_RS_ENABLEC-$(PTXCONF_GST_PLUGINS_RS_RTP)			+= rtp
GST_PLUGINS_RS_ENABLEP-$(PTXCONF_GST_PLUGINS_RS_RTP)			+= rsrtp
GST_PLUGINS_RS_ENABLEC-$(PTXCONF_GST_PLUGINS_RS_RTSP)			+= rtsp
GST_PLUGINS_RS_ENABLEP-$(PTXCONF_GST_PLUGINS_RS_RTSP)			+= rsrtsp
GST_PLUGINS_RS_ENABLE-$(PTXCONF_GST_PLUGINS_RS_SODIUM)			+= sodium
GST_PLUGINS_RS_ENABLE-$(PTXCONF_GST_PLUGINS_RS_SPOTIFY)			+= spotify
GST_PLUGINS_RS_ENABLE-$(PTXCONF_GST_PLUGINS_RS_TEXTAHEAD)		+= textahead
GST_PLUGINS_RS_ENABLE-$(PTXCONF_GST_PLUGINS_RS_TEXTWRAP)		+= textwrap
GST_PLUGINS_RS_ENABLE-$(PTXCONF_GST_PLUGINS_RS_THREADSHARE)		+= threadshare
GST_PLUGINS_RS_ENABLE-$(PTXCONF_GST_PLUGINS_RS_TOGGLERECORD)		+= togglerecord
GST_PLUGINS_RS_ENABLEC-$(PTXCONF_GST_PLUGINS_RS_TRACERS)		+= tracers
GST_PLUGINS_RS_ENABLEP-$(PTXCONF_GST_PLUGINS_RS_TRACERS)		+= rstracers
GST_PLUGINS_RS_ENABLE-$(PTXCONF_GST_PLUGINS_RS_URIPLAYLISTBIN)		+= uriplaylistbin
GST_PLUGINS_RS_ENABLEC-$(PTXCONF_GST_PLUGINS_RS_VIDEOFX)		+= videofx
GST_PLUGINS_RS_ENABLEP-$(PTXCONF_GST_PLUGINS_RS_VIDEOFX)		+= rsvideofx
GST_PLUGINS_RS_ENABLEC-$(PTXCONF_GST_PLUGINS_RS_WEBP)			+= webp
GST_PLUGINS_RS_ENABLEP-$(PTXCONF_GST_PLUGINS_RS_WEBP)			+= rswebp
GST_PLUGINS_RS_ENABLEC-$(PTXCONF_GST_PLUGINS_RS_WEBRTC)			+= webrtc
GST_PLUGINS_RS_ENABLEP-$(PTXCONF_GST_PLUGINS_RS_WEBRTC)			+= rswebrtc
GST_PLUGINS_RS_ENABLE-$(PTXCONF_GST_PLUGINS_RS_WEBRTCHTTP)		+= webrtchttp

GST_PLUGINS_RS_ENABLEC-		+= $(GST_PLUGINS_RS_ENABLE-)
GST_PLUGINS_RS_ENABLEC-y	+= $(GST_PLUGINS_RS_ENABLE-y)
GST_PLUGINS_RS_ENABLEP-y	+= $(GST_PLUGINS_RS_ENABLE-y)
#
# meson
#
GST_PLUGINS_RS_CONF_TOOL	:= meson
GST_PLUGINS_RS_CONF_OPT	:=  \
	$(CROSS_MESON_USR) \
	-Ddebug=false \
	-Ddoc=disabled \
	-Dexamples=disabled \
	-Dfrozen=true \
	-Dtests=disabled

ifneq ($(call remove_quotes,$(GST_PLUGINS_RS_ENABLEC-y)),)
GST_PLUGINS_RS_CONF_OPT +=  $(addsuffix =enabled, $(addprefix -D, $(GST_PLUGINS_RS_ENABLEC-y)))
endif

ifneq ($(call remove_quotes,$(GST_PLUGINS_RS_ENABLEC-)),)
GST_PLUGINS_RS_CONF_OPT +=  $(addsuffix =disabled, $(addprefix -D, $(GST_PLUGINS_RS_ENABLEC-)))
endif


GST_PLUGINS_RS_MAKE_ENV		:= \
	$(CROSS_CARGO_ENV)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gst-plugins-rs.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gst-plugins-rs)
	@$(call install_fixup, gst-plugins-rs,PRIORITY,optional)
	@$(call install_fixup, gst-plugins-rs,SECTION,base)
	@$(call install_fixup, gst-plugins-rs,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, gst-plugins-rs,DESCRIPTION,missing)

ifdef PTXCONF_GST_PLUGINS_BAD1_WEBRTC
	@$(call install_copy, gst-plugins-rs, 0, 0, 0755, -, \
		/usr/bin/gst-webrtc-signalling-server)
endif

#	# install all activated plugins
	@$(foreach plugin,$(GST_PLUGINS_RS_ENABLEP-y), \
		$(call install_copy, gst-plugins-rs, 0, 0, 0644, -, \
			/usr/lib/gstreamer-1.0/libgst$(plugin).so)$(ptx/nl))

	@$(call install_finish, gst-plugins-rs)

	@$(call touch)

# vim: syntax=make
