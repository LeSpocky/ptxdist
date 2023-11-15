# -*-makefile-*-
#
# Copyright (C) 2010 by Bart vdr. Meulen <bartvdrmeulen@gmail.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LVM2) += lvm2

#
# Paths and names
#
LVM2_VERSION	:= 2.03.22
LVM2_MD5	:= a97cf533222a5760225dbd26c3982ca6
LVM2		:= LVM2.$(LVM2_VERSION)
LVM2_SUFFIX	:= tgz
LVM2_URL	:= \
	https://sourceware.org/pub/lvm2/$(LVM2).$(LVM2_SUFFIX) \
	https://sourceware.org/pub/lvm2/old/$(LVM2).$(LVM2_SUFFIX)
LVM2_SOURCE	:= $(SRCDIR)/$(LVM2).$(LVM2_SUFFIX)
LVM2_DIR	:= $(BUILDDIR)/$(LVM2)
LVM2_LICENSE	:= GPL-2.0-only, LGPL-2.1-only
LVM2_LICENSE_FILES := \
	file://COPYING;md5=12713b4d9386533feeb07d6e4831765a \
	file://COPYING.LIB;md5=fbc093901857fcd118f065f900982c24


# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LVM2_CONF_TOOL	:= autoconf
LVM2_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--disable-static_link \
	--disable-thin_check_needs_check \
	--disable-cache_check_needs_check \
	--enable-readline \
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
	--$(call ptx/endis, PTXCONF_LVM2_SYSTEMD)-systemd-journal \
	--$(call ptx/endis, PTXCONF_LVM2_SYSTEMD)-app-machineid \
	--disable-blkid_wiping \
	--$(call ptx/endis, PTXCONF_LVM2_SYSTEMD)-udev_sync \
	--$(call ptx/endis, PTXCONF_LVM2_SYSTEMD)-udev_rules \
	--disable-udev-rule-exec-detection \
	--disable-units-compat \
	--enable-ioctl \
	--enable-o_direct \
	--enable-cmdlib \
	--disable-dbus-service \
	--enable-pkgconfig \
	--enable-write_install \
	--enable-fsadm \
	--disable-lvmimportvdo \
	--enable-blkdeactivate \
	--enable-dmeventd \
	--disable-dmfilemapd \
	--disable-selinux \
	--enable-blkzeroout \
	--disable-nls \
	--with-device-uid=$(PTXCONF_LVM2_DEVICE_UID) \
	--with-device-gid=$(PTXCONF_LVM2_DEVICE_GID) \
	--with-device-mode=$(PTXCONF_LVM2_DEVICE_MODE)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/lvm2.targetinstall:
	@$(call targetinfo)

	@$(call install_init, lvm2)
	@$(call install_fixup, lvm2,PRIORITY,optional)
	@$(call install_fixup, lvm2,SECTION,base)
	@$(call install_fixup, lvm2,AUTHOR,"Bart vdr. Meulen <bartvdrmeulen@gmail.com>")
	@$(call install_fixup, lvm2,DESCRIPTION,missing)

	@$(call install_copy, lvm2, 0, 0, 0755, -, /usr/sbin/dmsetup)

