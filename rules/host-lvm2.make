# -*-makefile-*-
#
# Copyright (C) 2019 by Bastian Krause <bst@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_LVM2) += host-lvm2

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_LVM2_CONF_TOOL	:= autoconf
# --disable-o_direct leads to compilation error ("device/dev-io.c:537:5: error: label 'opened' used but not defined")
HOST_LVM2_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--disable-static_link \
	--disable-thin_check_needs_check \
	--disable-cache_check_needs_check \
	--disable-readline \
	--disable-editline \
	--enable-realtime \
	--disable-ocf \
	--disable-cmirrord \
	--disable-debug \
	--disable-profiling \
	--disable-valgrind-pool \
	--enable-devmapper \
	--disable-lvmpolld \
	--disable-lvmlockd-sanlock \
	--disable-lvmlockd-dlm \
	--disable-lvmlockd-dlmcontrol \
	--disable-lvmlockd-idm \
	--disable-use-lvmlockd \
	--disable-use-lvmpolld \
	--disable-notify-dbus \
	--disable-systemd-journal \
	--disable-app-machineid \
	--disable-blkid_wiping \
	--disable-udev_sync \
	--disable-udev_rules \
	--disable-udev-rule-exec-detection \
	--disable-units-compat \
	--disable-ioctl \
	--enable-o_direct \
	--disable-cmdlib \
	--disable-dbus-service \
	--disable-pkgconfig \
	--disable-write_install \
	--disable-fsadm \
	--disable-lvmimportvdo \
	--disable-blkdeactivate \
	--disable-dmeventd \
	--disable-dmfilemapd \
	--disable-selinux \
	--enable-blkzeroout \
	--disable-nls

# vim: syntax=make
