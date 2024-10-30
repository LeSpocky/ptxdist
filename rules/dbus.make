# -*-makefile-*-
#
# Copyright (C) 2006 by Roland Hostettler
#               2008, 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#               2010 Tim Sander <tim.sander@hbm.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_DBUS) += dbus

#
# Paths and names
#
DBUS_VERSION		:= 1.15.12
DBUS_MD5		:= cc1a1e2ae4ad166ed3d3da36172bbb8a
DBUS			:= dbus-$(DBUS_VERSION)
DBUS_SUFFIX		:= tar.xz
DBUS_URL		:= https://dbus.freedesktop.org/releases/dbus/$(DBUS).$(DBUS_SUFFIX)
DBUS_SOURCE		:= $(SRCDIR)/$(DBUS).$(DBUS_SUFFIX)
DBUS_DIR		:= $(BUILDDIR)/$(DBUS)
DBUS_LICENSE		:= (AFL-2.1 OR GPL-2.0-or-later) AND MIT
DBUS_LICENSE_FILES	:= \
	file://COPYING;md5=eb0ffc69a965797a3d6686baa153ef05 \
	file://LICENSES/AFL-2.1.txt;md5=f3ad2f482ec639b440413665cfb9e714 \
	file://LICENSES/GPL-2.0-or-later.txt;md5=3d26203303a722dedc6bf909d95ba815 \
	file://LICENSES/MIT.txt;md5=7dda4e90ded66ab88b86f76169f28663

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------


DBUS_CONF_ENV	:= \
	$(CROSS_ENV) \
	ac_cv_lib_ICE_IceConnectionNumber=no

#
# meson
#
DBUS_CONF_TOOL	:= meson
DBUS_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Dapparmor=disabled \
	-Dasserts=false \
	-Dchecks=false \
	-Dcontainers=false \
	-Ddbus_user=messagebus \
	-Ddoxygen_docs=disabled \
	-Dducktype_docs=disabled \
	-Dembedded_tests=false \
	-Depoll=enabled \
	-Dinotify=enabled \
	-Dinstalled_tests=false \
	-Dkqueue=disabled \
	-Dlaunchd=disabled \
	-Dlibaudit=disabled \
	-Dmessage_bus=true \
	-Dmodular_tests=disabled \
	-Dqt_help=disabled \
	-Drelocation=disabled \
	-Dselinux=$(call ptx/endis, PTXCONF_DBUS_SELINUX)d \
	-Dstats=false \
	-Dsystemd=$(call ptx/endis, PTXCONF_DBUS_SYSTEMD)d \
	-Dsystemd_system_unitdir=/usr/lib/systemd/system \
	-Dsystemd_user_unitdir=/usr/lib/systemd/user \
	-Dtools=true \
	-Dtraditional_activation=true \
	-Duser_session=$(call ptx/truefalse, PTXCONF_DBUS_SYSTEMD) \
	-Dvalgrind=disabled \
	-Dverbose_mode=false \
	-Dx11_autolaunch=$(call ptx/endis, PTXCONF_DBUS_X)d \
	-Dxml_docs=disabled

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/dbus.targetinstall:
	@$(call targetinfo)

	@$(call install_init, dbus)
	@$(call install_fixup, dbus,PRIORITY,optional)
	@$(call install_fixup, dbus,SECTION,base)
	@$(call install_fixup, dbus,AUTHOR,"Roland Hostettler <r.hostettler@gmx.ch>")
	@$(call install_fixup, dbus,DESCRIPTION,missing)

	@$(call install_copy, dbus, 0, 0, 0755, -, \
		/usr/bin/dbus-daemon)
	@$(call install_copy, dbus, 0, 0, 0755, -, \
		/usr/bin/dbus-cleanup-sockets)
	@$(call install_copy, dbus, 0, 0, 0755, -, \
		/usr/bin/dbus-launch)
	@$(call install_copy, dbus, 0, 0, 0755, -, \
		/usr/bin/dbus-monitor)
	@$(call install_copy, dbus, 0, 0, 0755, -, \
		/usr/bin/dbus-run-session)
	@$(call install_copy, dbus, 0, 0, 0755, -, \
		/usr/bin/dbus-send)
	@$(call install_copy, dbus, 0, 0, 0755, -, \
		/usr/bin/dbus-uuidgen)
	@$(call install_copy, dbus, 0, 104, 4754, -, \
		/usr/libexec/dbus-daemon-launch-helper)

	@$(call install_lib, dbus, 0, 0, 0644, libdbus-1)

#	#
#	# install config files
#	#
	@$(call install_alternative, dbus, 0, 0, 0644, /usr/share/dbus-1/system.conf)
	@$(call install_alternative, dbus, 0, 0, 0644, /usr/share/dbus-1/session.conf)

#	#
#	# busybox init: start script
#	#

ifdef PTXCONF_DBUS_STARTSCRIPT
	@$(call install_alternative, dbus, 0, 0, 0755, /etc/init.d/dbus)

ifneq ($(call remove_quotes,$(PTXCONF_DBUS_BBINIT_LINK)),)
	@$(call install_link, dbus, \
		../init.d/dbus, \
		/etc/rc.d/$(PTXCONF_DBUS_BBINIT_LINK))
endif
endif
ifdef PTXCONF_DBUS_SYSTEMD_UNIT
	@$(call install_copy, dbus, 0, 0, 0644, -, \
		/usr/lib/systemd/system/dbus.socket)
	@$(call install_link, dbus, ../dbus.socket, \
		/usr/lib/systemd/system/sockets.target.wants/dbus.socket)
	@$(call install_link, dbus, ../dbus.socket, \
		/usr/lib/systemd/system/dbus.target.wants/dbus.socket)

	@$(call install_copy, dbus, 0, 0, 0644, -, \
		/usr/lib/systemd/system/dbus.service)
	@$(call install_link, dbus, ../dbus.service, \
		/usr/lib/systemd/system/multi-user.target.wants/dbus.service)
endif
ifdef PTXCONF_DBUS_SYSTEMD_USER_UNIT
	@$(call install_copy, dbus, 0, 0, 0644, -, \
		/usr/lib/systemd/user/dbus.socket)
	@$(call install_link, dbus, ../dbus.socket, \
		/usr/lib/systemd/user/sockets.target.wants/dbus.socket)
	@$(call install_copy, dbus, 0, 0, 0644, -, \
		/usr/lib/systemd/user/dbus.service)
endif

	@$(call install_finish, dbus)

	@$(call touch)

# vim: syntax=make
