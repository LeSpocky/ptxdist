# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ALSA_UTILS) += alsa-utils

#
# Paths and names
#
ALSA_UTILS_VERSION	:= 1.2.14
ALSA_UTILS_MD5		:= d098c3d677ee80cf3d9f87783cce2e53
ALSA_UTILS		:= alsa-utils-$(ALSA_UTILS_VERSION)
ALSA_UTILS_SUFFIX	:= tar.bz2
ALSA_UTILS_URL		:= https://www.alsa-project.org/files/pub/utils/$(ALSA_UTILS).$(ALSA_UTILS_SUFFIX)
ALSA_UTILS_SOURCE	:= $(SRCDIR)/$(ALSA_UTILS).$(ALSA_UTILS_SUFFIX)
ALSA_UTILS_DIR		:= $(BUILDDIR)/$(ALSA_UTILS)
ALSA_UTILS_LICENSE	:= GPL-2.0-or-later
ALSA_UTILS_LICENSE_FILES := \
	file://alsactl/alsactl.c;startline=1;endline=21;md5=9c69f9af8d230fd294d7340e2db094f6 \
	file://COPYING;md5=59530bdf33659b29e73d4adb9f9f6552

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------


ALSA_UTILS_CONF_ENV	:= \
	$(CROSS_ENV) \
	ac_cv_header_alsa_mixer_h=$(if $(PTXCONF_ALSA_UTILS_ALSAMIXER)$(PTXCONF_ALSA_UTILS_AMIXER),yes,no) \
	ac_cv_header_alsa_rawmidi_h=$(call ptx/yesno, PTXCONF_ALSA_UTILS_RAW_MIDI) \
	ac_cv_lib_asound_snd_seq_client_info_get_midi_version=$(call ptx/yesno, PTXCONF_ALSA_UTILS_MIDI)

#
# autoconf
#
ALSA_UTILS_CONF_TOOL	:= autoconf
ALSA_UTILS_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-nls \
	--disable-rpath \
	--enable-alsa-topology \
	--disable-alsatest \
	--disable-alsabat-backend-tiny \
	--disable-bat \
	--$(call ptx/endis, PTXCONF_ALSA_UTILS_ALSAMIXER)-alsamixer \
	--enable-alsaconf \
	--$(call ptx/endis, PTXCONF_ALSA_UTILS_ALSALOOP)-alsaloop \
	--disable-nhlt \
	--disable-xmlto \
	--disable-rst2man \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--without-librt \
	--with-udev-rules-dir=/usr/lib/udev/rules.d \
	--with-curses=$(call ptx/ifdef,PTXCONF_ALSA_UTILS_ALSAMIXER,$(call ptx/ifdef,PTXCONF_NCURSES_WIDE_CHAR,ncursesw,ncurses),no) \
	--with-systemdsystemunitdir=$(call ptx/ifdef,PTXCONF_ALSA_UTILS_SYSTEMD_UNIT,/usr/lib/systemd/system,no) \
	--with-asound-state-dir=/etc

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/alsa-utils.targetinstall:
	@$(call targetinfo)

	@$(call install_init, alsa-utils)
	@$(call install_fixup, alsa-utils, PRIORITY, optional)
	@$(call install_fixup, alsa-utils, SECTION, base)
	@$(call install_fixup, alsa-utils, AUTHOR, "Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, alsa-utils, DESCRIPTION, missing)

	@$(call install_copy, alsa-utils, 0, 0, 0755, -, /usr/sbin/alsactl)
ifdef PTXCONF_ALSA_UTILS_RAW_MIDI
	@$(call install_copy, alsa-utils, 0, 0, 0755, -, /usr/bin/amidi)
endif
ifdef PTXCONF_ALSA_UTILS_AMIXER
	@$(call install_copy, alsa-utils, 0, 0, 0755, -, /usr/bin/amixer)
endif
ifdef PTXCONF_ALSA_UTILS_APLAYRECORD
	@$(call install_copy, alsa-utils, 0, 0, 0755, -, /usr/bin/aplay)
#	# same utility for recording - only a link is required
	@$(call install_link, alsa-utils, aplay, /usr/bin/arecord)
endif
ifdef PTXCONF_ALSA_UTILS_IECSET
	@$(call install_copy, alsa-utils, 0, 0, 0755, -, /usr/bin/iecset)
endif
ifdef PTXCONF_ALSA_UTILS_ACONNECT
	@$(call install_copy, alsa-utils, 0, 0, 0755, -, /usr/bin/aconnect)
endif
ifdef PTXCONF_ALSA_UTILS_MIDI
	@$(call install_copy, alsa-utils, 0, 0, 0755, -, /usr/bin/aplaymidi)
	@$(call install_copy, alsa-utils, 0, 0, 0755, -, /usr/bin/arecordmidi)
endif
ifdef PTXCONF_ALSA_UTILS_SEQTOOLS
	@$(call install_copy, alsa-utils, 0, 0, 0755, -, /usr/bin/aseqdump)
	@$(call install_copy, alsa-utils, 0, 0, 0755, -, /usr/bin/aseqnet)
endif
ifdef PTXCONF_ALSA_UTILS_USE_CASE_MANAGER
	@$(call install_copy, alsa-utils, 0, 0, 0755, -, /usr/bin/alsaucm)
endif
ifdef PTXCONF_ALSA_UTILS_ALSAMIXER
	@$(call install_copy, alsa-utils, 0, 0, 0755, -, /usr/bin/alsamixer)
endif
ifdef PTXCONF_ALSA_UTILS_ALSALOOP
	@$(call install_copy, alsa-utils, 0, 0, 0755, -, /usr/bin/alsaloop)
endif

ifdef PTXCONF_ALSA_UTILS_STARTSCRIPT
	@$(call install_alternative, alsa-utils, 0, 0, 0755, /etc/init.d/alsa-utils, n)
ifneq ($(call remove_quotes,$(PTXCONF_ALSA_UTILS_BBINIT_LINK)),)
	@$(call install_link, alsa-utils, \
		../init.d/alsa-utils, \
		/etc/rc.d/$(PTXCONF_ALSA_UTILS_BBINIT_LINK))
endif
endif
ifdef PTXCONF_ALSA_UTILS_SYSTEMD_UNIT
	@$(call install_alternative, alsa-utils, 0, 0, 0644, \
		/usr/lib/systemd/system/alsa-restore.service)
	@$(call install_link, alsa-utils, ../alsa-restore.service, \
		/usr/lib/systemd/system/basic.target.wants/alsa-restore.service)
endif

ifdef PTXCONF_ALSA_UTILS_ASOUND_STATE
	@$(call install_alternative, alsa-utils, 0, 0, 0644, \
		/etc/asound.state, n)
endif
	@$(call install_finish, alsa-utils)

	@$(call touch)

# vim: syntax=make

