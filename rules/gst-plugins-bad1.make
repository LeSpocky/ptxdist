# -*-makefile-*-
#
# Copyright (C) 2010 by Erwin Rol <erwin@erwinrol.com>
# Copyright (C) 2008 by Sascha Hauer
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GST_PLUGINS_BAD1) += gst-plugins-bad1

#
# Paths and names
#
GST_PLUGINS_BAD1_VERSION	:= 1.12.4
GST_PLUGINS_BAD1_MD5		:= 64bf16cf15edaab1c0e02c8dee7170d0
GST_PLUGINS_BAD1		:= gst-plugins-bad-$(GST_PLUGINS_BAD1_VERSION)
GST_PLUGINS_BAD1_SUFFIX		:= tar.xz
GST_PLUGINS_BAD1_URL		:= http://gstreamer.freedesktop.org/src/gst-plugins-bad/$(GST_PLUGINS_BAD1).$(GST_PLUGINS_BAD1_SUFFIX)
GST_PLUGINS_BAD1_SOURCE		:= $(SRCDIR)/$(GST_PLUGINS_BAD1).$(GST_PLUGINS_BAD1_SUFFIX)
GST_PLUGINS_BAD1_DIR		:= $(BUILDDIR)/$(GST_PLUGINS_BAD1)
GST_PLUGINS_BAD1_LICENSE	:= LGPL-2.1+


# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_ACCURIP)		+= accurip
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_ADPCMDEC)		+= adpcmdec
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_ADPCMENC)		+= adpcmenc
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_AIFF)		+= aiff
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_ASFMUX)		+= asfmux
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_AUDIOBUFFERSPLIT)	+= audiobuffersplit
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_AUDIOFXBAD)		+= audiofxbad
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_AUDIOMIXER)		+= audiomixer
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_AUDIOMIXMATRIX)	+= audiomixmatrix
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_COMPOSITOR)		+= compositor
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_AUDIOVISUALIZERS)	+= audiovisualizers
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_AUTOCONVERT)		+= autoconvert
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_BAYER)		+= bayer
GST_PLUGINS_BAD1_ENABLEC-$(PTXCONF_GST_PLUGINS_BAD1_CAMERABIN2)		+= camerabin2
GST_PLUGINS_BAD1_ENABLEP-$(PTXCONF_GST_PLUGINS_BAD1_CAMERABIN2)		+= camerabin
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_COLOREFFECTS)	+= coloreffects
GST_PLUGINS_BAD1_ENABLEC-$(PTXCONF_GST_PLUGINS_BAD1_DEBUGUTILS)		+= debugutils
GST_PLUGINS_BAD1_ENABLEP-$(PTXCONF_GST_PLUGINS_BAD1_DEBUGUTILS)		+= debugutilsbad
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_DVBSUBOVERLAY)	+= dvbsuboverlay
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_DVDSPU)		+= dvdspu
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_FACEOVERLAY)		+= faceoverlay
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_FESTIVAL)		+= festival
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_FIELDANALYSIS)	+= fieldanalysis
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_FREEVERB)		+= freeverb
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_FREI0R)		+= frei0r
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_GAUDIEFFECTS)	+= gaudieffects
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_GEOMETRICTRANSFORM)	+= geometrictransform
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_GDP)			+= gdp
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_ID3TAG)		+= id3tag
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_INTER)		+= inter
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_INTERLACE)		+= interlace
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_IQA)			+= iqa
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_IVFPARSE)		+= ivfparse
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_IVTC)		+= ivtc
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_JP2KDECIMATOR)	+= jp2kdecimator
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_JPEGFORMAT)		+= jpegformat
GST_PLUGINS_BAD1_ENABLEC-$(PTXCONF_GST_PLUGINS_BAD1_LIBRFB)		+= librfb
GST_PLUGINS_BAD1_ENABLEP-$(PTXCONF_GST_PLUGINS_BAD1_LIBRFB)		+= rfbsrc
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_MIDI)		+= midi
GST_PLUGINS_BAD1_ENABLEC-$(PTXCONF_GST_PLUGINS_BAD1_MPEGDEMUX)		+= mpegdemux
GST_PLUGINS_BAD1_ENABLEP-$(PTXCONF_GST_PLUGINS_BAD1_MPEGDEMUX)		+= mpegpsdemux
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_MPEGTSDEMUX)		+= mpegtsdemux
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_MPEGTSMUX)		+= mpegtsmux
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_MPEGPSMUX)		+= mpegpsmux
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_MXF)			+= mxf
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_NETSIM)		+= netsim
GST_PLUGINS_BAD1_ENABLEC-$(PTXCONF_GST_PLUGINS_BAD1_ONVIF)		+= onvif
GST_PLUGINS_BAD1_ENABLEP-$(PTXCONF_GST_PLUGINS_BAD1_ONVIF)		+= rtponvif
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_PCAPPARSE)		+= pcapparse
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_PNM)			+= pnm
GST_PLUGINS_BAD1_ENABLEC-$(PTXCONF_GST_PLUGINS_BAD1_RAWPARSE)		+= rawparse
GST_PLUGINS_BAD1_ENABLEP-$(PTXCONF_GST_PLUGINS_BAD1_RAWPARSE)		+= legacyrawparse
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_REMOVESILENCE)	+= removesilence
GST_PLUGINS_BAD1_ENABLEC-$(PTXCONF_GST_PLUGINS_BAD1_SDP)		+= sdp
GST_PLUGINS_BAD1_ENABLEP-$(PTXCONF_GST_PLUGINS_BAD1_SDP)		+= sdpelem
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_SEGMENTCLIP)		+= segmentclip
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_SIREN)		+= siren
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_SMOOTH)		+= smooth
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_SPEED)		+= speed
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_SUBENC)		+= subenc
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_STEREO)		+= stereo
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_TIMECODE)		+= timecode
GST_PLUGINS_BAD1_ENABLEC-$(PTXCONF_GST_PLUGINS_BAD1_VIDEOFILTERS)	+= videofilters
GST_PLUGINS_BAD1_ENABLEP-$(PTXCONF_GST_PLUGINS_BAD1_VIDEOFILTERS)	+= videofiltersbad
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_VIDEOFRAME_AUDIOLEVEL) += videoframe_audiolevel
GST_PLUGINS_BAD1_ENABLEC-$(PTXCONF_GST_PLUGINS_BAD1_VIDEOPARSERS)	+= videoparsers
GST_PLUGINS_BAD1_ENABLEP-$(PTXCONF_GST_PLUGINS_BAD1_VIDEOPARSERS)	+= videoparsersbad
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_VIDEOSIGNAL)		+= videosignal
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_VMNC)		+= vmnc
GST_PLUGINS_BAD1_ENABLEC-$(PTXCONF_GST_PLUGINS_BAD1_Y4M)		+= y4m
GST_PLUGINS_BAD1_ENABLED-$(PTXCONF_GST_PLUGINS_BAD1_Y4M)		+= y4mdec
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_YADIF)		+= yadif
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_BLUEZ)		+= bluez
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_AVC)			+= avc
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_SHM)			+= shm
GST_PLUGINS_BAD1_ENABLEC-$(PTXCONF_GST_PLUGINS_BAD1_VCD)		+= vcd
GST_PLUGINS_BAD1_ENABLEP-$(PTXCONF_GST_PLUGINS_BAD1_VCD)		+= vcdsrc
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_OPENSLES)		+= opensles
GST_PLUGINS_BAD1_ENABLEC-$(PTXCONF_GST_PLUGINS_BAD1_TTML)		+= ttml
GST_PLUGINS_BAD1_ENABLEP-$(PTXCONF_GST_PLUGINS_BAD1_TTML)		+= ttmlsubs
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_UVCH264)		+= uvch264
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_NVENC)		+= nvenc
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_TINYALSA)		+= tinyalsa
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_ASSRENDER)		+= assrender
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_VOAMRWBENC)		+= voamrwbenc
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_VOAACENC)		+= voaacenc
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_BS2B)		+= bs2b
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_BZ2)			+= bz2
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_CHROMAPRINT)		+= chromaprint
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_CURL)		+= curl
GST_PLUGINS_BAD1_ENABLEC-$(PTXCONF_GST_PLUGINS_BAD1_DASH)		+= dash
GST_PLUGINS_BAD1_ENABLEP-$(PTXCONF_GST_PLUGINS_BAD1_DASH)		+= dashdemux
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_DC1394)		+= dc1394
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_DECKLINK)		+= decklink
GST_PLUGINS_BAD1_ENABLEC-$(PTXCONF_GST_PLUGINS_BAD1_DIRECTFB)		+= directfb
GST_PLUGINS_BAD1_ENABLEP-$(PTXCONF_GST_PLUGINS_BAD1_DIRECTFB)		+= dfbvideosink
GST_PLUGINS_BAD1_ENABLEC-$(PTXCONF_GST_PLUGINS_BAD1_WAYLAND)		+= wayland
GST_PLUGINS_BAD1_ENABLEP-$(PTXCONF_GST_PLUGINS_BAD1_WAYLAND)		+= waylandsink
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_WEBP)		+= webp
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_DAALA)		+= daala
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_DTS)			+= dts
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_RESINDVD)		+= resindvd
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_FAAC)		+= faac
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_FAAD)		+= faad
GST_PLUGINS_BAD1_ENABLEC-$(PTXCONF_GST_PLUGINS_BAD1_FBDEV)		+= fbdev
GST_PLUGINS_BAD1_ENABLEP-$(PTXCONF_GST_PLUGINS_BAD1_FBDEV)		+= fbdevsink
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_FDK_AAC)		+= fdk_aac
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_FLITE)		+= flite
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_GSM)			+= gsm
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_FLUIDSYNTH)		+= fluidsynth
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_KATE)		+= kate
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_KMS)			+= kms
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_LADSPA)		+= ladspa
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_LV2)			+= lv2
GST_PLUGINS_BAD1_ENABLEC-$(PTXCONF_GST_PLUGINS_BAD1_LIBDE265)		+= libde265
GST_PLUGINS_BAD1_ENABLEC-$(PTXCONF_GST_PLUGINS_BAD1_LIBMMS)		+= libmms
GST_PLUGINS_BAD1_ENABLEP-$(PTXCONF_GST_PLUGINS_BAD1_LIBMMS)		+= mms
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_SRTP)		+= srtp
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_DTLS)		+= dtls
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_MODPLUG)		+= modplug
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_MPEG2ENC)		+= mpeg2enc
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_MPLEX)		+= mplex
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_MSDK)		+= msdk
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_MUSEPACK)		+= musepack
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_NEON)		+= neon
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_OFA)			+= ofa
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_OPENAL)		+= openal
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_OPENCV)		+= opencv
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_OPENEXR)		+= openexr
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_OPENH264)		+= openh264
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_OPENJPEG)		+= openjpeg
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_OPENNI2)		+= openni2
GST_PLUGINS_BAD1_ENABLEC-$(PTXCONF_GST_PLUGINS_BAD1_OPUS)		+= opus
GST_PLUGINS_BAD1_ENABLEP-$(PTXCONF_GST_PLUGINS_BAD1_OPUS)		+= opusparse
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_RSVG)		+= rsvg
GST_PLUGINS_BAD1_ENABLEC-$(PTXCONF_GST_PLUGINS_BAD1_OPENGL)		+= opengl
GST_PLUGINS_BAD1_ENABLEC-$(PTXCONF_GST_PLUGINS_BAD1_GLES2)		+= gles2
GST_PLUGINS_BAD1_ENABLEC-$(PTXCONF_GST_PLUGINS_BAD1_EGL)		+= egl
GST_PLUGINS_BAD1_ENABLEC-$(PTXCONF_GST_PLUGINS_BAD1_GLX)		+= glx
GST_PLUGINS_BAD1_ENABLEC-$(PTXCONF_GST_PLUGINS_BAD1_X11)		+= x11
GST_PLUGINS_BAD1_ENABLEC-$(PTXCONF_GST_PLUGINS_BAD1_GL)			+= gl
GST_PLUGINS_BAD1_ENABLEP-$(PTXCONF_GST_PLUGINS_BAD1_GL)			+= opengl
GST_PLUGINS_BAD1_ENABLEC-$(PTXCONF_GST_PLUGINS_BAD1_GTK3)		+= gtk3
GST_PLUGINS_BAD1_ENABLEC-$(PTXCONF_GST_PLUGINS_BAD1_QT)			+= qt
GST_PLUGINS_BAD1_ENABLEC-$(PTXCONF_GST_PLUGINS_BAD1_VULKAN)		+= vulkan
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_TELETEXTDEC)		+= teletextdec
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_WILDMIDI)		+= wildmidi
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_SMOOTHSTREAMING)	+= smoothstreaming
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_SNDFILE)		+= sndfile
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_SOUNDTOUCH)		+= soundtouch
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_SPC)			+= spc
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_GME)			+= gme
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_DVB)			+= dvb
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_ACM)			+= acm
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_VDPAU)		+= vdpau
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_SBC)			+= sbc
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_SCHRO)		+= schro
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_ZBAR)		+= zbar
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_RTMP)		+= rtmp
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_SPANDSP)		+= spandsp
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_HLS)			+= hls
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_X265)		+= x265
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_WEBRTCDSP)		+= webrtcdsp

