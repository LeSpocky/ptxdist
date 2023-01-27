# -*-makefile-*-
#
# Copyright (C) 2021 by Philipp Zabel <p.zabel@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MEDIA_SESSION) += media-session

#
# Paths and names
#
MEDIA_SESSION_VERSION	:= 0.4.2
MEDIA_SESSION_MD5	:= d376f33ece8f8b074f2abeafc173b078
MEDIA_SESSION		:= media-session-$(MEDIA_SESSION_VERSION)
MEDIA_SESSION_SUFFIX	:= tar.bz2
MEDIA_SESSION_URL	:= \
	https://gitlab.freedesktop.org/pipewire/media-session/-/archive/$(MEDIA_SESSION_VERSION)/$(MEDIA_SESSION).$(MEDIA_SESSION_SUFFIX)
MEDIA_SESSION_SOURCE	:= $(SRCDIR)/$(MEDIA_SESSION).$(MEDIA_SESSION_SUFFIX)
MEDIA_SESSION_DIR	:= $(BUILDDIR)/$(MEDIA_SESSION)
MEDIA_SESSION_LICENSE	:= MIT AND LGPL-2.1-or-later AND GPL-2.0-only
MEDIA_SESSION_LICENSE_FILES := \
	file://LICENSE;md5=647cfa0f759d97b208bfb5c1eb912071 \
	file://COPYING;md5=97be96ca4fab23e9657ffa590b931c1a

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

MEDIA_SESSION_CONF_ENV := \
	PTXDIST_PKG_CONFIG_VAR_NO_SYSROOT=systemdsystemunitdir

#
# meson
#
MEDIA_SESSION_CONF_TOOL	:= meson
MEDIA_SESSION_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Ddocdir= \
	-Ddocs=disabled \
	-Dinstalled_tests=disabled \
	-Dsystemd=$(call ptx/endis,PTXCONF_MEDIA_SESSION_SYSTEMD)d \
	-Dsystemd-system-service=$(call ptx/endis,PTXCONF_MEDIA_SESSION_SYSTEMD_UNIT)d \
	-Dsystemd-user-service=$(call ptx/endis,PTXCONF_MEDIA_SESSION_SYSTEMD_UNIT_USER)d \
	-Dsystemd-user-unit-dir= \
	-Dtests=disabled \
	-Dwith-module-sets=

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/media-session.targetinstall:
	@$(call targetinfo)

	@$(call install_init, media-session)
	@$(call install_fixup, media-session,PRIORITY,optional)
	@$(call install_fixup, media-session,SECTION,base)
	@$(call install_fixup, media-session,AUTHOR,"Philipp Zabel <p.zabel@pengutronix.de>")
	@$(call install_fixup, media-session,DESCRIPTION,missing)

	@$(call install_copy, media-session, 0, 0, 755, -, /usr/bin/pipewire-media-session)

ifdef PTXCONF_MEDIA_SESSION_SYSTEMD_UNIT
	@$(call install_alternative, media-session, 0, 0, 0644, \
		/usr/lib/systemd/system/pipewire-media-session.service)
	@$(call install_link, media-session, ../pipewire-media-session.service, \
		/usr/lib/systemd/system/pipewire.service.wants/pipewire-media-session.service)
endif
ifdef PTXCONF_MEDIA_SESSION_SYSTEMD_UNIT_USER
	@$(call install_alternative, media-session, 0, 0, 0644, \
		/usr/lib/systemd/user/pipewire-media-session.service)
	@$(call install_link, media-session, ../pipewire-media-session.service, \
		/usr/lib/systemd/user/pipewire.service.wants/pipewire-media-session.service)
endif

	@$(call install_alternative, media-session, 0, 0, 0644, \
		/usr/share/pipewire/media-session.d/alsa-monitor.conf)
	@$(call install_alternative, media-session, 0, 0, 0644, \
		/usr/share/pipewire/media-session.d/bluez-monitor.conf)
	@$(call install_alternative, media-session, 0, 0, 0644, \
		/usr/share/pipewire/media-session.d/media-session.conf)
	@$(call install_alternative, media-session, 0, 0, 0644, \
		/usr/share/pipewire/media-session.d/v4l2-monitor.conf)

	@$(call install_finish, media-session)

	@$(call touch)

# vim: syntax=make
