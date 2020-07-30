# -*-makefile-*-
#
# Copyright (C) 2019 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_WEBRTC_AUDIO_PROCESSING) += webrtc-audio-processing

#
# Paths and names
#
WEBRTC_AUDIO_PROCESSING_VERSION		:= 0.3.1
WEBRTC_AUDIO_PROCESSING_MD5		:= 6e10724ca34bcbc715a4c208273acb0c
WEBRTC_AUDIO_PROCESSING			:= webrtc-audio-processing-$(WEBRTC_AUDIO_PROCESSING_VERSION)
WEBRTC_AUDIO_PROCESSING_SUFFIX		:= tar.xz
WEBRTC_AUDIO_PROCESSING_URL		:= http://freedesktop.org/software/pulseaudio/webrtc-audio-processing/$(WEBRTC_AUDIO_PROCESSING).$(WEBRTC_AUDIO_PROCESSING_SUFFIX)
WEBRTC_AUDIO_PROCESSING_SOURCE		:= $(SRCDIR)/$(WEBRTC_AUDIO_PROCESSING).$(WEBRTC_AUDIO_PROCESSING_SUFFIX)
WEBRTC_AUDIO_PROCESSING_DIR		:= $(BUILDDIR)/$(WEBRTC_AUDIO_PROCESSING)
WEBRTC_AUDIO_PROCESSING_LICENSE		:= BSD-3-Clause
WEBRTC_AUDIO_PROCESSING_LICENSE_FILES	:= \
	file://COPYING;md5=da08a38a32a340c5d91e13ee86a118f2 \
	file://webrtc/common_types.cc;startline=1;endline=9;md5=cf8bceb850480c360f23d2a217437370

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
WEBRTC_AUDIO_PROCESSING_CONF_TOOL	:= autoconf
WEBRTC_AUDIO_PROCESSING_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--$(call ptx/endis, PTXCONF_ARCH_ARM_NEON)-neon \
	--with-ns-mode=float \
	--without-gnustl

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/webrtc-audio-processing.targetinstall:
	@$(call targetinfo)

	@$(call install_init, webrtc-audio-processing)
	@$(call install_fixup, webrtc-audio-processing,PRIORITY,optional)
	@$(call install_fixup, webrtc-audio-processing,SECTION,base)
	@$(call install_fixup, webrtc-audio-processing,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, webrtc-audio-processing,DESCRIPTION,missing)

	@$(call install_lib, webrtc-audio-processing, 0, 0, 0644, libwebrtc_audio_processing)

	@$(call install_finish, webrtc-audio-processing)

	@$(call touch)

# vim: syntax=make