GST_PLUGINS_BAD1_ENABLEC-y	+= $(GST_PLUGINS_BAD1_ENABLE-y)
GST_PLUGINS_BAD1_ENABLEC-	+= $(GST_PLUGINS_BAD1_ENABLE-)
GST_PLUGINS_BAD1_ENABLEP-y	+= $(GST_PLUGINS_BAD1_ENABLE-y)

ifdef PTXCONF_KERNEL_HEADER
# for new linux/videodev2.h from kernel headers
GST_PLUGINS_BAD1_CONF_ENV := \
	$(CROSS_ENV) \
	CPPFLAGS="$(CROSS_CPPFLAGS) -isystem $(KERNEL_HEADERS_INCLUDE_DIR)"
endif

#
# autoconf
#
GST_PLUGINS_BAD1_CONF_TOOL	:= autoconf

GST_PLUGINS_BAD1_CONF_OPT = \
	$(CROSS_AUTOCONF_USR) \
	$(GSTREAMER1_GENERIC_CONF_OPT) \
	\
	--enable-external \
	--enable-experimental \
	--$(call ptx/endis, PTXCONF_GSTREAMER1_INTROSPECTION)-introspection \
	\
	--enable-orc \
	\
	--disable-wgl \
	--disable-cocoa \
	--disable-dispmanx \
	--disable-directsound \
	--disable-wasapi \
	--disable-direct3d \
	--disable-winscreencap \
	--disable-winks \
	--disable-android_media \
	--disable-apple_media \
	--without-jpeg-mmx \
	--without-player-tests \
	$(call ptx/ifdef,PTXCONF_GST_PLUGINS_BAD1_HLS,--with-hls-crypto=openssl)

