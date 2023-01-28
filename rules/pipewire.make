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
PACKAGES-$(PTXCONF_PIPEWIRE) += pipewire

#
# Paths and names
#
PIPEWIRE_VERSION	:= 0.3.64
PIPEWIRE_MD5		:= e37730d11bd0c923e423f0a369826fd4
PIPEWIRE		:= pipewire-$(PIPEWIRE_VERSION)
PIPEWIRE_SUFFIX		:= tar.bz2
PIPEWIRE_URL		:= https://gitlab.freedesktop.org/pipewire/pipewire/-/archive/$(PIPEWIRE_VERSION)/$(PIPEWIRE).$(PIPEWIRE_SUFFIX)
PIPEWIRE_SOURCE		:= $(SRCDIR)/$(PIPEWIRE).$(PIPEWIRE_SUFFIX)
PIPEWIRE_DIR		:= $(BUILDDIR)/$(PIPEWIRE)
PIPEWIRE_LICENSE	:= MIT AND LGPL-2.1-or-later
PIPEWIRE_LICENSE_FILES := \
	file://LICENSE;md5=2158739e172e58dc9ab1bdd2d6ec9c72 \
	file://COPYING;md5=97be96ca4fab23e9657ffa590b931c1a

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PIPEWIRE_CONF_ENV := \
	PTXDIST_PKG_CONFIG_VAR_NO_SYSROOT=systemduserunitdir

#
# meson
#
PIPEWIRE_CONF_TOOL	:= meson
PIPEWIRE_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Dalsa=enabled \
	-Daudioconvert=enabled \
	-Daudiomixer=enabled \
	-Daudiotestsrc=enabled \
	-Davahi=disabled \
	-Davb=disabled \
	-Dbluez5=disabled \
	-Dbluez5-backend-hfp-native=disabled \
	-Dbluez5-backend-hsp-native=disabled \
	-Dbluez5-backend-hsphfpd=disabled \
	-Dbluez5-backend-native-mm=disabled \
	-Dbluez5-backend-ofono=disabled \
	-Dbluez5-codec-aac=disabled \
	-Dbluez5-codec-aptx=disabled \
	-Dbluez5-codec-lc3=disabled \
	-Dbluez5-codec-lc3plus=disabled \
	-Dbluez5-codec-ldac=disabled \
	-Dbluez5-codec-opus=disabled \
	-Dcontrol=enabled \
	-Ddbus=enabled \
	-Ddocdir= \
	-Ddocs=disabled \
	-Decho-cancel-webrtc=disabled \
	-Devl=disabled \
	-Dexamples=enabled \
	-Dffmpeg=disabled \
	-Dflatpak=disabled \
	-Dgsettings=disabled \
	-Dgstreamer=$(call ptx/endis,PTXCONF_PIPEWIRE_GSTREAMER)d \
	-Dgstreamer-device-provider=$(call ptx/endis,PTXCONF_PIPEWIRE_GSTREAMER)d \
	-Dinstalled_tests=disabled \
	-Djack=disabled \
	-Djack-devel=false \
	-Dlegacy-rtkit=false \
	-Dlibcamera=$(call ptx/endis,PTXCONF_PIPEWIRE_LIBCAMERA)d \
	-Dlibcanberra=disabled \
	-Dlibjack-path= \
	-Dlibpulse=disabled \
	-Dlibusb=disabled \
	-Dlibv4l2-path= \
	-Dlv2=disabled \
	-Dman=disabled \
	-Dpipewire-alsa=enabled \
	-Dpipewire-jack=disabled \
	-Dpipewire-v4l2=disabled \
	-Dpw-cat=enabled \
	-Draop=$(call ptx/endis,PTXCONF_PIPEWIRE_RAOP)d \
	-Dreadline=$(call ptx/endis,PIPEWIRE_PW_CTL)d \
	-Droc=disabled \
	-Dsdl2=disabled \
	-Dsession-managers= \
	-Dsndfile=enabled \
	-Dspa-plugins=enabled \
	-Dsupport=enabled \
	-Dsystemd=$(call ptx/endis,PTXCONF_PIPEWIRE_SYSTEMD)d \
	-Dsystemd-system-service=$(call ptx/endis,PTXCONF_PIPEWIRE_SYSTEMD_UNIT)d \
	-Dsystemd-system-unit-dir= \
	-Dsystemd-user-service=$(call ptx/endis,PTXCONF_PIPEWIRE_SYSTEMD_UNIT_USER)d \
	-Dsystemd-user-unit-dir= \
	-Dtest=disabled \
	-Dtests=disabled \
	-Dudev=enabled \
	-Dudevrulesdir=/usr/lib/udev/rules.d \
	-Dv4l2=enabled \
	-Dvideoconvert=disabled \
	-Dvideotestsrc=enabled \
	-Dvolume=enabled \
	-Dvulkan=disabled \
	-Dx11=disabled \
	-Dx11-xfixes=disabled

