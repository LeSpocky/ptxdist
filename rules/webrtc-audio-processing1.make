# -*-makefile-*-
#
# Copyright (C) 2023 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_WEBRTC_AUDIO_PROCESSING1) += webrtc-audio-processing1

#
# Paths and names
#
WEBRTC_AUDIO_PROCESSING1_VERSION	:= 1.3
WEBRTC_AUDIO_PROCESSING1_MD5		:= eca8e8d43da82e430080abac5969b7f1
WEBRTC_AUDIO_PROCESSING1		:= webrtc-audio-processing-$(WEBRTC_AUDIO_PROCESSING1_VERSION)
WEBRTC_AUDIO_PROCESSING1_SUFFIX		:= tar.xz
WEBRTC_AUDIO_PROCESSING1_URL		:= http://www.freedesktop.org/software/pulseaudio/webrtc-audio-processing/$(WEBRTC_AUDIO_PROCESSING1).$(WEBRTC_AUDIO_PROCESSING1_SUFFIX)
WEBRTC_AUDIO_PROCESSING1_SOURCE		:= $(SRCDIR)/$(WEBRTC_AUDIO_PROCESSING1).$(WEBRTC_AUDIO_PROCESSING1_SUFFIX)
WEBRTC_AUDIO_PROCESSING1_DIR		:= $(BUILDDIR)/$(WEBRTC_AUDIO_PROCESSING1)
WEBRTC_AUDIO_PROCESSING1_LICENSE	:= BSD-3-Clause
WEBRTC_AUDIO_PROCESSING1_LICENSE_FILES	:= \
	file://COPYING;md5=da08a38a32a340c5d91e13ee86a118f2 \
	file://webrtc/rtc_base/event_tracer.cc;startline=1;endline=9;md5=cf8bceb850480c360f23d2a217437370

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# meson
#
WEBRTC_AUDIO_PROCESSING1_CONF_TOOL	:= meson
WEBRTC_AUDIO_PROCESSING1_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Dgnustl=disabled \
	-Dneon=$(call ptx/yesno, PTXCONF_ARCH_ARM_NEON)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/webrtc-audio-processing1.targetinstall:
	@$(call targetinfo)

	@$(call install_init, webrtc-audio-processing1)
	@$(call install_fixup, webrtc-audio-processing1,PRIORITY,optional)
	@$(call install_fixup, webrtc-audio-processing1,SECTION,base)
	@$(call install_fixup, webrtc-audio-processing1,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, webrtc-audio-processing1,DESCRIPTION,missing)

	@$(call install_lib, webrtc-audio-processing1, 0, 0, 0644, libwebrtc-audio-processing-1)
	@$(call install_lib, webrtc-audio-processing1, 0, 0, 0644, libwebrtc-audio-coding-1)

	@$(call install_finish, webrtc-audio-processing1)

	@$(call touch)

# vim: syntax=make
