# -*-makefile-*-
#
# Copyright (C) 2018 by Ladislav Michl <ladis@linux-mips.org>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_UPOWER) += upower

#
# Paths and names
#
UPOWER_VERSION	:= 0.99.11
UPOWER_MD5	:= abe6acb617f11f2e8dbd9846fcf86e24
UPOWER		:= upower-$(UPOWER_VERSION)
UPOWER_SUFFIX	:= tar.xz
UPOWER_URL	:= https://gitlab.freedesktop.org/upower/upower/uploads/93cfe7c8d66ed486001c4f3f55399b7a/$(UPOWER).$(UPOWER_SUFFIX)
UPOWER_SOURCE	:= $(SRCDIR)/$(UPOWER).$(UPOWER_SUFFIX)
UPOWER_DIR	:= $(BUILDDIR)/$(UPOWER)
UPOWER_LICENSE	:= GPL-2.0-or-later
UPOWER_LICENSE_FILES := file://COPYING;md5=0de8fbf1d97a140d1d93b9f14dcfbf08

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

UPOWER_CONF_ENV := \
	$(CROSS_ENV) \
	ac_cv_path_MSGFMT=: \
	ac_cv_path_GMSGFMT=: \
	ac_cv_path_XGETTEXT=:

#
# autoconf
#
UPOWER_CONF_TOOL := autoconf
UPOWER_CONF_OPT = \
	$(CROSS_AUTOCONF_USR) \
	--$(call ptx/endis, PTXCONF_UPOWER_INTROSPECTION)-introspection \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--enable-shared \
	--disable-static \
	--enable-fast-install \
	--disable-libtool-lock \
	--disable-deprecated \
	--disable-man-pages \
	--disable-gtk-doc \
	--disable-gtk-doc-html \
	--disable-gtk-doc-pdf \
	--disable-tests \
	--disable-nls \
	--disable-rpath \
	--with-udevrulesdir=/usr/lib/udev/rules.d \
	--with-historydir=/var/lib/upower \
	--with-systemdutildir=/usr/lib/systemd/scripts \
	--with-systemdsystemunitdir=/usr/lib/systemd/system \
	--with-backend=linux \
	--without-idevice

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/upower.targetinstall:
	@$(call targetinfo)

	@$(call install_init, upower)
	@$(call install_fixup, upower,PRIORITY,optional)
	@$(call install_fixup, upower,SECTION,base)
	@$(call install_fixup, upower,AUTHOR,"Ladislav Michl <ladis@linux-mips.org>")
	@$(call install_fixup, upower,DESCRIPTION, "upower")

	@$(call install_lib, upower, 0, 0, 0644, libupower-glib)

	@$(call install_copy, upower, 0, 0, 0755, -, /usr/bin/upower)
	@$(call install_copy, upower, 0, 0, 0755, -, /usr/libexec/upowerd)

	@$(call install_alternative, upower, 0, 0, 0644, \
		/etc/UPower/UPower.conf)
	@$(call install_alternative, upower, 0, 0, 0644, \
		/usr/share/dbus-1/system.d/org.freedesktop.UPower.conf)
	@$(call install_alternative, upower, 0, 0, 0644, \
		/usr/share/dbus-1/system-services/org.freedesktop.UPower.service)
	@$(call install_tree, upower, 0, 0, -, /usr/lib/udev/rules.d)

ifdef PTXCONF_UPOWER_SYSTEMD_UNIT
	@$(call install_alternative, upower, 0, 0, 0644, \
		/usr/lib/systemd/system/upower.service)
endif
ifdef PTXCONF_UPOWER_INTROSPECTION
	@$(call install_copy, upower, 0, 0, 0644, -, \
		/usr/lib/girepository-1.0/UPowerGlib-1.0.typelib)
endif

	@$(call install_copy, upower, 0, 0, 0755, /var/lib/upower)

	@$(call install_finish, upower)

	@$(call touch)

# vim: syntax=make
