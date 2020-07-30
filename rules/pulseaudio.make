# -*-makefile-*-
#
# Copyright (C) 2015 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PULSEAUDIO) += pulseaudio

#
# Paths and names
#
PULSEAUDIO_VERSION	:= 13.0
PULSEAUDIO_MD5		:= e41d606f90254ed45c90520faf83d95c
PULSEAUDIO		:= pulseaudio-$(PULSEAUDIO_VERSION)
PULSEAUDIO_SUFFIX	:= tar.xz
PULSEAUDIO_URL		:= http://freedesktop.org/software/pulseaudio/releases/$(PULSEAUDIO).$(PULSEAUDIO_SUFFIX)
PULSEAUDIO_SOURCE	:= $(SRCDIR)/$(PULSEAUDIO).$(PULSEAUDIO_SUFFIX)
PULSEAUDIO_DIR		:= $(BUILDDIR)/$(PULSEAUDIO)
PULSEAUDIO_LICENSE	:= MIT AND GPL-2.0-or-later AND LGPL-2.1-or-later AND Rdisc AND ADRIAN
PULSEAUDIO_LICENSE_FILES	:= \
	file://LICENSE;md5=0e5cd938de1a7a53ea5adac38cc10c39 \
	file://GPL;md5=4325afd396febcb659c36b49533135d4 \
	file://LGPL;md5=2d5025d4aa3495befef8f17206a5b0a1 \
	file://src/pulsecore/g711.c;startline=2;endline=24;md5=663902612456e1794f328632f8b6a20a \
	file://src/modules/echo-cancel/adrian-license.txt;md5=abbab006a561fbffccedf1c3531f34ab

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PULSEAUDIO_CONF_ENV	:= \
	$(CROSS_MESON_ENV) \
	ORCC=orcc

#
# autoconf
#
PULSEAUDIO_CONF_TOOL	:= meson
PULSEAUDIO_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Daccess_group=pulse-access \
	-Dadrian-aec=$(call ptx/falsetrue, PTXCONF_PULSEAUDIO_WEBRTC_AEC) \
	-Dalsa=enabled \
	-Dasyncns=disabled \
	-Datomic-arm-linux-helpers=true \
	-Datomic-arm-memory-barrier=true \
	-Davahi=disabled \
	-Dbluez5=$(call ptx/truefalse, PTXCONF_PULSEAUDIO_BLUETOOTH) \
	-Dbluez5-native-headset=$(call ptx/truefalse, PTXCONF_PULSEAUDIO_BLUETOOTH) \
	-Dbluez5-ofono-headset=false \
	-Ddatabase=simple \
	-Ddbus=$(call ptx/endis, PTXCONF_PULSEAUDIO_BLUETOOTH)d \
	-Dfftw=disabled \
	-Dgcov=false \
	-Dglib=disabled \
	-Dgsettings=disabled \
	-Dgtk=disabled \
	-Dhal-compat=false \
	-Dipv6=$(call ptx/truefalse, PTXCONF_GLOBAL_IPV6) \
	-Djack=disabled \
	-Dlegacy-database-entry-format=false \
	-Dlirc=disabled \
	-Dman=false \
	-Dmodlibexecdir=/usr/lib/pulse-$(PULSEAUDIO_VERSION)/modules \
	-Dopenssl=disabled \
	-Dorc=enabled \
	-Dpadsplibdir= \
	-Dpulsedsp-location= \
	-Drunning-from-build-tree=false \
	-Dsamplerate=disabled \
	-Dsoxr=disabled \
	-Dspeex=$(call ptx/endis, PTXCONF_PULSEAUDIO_SPEEX)d \
	-Dsystem_group= \
	-Dsystem_user= \
	-Dsystemd=$(call ptx/endis, PTXCONF_PULSEAUDIO_SYSTEMD)d \
	-Dsystemduserunitdir=/usr/lib/systemd/user \
	-Dtests=false \
	-Dudev=enabled \
	-Dudevrulesdir=/lib/udev/rules.d \
	-Dwebrtc-aec=$(call ptx/endis, PTXCONF_PULSEAUDIO_WEBRTC_AEC)d \
	-Dx11=disabled \
	-Dzshcompletiondir=

