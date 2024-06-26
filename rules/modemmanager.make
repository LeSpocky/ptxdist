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
PACKAGES-$(PTXCONF_MODEMMANAGER) += modemmanager

#
# Paths and names
#
MODEMMANAGER_VERSION	:= 1.22.0
MODEMMANAGER_MD5	:= e967a452eb6f505a645df8c0582a17b7
MODEMMANAGER		:= ModemManager-$(MODEMMANAGER_VERSION)
MODEMMANAGER_SUFFIX	:= tar.bz2
MODEMMANAGER_URL	:= https://gitlab.freedesktop.org/mobile-broadband/ModemManager/-/archive/$(MODEMMANAGER_VERSION)/$(MODEMMANAGER).$(MODEMMANAGER_SUFFIX)
MODEMMANAGER_SOURCE	:= $(SRCDIR)/$(MODEMMANAGER).$(MODEMMANAGER_SUFFIX)
MODEMMANAGER_DIR	:= $(BUILDDIR)/$(MODEMMANAGER)
MODEMMANAGER_LICENSE	:= GPL-2.0-or-later AND LGPL-2.1-or-later
MODEMMANAGER_LICENSE_FILES := \
	file://COPYING;md5=b234ee4d69f5fce4486a80fdaf4a4263 \
	file://COPYING.LIB;md5=4fbd65380cdd255951079008b364516c

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# meson
#
MODEMMANAGER_CONF_TOOL	:= meson
MODEMMANAGER_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Dudev=true \
	-Dudevdir=/usr/lib/udev \
	-Dtests=false \
	-Ddbus_policy_dir=/usr/share/dbus-1/system.d \
	-Dsystemdsystemunitdir=/usr/lib/systemd/system \
	-Dsystemd_suspend_resume=$(call ptx/truefalse, PTXCONF_INITMETHOD_SYSTEMD) \
	-Dpowerd_suspend_resume=false \
	-Dsystemd_journal=$(call ptx/truefalse, PTXCONF_INITMETHOD_SYSTEMD) \
	-Dpolkit=no \
	-Dat_command_via_dbus=$(call ptx/truefalse, PTXCONF_MODEMMANAGER_ALLOW_DBUS_AT_CMDS) \
	-Dmbim=true \
	-Dqmi=true \
	-Dqrtr=false \
	-Dintrospection=false \
	-Dvapi=false \
	-Dgtk_doc=false \
	-Dman=false \
	-Dbash_completion=false \
	-Dexamples=false

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/modemmanager.targetinstall:
	@$(call targetinfo)

	@$(call install_init, modemmanager)
	@$(call install_fixup, modemmanager,PRIORITY,optional)
	@$(call install_fixup, modemmanager,SECTION,base)
	@$(call install_fixup, modemmanager,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, modemmanager,DESCRIPTION,missing)

	@$(call install_copy, modemmanager, 0, 0, 0755, -, \
		/usr/sbin/ModemManager)
	@$(call install_copy, modemmanager, 0, 0, 0755, -, /usr/bin/mmcli)

	@$(call install_lib, modemmanager, 0, 0, 0644, libmm-glib)
	@$(call install_glob, modemmanager, 0, 0, -, /usr/lib/ModemManager/, *.so)

	@$(call install_alternative, modemmanager, 0, 0, 0644, \
		/usr/share/dbus-1/system.d/org.freedesktop.ModemManager1.conf)
	@$(call install_alternative, modemmanager, 0, 0, 0644, \
		/usr/share/dbus-1/system-services/org.freedesktop.ModemManager1.service)

	@$(call install_tree, modemmanager, 0, 0, -, /usr/lib/udev/rules.d/)

ifdef PTXCONF_MODEMMANAGER_SYSTEMD_UNIT
	@$(call install_alternative, modemmanager, 0, 0, 0644, \
		/usr/lib/systemd/system/ModemManager.service)
	@$(call install_link, modemmanager, ModemManager.service, \
		/usr/lib/systemd/system/dbus-org.freedesktop.ModemManager1.service)
	@$(call install_link, modemmanager, ../ModemManager.service, \
		/usr/lib/systemd/system/multi-user.target.wants/ModemManager.service)
endif

	@$(call install_finish, modemmanager)

	@$(call touch)

# vim: syntax=make