ifneq ($(call remove_quotes,$(GST_PLUGINS_BAD1_ENABLEC-y)),)
GST_PLUGINS_BAD1_CONF_OPT +=  --enable-$(subst $(space),$(space)--enable-,$(strip $(GST_PLUGINS_BAD1_ENABLEC-y)))
endif

ifneq ($(call remove_quotes,$(GST_PLUGINS_BAD1_ENABLEC-)),)
GST_PLUGINS_BAD1_CONF_OPT +=  --disable-$(subst $(space),$(space)--disable-,$(strip $(GST_PLUGINS_BAD1_ENABLEC-)))
endif

#  --enable-gobject-cast-checks=[no/auto/yes] Enable GObject cast checks


# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gst-plugins-bad1.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gst-plugins-bad1)
	@$(call install_fixup, gst-plugins-bad1,PRIORITY,optional)
	@$(call install_fixup, gst-plugins-bad1,SECTION,base)
	@$(call install_fixup, gst-plugins-bad1,AUTHOR,"Sascha Hauer")
	@$(call install_fixup, gst-plugins-bad1,DESCRIPTION,missing)

#	# install all activated libs
	@cd $(GST_PLUGINS_BAD1_PKGDIR)/usr/lib/ && \
	for libs in `find -name "*-1.0.so" -printf '%f\n'`; do \
		$(call install_lib, gst-plugins-bad1, 0, 0, 0644, $${libs%.so}); \
	done

#	# install all activated plugins
	@for plugin in $(GST_PLUGINS_BAD1_ENABLEP-y); do \
		$(call install_copy, gst-plugins-bad1, 0, 0, 0644, -, \
			/usr/lib/gstreamer-1.0/libgst$${plugin}.so); \
	done

ifdef PTXCONF_GSTREAMER1_INTROSPECTION
	@$(call install_tree, gst-plugins-bad1, 0, 0, -, \
		/usr/lib/girepository-1.0)
endif

	@$(call install_finish, gst-plugins-bad1)

	@$(call touch)

# vim: syntax=make