ifdef PTXCONF_LVM2_LVM_TOOLS
	@$(call install_copy, lvm2, 0, 0, 0755, -, /usr/sbin/fsadm)
	@$(call install_copy, lvm2, 0, 0, 0755, -, /usr/sbin/lvmdump)

	@$(call install_copy, lvm2, 0, 0, 0755, -, /usr/sbin/lvm)
	@$(call install_link, lvm2, lvm, /usr/sbin/lvchange)
	@$(call install_link, lvm2, lvm, /usr/sbin/lvconvert)
	@$(call install_link, lvm2, lvm, /usr/sbin/lvcreate)
	@$(call install_link, lvm2, lvm, /usr/sbin/lvdisplay)
	@$(call install_link, lvm2, lvm, /usr/sbin/lvextend)
	@$(call install_link, lvm2, lvm, /usr/sbin/lvmchange)
	@$(call install_link, lvm2, lvm, /usr/sbin/lvmdiskscan)
	@$(call install_link, lvm2, lvm, /usr/sbin/lvmsadc)
	@$(call install_link, lvm2, lvm, /usr/sbin/lvmsar)
	@$(call install_link, lvm2, lvm, /usr/sbin/lvreduce)
	@$(call install_link, lvm2, lvm, /usr/sbin/lvremove)
	@$(call install_link, lvm2, lvm, /usr/sbin/lvrename)
	@$(call install_link, lvm2, lvm, /usr/sbin/lvresize)
	@$(call install_link, lvm2, lvm, /usr/sbin/lvs)
	@$(call install_link, lvm2, lvm, /usr/sbin/lvscan)
	@$(call install_link, lvm2, lvm, /usr/sbin/pvchange)
	@$(call install_link, lvm2, lvm, /usr/sbin/pvck)
	@$(call install_link, lvm2, lvm, /usr/sbin/pvcreate)
	@$(call install_link, lvm2, lvm, /usr/sbin/pvdisplay)
	@$(call install_link, lvm2, lvm, /usr/sbin/pvmove)
	@$(call install_link, lvm2, lvm, /usr/sbin/pvremove)
	@$(call install_link, lvm2, lvm, /usr/sbin/pvresize)
	@$(call install_link, lvm2, lvm, /usr/sbin/pvs)
	@$(call install_link, lvm2, lvm, /usr/sbin/pvscan)
	@$(call install_link, lvm2, lvm, /usr/sbin/vgcfgbackup)
	@$(call install_link, lvm2, lvm, /usr/sbin/vgcfgrestore)
	@$(call install_link, lvm2, lvm, /usr/sbin/vgchange)
	@$(call install_link, lvm2, lvm, /usr/sbin/vgck)
	@$(call install_link, lvm2, lvm, /usr/sbin/vgconvert)
	@$(call install_link, lvm2, lvm, /usr/sbin/vgcreate)
	@$(call install_link, lvm2, lvm, /usr/sbin/vgdisplay)
	@$(call install_link, lvm2, lvm, /usr/sbin/vgexport)
	@$(call install_link, lvm2, lvm, /usr/sbin/vgextend)
	@$(call install_link, lvm2, lvm, /usr/sbin/vgimport)
	@$(call install_link, lvm2, lvm, /usr/sbin/vgimportclone)
	@$(call install_link, lvm2, lvm, /usr/sbin/vgmerge)
	@$(call install_link, lvm2, lvm, /usr/sbin/vgmknodes)
	@$(call install_link, lvm2, lvm, /usr/sbin/vgreduce)
	@$(call install_link, lvm2, lvm, /usr/sbin/vgremove)
	@$(call install_link, lvm2, lvm, /usr/sbin/vgrename)
	@$(call install_link, lvm2, lvm, /usr/sbin/vgs)
	@$(call install_link, lvm2, lvm, /usr/sbin/vgscan)
	@$(call install_link, lvm2, lvm, /usr/sbin/vgsplit)
endif

	@$(call install_alternative, lvm2, 0, 0, 0644, /etc/lvm/lvm.conf)

	@$(call install_lib, lvm2, 0, 0, 0644, libdevmapper)
	@$(call install_lib, lvm2, 0, 0, 0644, libdevmapper-event)

ifdef PTXCONF_LVM2_STARTSCRIPT
	@$(call install_alternative, lvm2, 0, 0, 0755, /etc/init.d/lvm2)

ifneq ($(call remove_quotes,$(PTXCONF_LVM2_BBINIT_LINK)),)
	@$(call install_link, lvm2, \
		../init.d/lvm2, \
		/etc/rc.d/$(PTXCONF_LVM2_BBINIT_LINK))
endif
endif

ifdef PTXCONF_LVM2_SYSTEMD
	@$(call install_tree, lvm2, 0, 0, -, /usr/lib/udev/rules.d/)
endif
	@$(call install_finish, lvm2)

	@$(call touch)

# vim: syntax=make