PULSEAUDIO_LDFLAGS	:= -Wl,-rpath,/usr/lib/pulseaudio:/usr/lib/pulse-$(PULSEAUDIO_VERSION)/modules

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/pulseaudio.install:
	@$(call targetinfo)
	@$(call world/install, PULSEAUDIO)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/pulseaudio.targetinstall:
	@$(call targetinfo)

	@$(call install_init, pulseaudio)
	@$(call install_fixup, pulseaudio,PRIORITY,optional)
	@$(call install_fixup, pulseaudio,SECTION,base)
	@$(call install_fixup, pulseaudio,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, pulseaudio,DESCRIPTION,missing)

	@$(call install_alternative, pulseaudio, 0, 0, 0644, /etc/pulse/client.conf)
	@$(call install_alternative, pulseaudio, 0, 0, 0644, /etc/pulse/daemon.conf)
	@$(call install_alternative, pulseaudio, 0, 0, 0644, /etc/pulse/system.pa)
	@$(call install_alternative, pulseaudio, 0, 0, 0644, /etc/pulse/default.pa)

ifdef PTXCONF_PULSEAUDIO_BLUETOOTH
	@$(call install_alternative, pulseaudio, 0, 0, 0644, \
		/etc/dbus-1/system.d/pulseaudio-system.conf)
endif

ifdef PTXCONF_PULSEAUDIO_SYSTEMD
	@$(call install_alternative, pulseaudio, 0, 0, 0644, \
		/usr/lib/systemd/system/pulseaudio.service)
	@$(call install_alternative, pulseaudio, 0, 0, 0644, \
		/usr/lib/systemd/system/pulseaudio.socket)
	@$(call install_link, pulseaudio, ../pulseaudio.socket, \
		/usr/lib/systemd/system/sockets.target.wants/pulseaudio.socket)
ifdef PTXCONF_PULSEAUDIO_SYSTEMD_USER
	@$(call install_alternative, pulseaudio, 0, 0, 0644, \
		/usr/lib/systemd/user/pulseaudio.service)
	@$(call install_alternative, pulseaudio, 0, 0, 0644, \
		/usr/lib/systemd/user/pulseaudio.socket)
	@$(call install_link, pulseaudio, ../pulseaudio.socket, \
		/usr/lib/systemd/user/sockets.target.wants/pulseaudio.socket)
endif
endif

	@$(call install_copy, pulseaudio, 0, 0, 0755, -, /usr/bin/pulseaudio)
	@$(call install_copy, pulseaudio, 0, 0, 0755, -, /usr/bin/pactl)
	@$(call install_copy, pulseaudio, 0, 0, 0755, -, /usr/bin/pacmd)
	@$(call install_copy, pulseaudio, 0, 0, 0755, -, /usr/bin/pacat)
	@$(call install_link, pulseaudio, pacat, /usr/bin/pamon)
	@$(call install_link, pulseaudio, pacat, /usr/bin/paplay)
	@$(call install_link, pulseaudio, pacat, /usr/bin/parec)
	@$(call install_link, pulseaudio, pacat, /usr/bin/parecord)

	@$(call install_lib, pulseaudio, 0, 0, 0644, libpulse)
	@$(call install_lib, pulseaudio, 0, 0, 0644, libpulse-simple)
	@$(call install_lib, pulseaudio, 0, 0, 0644, pulseaudio/libpulsecore-$(PULSEAUDIO_VERSION))
	@$(call install_lib, pulseaudio, 0, 0, 0644, pulseaudio/libpulsecommon-$(PULSEAUDIO_VERSION))
	@$(call install_tree, pulseaudio, 0, 0, -, /usr/lib/pulse-$(PULSEAUDIO_VERSION)/modules)

	@$(call install_tree, pulseaudio, 0, 0, -, /usr/share/pulseaudio)

	@$(call install_finish, pulseaudio)

	@$(call touch)

# vim: syntax=make
