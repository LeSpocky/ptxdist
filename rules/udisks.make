# -*-makefile-*-
#
# Copyright (C) 2024 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_UDISKS) += udisks

#
# Paths and names
#
UDISKS_VERSION		:= 2.10.1
UDISKS_MD5		:= 613af9bfea52cde74d2ac34d96de544d
UDISKS			:= udisks-$(UDISKS_VERSION)
UDISKS_SUFFIX		:= tar.bz2
UDISKS_URL		:= https://github.com/storaged-project/udisks/releases/download/$(UDISKS)/$(UDISKS).$(UDISKS_SUFFIX)
UDISKS_SOURCE		:= $(SRCDIR)/$(UDISKS).$(UDISKS_SUFFIX)
UDISKS_DIR		:= $(BUILDDIR)/$(UDISKS)
UDISKS_LICENSE		:= GPL-2.0-or-later
UDISKS_LICENSE_FILES	:= \
	file://COPYING;md5=dd79f6dbbffdbc8e86b086a8f0c0ef43

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
UDISKS_CONF_TOOL	:= autoconf
UDISKS_CONF_OPT	:=  \
	$(CROSS_AUTOCONF_USR) \
	--disable-debug \
	--disable-gtk-doc \
	--disable-gtk-doc-html \
	--disable-gtk-doc-pdf \
	--disable-man \
	--enable-daemon \
	--disable-introspection \
	--disable-fhs-media \
	--disable-acl \
	--disable-lvm2 \
	--disable-iscsi \
	--disable-btrfs \
	--disable-lsm \
	--disable-nls \
	--disable-rpath \
	--with-udevdir=/usr/lib/udev \
	--with-systemdsystemunitdir=/usr/lib/systemd/system \
	--with-tmpfilesdir=/usr/lib/tmpfiles.d \
	--with-modloaddir=/usr/lib/modules-load.d \
	--with-modprobedir=/usr/lib/modprobe.d

UDISKS_MAKE_ENV	:= \
	GETTEXTDATADIR=$(PTXDIST_SYSROOT_TARGET)/usr/share/gettext

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/udisks.targetinstall:
	@$(call targetinfo)

	@$(call install_init, udisks)
	@$(call install_fixup, udisks,PRIORITY,optional)
	@$(call install_fixup, udisks,SECTION,base)
	@$(call install_fixup, udisks,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, udisks,DESCRIPTION,missing)

	@$(call install_lib, udisks, 0, 0, 0644, libudisks2)

	@$(call install_copy, udisks, 0, 0, 0755, -, \
		/usr/bin/udisksctl)
	@$(call install_copy, udisks, 0, 0, 0755, -, \
		/usr/sbin/umount.udisks2)
	@$(call install_copy, udisks, 0, 0, 0755, -, \
		/usr/libexec/udisks2/udisksd)

ifdef PTXCONF_UDISKS_SYSTEMD_UNIT
	@$(call install_copy, udisks, 0, 0, 0644, -, \
		/usr/lib/systemd/system/udisks2.service)
endif

	@$(call install_alternative, udisks, 0, 0, 0644, \
		/etc/udisks2/udisks2.conf)

	@$(call install_alternative, udisks, 0, 0, 0644, \
		/usr/lib/tmpfiles.d/udisks2.conf)

	@$(call install_copy, udisks, 0, 0, 0644, -, \
		/usr/lib/udev/rules.d/80-udisks2.rules)

	@$(call install_copy, udisks, 0, 0, 0644, -, \
		/usr/share/dbus-1/system.d/org.freedesktop.UDisks2.conf)
	@$(call install_copy, udisks, 0, 0, 0644, -, \
		/usr/share/dbus-1/system-services/org.freedesktop.UDisks2.service)

	@$(call install_alternative, udisks, 0, 0, 0644, \
		/usr/share/polkit-1/actions/org.freedesktop.UDisks2.policy)

	@$(call install_finish, udisks)

	@$(call touch)

# vim: syntax=make