PIPEWIRE_CPPFLAGS = -isystem $(KERNEL_HEADERS_INCLUDE_DIR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

PIPEWIRE_MODULES-y := \
	access \
	adapter \
	client-device \
	client-node \
	echo-cancel \
	fallback-sink \
	filter-chain \
	link-factory \
	loopback \
	metadata \
	pipe-tunnel \
	portal \
	profiler \
	protocol-native \
	protocol-pulse \
	protocol-simple \
	rt \
	session-manager \
	rtp-source \
	rtp-sink \
	spa-device \
	spa-device-factory \
	spa-node \
	spa-node-factory

PIPEWIRE_MODULES-$(PTXCONF_PIPEWIRE_RAOP)	+= raop-sink

PIPEWIRE_SPA_MODULES := \
	alsa/libspa-alsa \
	audioconvert/libspa-audioconvert \
	audiomixer/libspa-audiomixer \
	audiotestsrc/libspa-audiotestsrc \
	control/libspa-control \
	$(call ptx/ifdef,PTXCONF_PIPEWIRE_LIBCAMERA,libcamera/libspa-libcamera) \
	support/libspa-dbus \
	$(call ptx/ifdef,PTXCONF_PIPEWIRE_SYSTEMD,support/libspa-journal) \
	support/libspa-support \
	v4l2/libspa-v4l2 \
	videotestsrc/libspa-videotestsrc \
	volume/libspa-volume

$(STATEDIR)/pipewire.targetinstall:
	@$(call targetinfo)

	@$(call install_init, pipewire)
	@$(call install_fixup, pipewire,PRIORITY,optional)
	@$(call install_fixup, pipewire,SECTION,base)
	@$(call install_fixup, pipewire,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, pipewire,DESCRIPTION,missing)

	@$(call install_lib, pipewire, 0, 0, 644, libpipewire-0.3)

	@$(call install_copy, pipewire, 0, 0, 755, -, /usr/bin/pipewire)
ifdef PTXCONF_PIPEWIRE_PULSEAUDIO
	@$(call install_copy, pipewire, 0, 0, 755, -, /usr/bin/pipewire-pulse)
endif
	@$(call install_copy, pipewire, 0, 0, 755, -, /usr/bin/pw-cat)
ifdef PTXCONF_PIPEWIRE_PW_CTL
	@$(call install_copy, pipewire, 0, 0, 755, -, /usr/bin/pw-cli)
endif
	@$(call install_copy, pipewire, 0, 0, 755, -, /usr/bin/pw-dot)
	@$(call install_copy, pipewire, 0, 0, 755, -, /usr/bin/pw-dump)
	@$(call install_copy, pipewire, 0, 0, 755, -, /usr/bin/pw-link)
	@$(call install_copy, pipewire, 0, 0, 755, -, /usr/bin/pw-loopback)
	@$(call install_copy, pipewire, 0, 0, 755, -, /usr/bin/pw-metadata)
	@$(call install_copy, pipewire, 0, 0, 755, -, /usr/bin/pw-mididump)
	@$(call install_copy, pipewire, 0, 0, 755, -, /usr/bin/pw-mon)
	@$(call install_copy, pipewire, 0, 0, 755, -, /usr/bin/pw-profiler)
	@$(call install_copy, pipewire, 0, 0, 755, -, /usr/bin/pw-reserve)
ifdef PTXCONF_PIPEWIRE_PW_TOP
	@$(call install_copy, pipewire, 0, 0, 755, -, /usr/bin/pw-top)
endif
	@$(call install_copy, pipewire, 0, 0, 755, -, /usr/bin/spa-acp-tool)
	@$(call install_copy, pipewire, 0, 0, 755, -, /usr/bin/spa-inspect)
	@$(call install_copy, pipewire, 0, 0, 755, -, /usr/bin/spa-json-dump)
	@$(call install_copy, pipewire, 0, 0, 755, -, /usr/bin/spa-monitor)
	@$(call install_copy, pipewire, 0, 0, 755, -, /usr/bin/spa-resample)

	@$(call install_link, pipewire, pw-cat, /usr/bin/pw-dsdplay)
	@$(call install_link, pipewire, pw-cat, /usr/bin/pw-midiplay)
	@$(call install_link, pipewire, pw-cat, /usr/bin/pw-midirecord)
	@$(call install_link, pipewire, pw-cat, /usr/bin/pw-play)
	@$(call install_link, pipewire, pw-cat, /usr/bin/pw-record)

	@$(foreach module, $(PIPEWIRE_MODULES-y), \
		$(call install_lib, pipewire, 0, 0, 644, \
			pipewire-0.3/libpipewire-module-$(module))$(ptx/nl))

	@$(foreach module, $(PIPEWIRE_SPA_MODULES), \
		$(call install_lib, pipewire, 0, 0, 644, \
			spa-0.2/$(module))$(ptx/nl))

	@$(call install_alternative, pipewire, 0, 0, 644, /usr/share/pipewire/client.conf)
	@$(call install_alternative, pipewire, 0, 0, 644, /usr/share/pipewire/client-rt.conf)
	@$(call install_alternative, pipewire, 0, 0, 644, /usr/share/pipewire/filter-chain.conf)
	@$(call install_alternative, pipewire, 0, 0, 644, /usr/share/pipewire/filter-chain/demonic.conf)
	@$(call install_alternative, pipewire, 0, 0, 644, /usr/share/pipewire/filter-chain/sink-dolby-surround.conf)
	@$(call install_alternative, pipewire, 0, 0, 644, /usr/share/pipewire/filter-chain/sink-eq6.conf)
	@$(call install_alternative, pipewire, 0, 0, 644, /usr/share/pipewire/filter-chain/sink-make-LFE.conf)
	@$(call install_alternative, pipewire, 0, 0, 644, /usr/share/pipewire/filter-chain/sink-matrix-spatialiser.conf)
	@$(call install_alternative, pipewire, 0, 0, 644, /usr/share/pipewire/filter-chain/sink-mix-FL-FR.conf)
	@$(call install_alternative, pipewire, 0, 0, 644, /usr/share/pipewire/filter-chain/sink-virtual-surround-5.1-kemar.conf)
	@$(call install_alternative, pipewire, 0, 0, 644, /usr/share/pipewire/filter-chain/sink-virtual-surround-7.1-hesuvi.conf)
	@$(call install_alternative, pipewire, 0, 0, 644, /usr/share/pipewire/filter-chain/source-duplicate-FL.conf)
	@$(call install_alternative, pipewire, 0, 0, 644, /usr/share/pipewire/filter-chain/source-rnnoise.conf)
	@$(call install_alternative, pipewire, 0, 0, 644, /usr/share/pipewire/pipewire.conf)
	@$(call install_alternative, pipewire, 0, 0, 644, /usr/share/pipewire/minimal.conf)

	@$(call install_tree, pipewire, 0, 0, -, /usr/share/alsa-card-profile)
	@$(call install_alternative, pipewire, 0, 0, 644, \
		/usr/lib/udev/rules.d/90-pipewire-alsa.rules)
ifdef PTXCONF_PIPEWIRE_PULSEAUDIO
	@$(call install_alternative, pipewire, 0, 0, 644, /usr/share/pipewire/pipewire-pulse.conf)
endif

ifdef PTXCONF_PIPEWIRE_GSTREAMER
	@$(call install_lib, pipewire, 0, 0, 644, gstreamer-1.0/libgstpipewire)
endif
ifdef PTXCONF_PIPEWIRE_SYSTEMD_UNIT_USER
	@$(call install_alternative, pipewire, 0, 0, 0644, \
		/usr/lib/systemd/user/pipewire.service)
	@$(call install_alternative, pipewire, 0, 0, 0644, \
		/usr/lib/systemd/user/pipewire.socket)
	@$(call install_link, pipewire, ../pipewire.socket, \
		/usr/lib/systemd/user/sockets.target.wants/pipewire.socket)
ifdef PTXCONF_PIPEWIRE_PULSEAUDIO
	@$(call install_alternative, pipewire, 0, 0, 0644, \
		/usr/lib/systemd/user/pipewire-pulse.service)
	@$(call install_alternative, pipewire, 0, 0, 0644, \
		/usr/lib/systemd/user/pipewire-pulse.socket)
	@$(call install_link, pipewire, ../pipewire-pulse.socket, \
		/usr/lib/systemd/user/sockets.target.wants/pipewire-pulse.socket)
endif
endif
ifdef PTXCONF_PIPEWIRE_SYSTEMD_UNIT
	@$(call install_alternative, pipewire, 0, 0, 0644, \
		/usr/lib/systemd/system/pipewire.service)
	@$(call install_alternative, pipewire, 0, 0, 0644, \
		/usr/lib/systemd/system/pipewire.socket)
	@$(call install_link, pipewire, ../pipewire.socket, \
		/usr/lib/systemd/system/sockets.target.wants/pipewire.socket)
endif

	@$(call install_finish, pipewire)

	@$(call touch)

# vim: syntax=make
