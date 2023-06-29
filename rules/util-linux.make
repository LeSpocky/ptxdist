# -*-makefile-*-
#
# Copyright (C) 2008 by Robert Schwebel
#               2010 by Marc Kleine-Budde <mkl@penutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_UTIL_LINUX) += util-linux

#
# Paths and names
#
UTIL_LINUX_VERSION	:= 2.39.1
UTIL_LINUX_MD5		:= c542cd7c0726254e4b3006a9b428201a
UTIL_LINUX		:= util-linux-$(UTIL_LINUX_VERSION)
UTIL_LINUX_SUFFIX	:= tar.xz
UTIL_LINUX_BASENAME	:= v$(if $(filter 2,$(basename $(UTIL_LINUX_VERSION))),$(UTIL_LINUX_VERSION),$(basename $(UTIL_LINUX_VERSION)))
UTIL_LINUX_URL		:= $(call ptx/mirror, KERNEL, utils/util-linux/$(UTIL_LINUX_BASENAME)/$(UTIL_LINUX).$(UTIL_LINUX_SUFFIX))
UTIL_LINUX_SOURCE	:= $(SRCDIR)/$(UTIL_LINUX).$(UTIL_LINUX_SUFFIX)
UTIL_LINUX_DIR		:= $(BUILDDIR)/$(UTIL_LINUX)
UTIL_LINUX_LICENSE	:= GPL-2.0-only AND GPL-2.0-or-later AND LGPL-2.0-or-later AND BSD-3-Clause AND BSD-4-Clause AND public_domain
UTIL_LINUX_LICENSE_FILES := \
	file://Documentation/licenses/COPYING.GPL-2.0-or-later;md5=b234ee4d69f5fce4486a80fdaf4a4263 \
	file://Documentation/licenses/COPYING.BSD-3-Clause;md5=58dcd8452651fc8b07d1f65ce07ca8af \
	file://Documentation/licenses/COPYING.BSD-4-Clause-UC;md5=263860f8968d8bafa5392cab74285262 \
	file://Documentation/licenses/COPYING.LGPL-2.1-or-later;md5=4fbd65380cdd255951079008b364516c

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

UTIL_LINUX_CONF_ENV	:= \
	$(CROSS_ENV) \
	$(call ptx/ncurses, PTXCONF_UTIL_LINUX_USES_NCURSES) \
	scanf_cv_type_modifier=as \
	ac_cv_path_BLKID=no \
	ac_cv_path_PERL=no \
	ac_cv_path_VOLID=no

#
# autoconf
#
UTIL_LINUX_CONF_TOOL	:= autoconf
UTIL_LINUX_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--bindir=/usr/bin \
	--sbindir=/usr/sbin \
	--disable-werror \
	--disable-asan \
	--disable-ubsan \
	--disable-fuzzing-engine \
	--enable-shared \
	--disable-static \
	--enable-symvers \
	--disable-gtk-doc \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--enable-assert \
	--disable-nls \
	--disable-rpath \
	--disable-static-programs \
	--enable-all-programs=undefined \
	--disable-asciidoc \
	--disable-poman \
	--enable-tls \
	--disable-widechar \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_LIBUUID)-libuuid \
	--disable-libuuid-force-uuidd \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_LIBBLKID)-libblkid \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_LIBMOUNT)-libmount \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_LIBSMARTCOLS)-libsmartcols \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_LIBFDISK)-libfdisk \
	$(call ptx/ifdef, PTXCONF_UTIL_LINUX_FDISKS,,--disable-fdisks) \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_MOUNT)-mount \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_LOSETUP)-losetup \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_ZRAMCTL)-zramctl \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_FSCK)-fsck \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_PARTX_TOOLS)-partx \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_UUIDD)-uuidd \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_UUIDGEN)-uuidgen \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_BLKID)-blkid \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_WIPEFS)-wipefs \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_MOUNTPOINT)-mountpoint \
	--disable-fallocate \
	--disable-unshare \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_NSENTER)-nsenter \
	--disable-setpriv \
	--disable-hardlink \
	--disable-eject \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_AGETTY)-agetty \
	--disable-plymouth_support \
	--disable-cramfs \
	--disable-bfs \
	--disable-minix \
	--disable-fdformat \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_HWCLOCK)-hwclock \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_MKFS)-mkfs \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_FSTRIM)-fstrim \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_SWAPON)-swapon \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_LSCPU)-lscpu \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_LSFD)-lsfd \
	--disable-lslogins \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_WDCTL)-wdctl \
	--disable-cal \
	--disable-logger \
	--disable-whereis \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_PIPESZ)-pipesz \
	--disable-waitpid \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_SWITCH_ROOT)-switch_root \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_PIVOT_ROOT)-pivot_root \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_LSMEM)-lsmem \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_CHMEM)-chmem \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_IPCMK)-ipcmk \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_IPCRM)-ipcrm \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_IPCS)-ipcs \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_IRQTOP)-irqtop \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_LSIRQ)-lsirq \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_LSNS)-lsns \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_RFKILL)-rfkill \
	--disable-scriptutils \
	--disable-tunelp \
	--disable-kill \
	--disable-last \
	--disable-utmpdump \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_LINE)-line \
	--disable-mesg \
	--disable-raw \
	--disable-rename \
	--disable-vipw \
	--disable-newgrp \
	--disable-chfn-chsh-password \
	--disable-chfn-chsh \
	--disable-chsh-only-listed \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_LOGIN)-login \
	--disable-login-chown-vcs \
	--disable-login-stat-mail \
	--disable-nologin \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_SULOGIN)-sulogin \
	--disable-su \
	--disable-runuser \
	--disable-ul \
	--disable-more \
	--disable-pg \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_SETTERM)-setterm \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_SCHEDUTILS)-schedutils \
	--disable-wall \
	--disable-write \
	--disable-bash-completion \
	--disable-pylibmount \
	--disable-pg-bell \
	--disable-use-tty-group \
	--disable-sulogin-emergency-mount \
	--disable-usrdir-path \
	--disable-makeinstall-chown \
	--disable-makeinstall-setuid \
	--disable-colors-default \
	--without-libiconv-prefix \
	--without-libintl-prefix \
	--with-util \
	--without-selinux \
	--without-audit \
	--without-udev \
	--without-ncursesw \
	--$(call ptx/wwo, PTXCONF_UTIL_LINUX_USES_NCURSES)-ncurses \
	--without-slang \
	--without-tinfo \
	--without-readline \
	--without-utempter \
	--without-cap-ng \
	--without-libz \
	--without-libmagic \
	--without-user \
	--without-btrfs \
	--without-systemd \
	--with-systemdsystemunitdir=/usr/lib/systemd/system \
	--without-smack \
	--without-econf \
	--without-python \
	--without-cryptsetup

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

UTIL_LINUX_LIB-y :=
UTIL_LINUX_BIN-y :=

# libraries
UTIL_LINUX_LIB-$(PTXCONF_UTIL_LINUX_LIBBLKID)		+= blkid
UTIL_LINUX_LIB-$(PTXCONF_UTIL_LINUX_LIBUUID)		+= uuid
UTIL_LINUX_LIB-$(PTXCONF_UTIL_LINUX_LIBMOUNT)		+= mount
UTIL_LINUX_LIB-$(PTXCONF_UTIL_LINUX_LIBSMARTCOLS)	+= smartcols
UTIL_LINUX_LIB-$(PTXCONF_UTIL_LINUX_LIBFDISK)		+= fdisk

# disk-utils
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_ADDPART)		+= sbin/addpart
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_CFDISK)		+= sbin/cfdisk
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_DELPART)		+= sbin/delpart
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_FDISK)		+= sbin/fdisk
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_FSCK)		+= sbin/fsck
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_MKFS)		+= sbin/mkfs
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_MKSWAP)		+= sbin/mkswap
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_PARTX)		+= sbin/partx
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_SFDISK)		+= sbin/sfdisk
# login-utils
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_LOGIN)		+= bin/login
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_SULOGIN)		+= sbin/sulogin
# misc-utils
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_BLKID)		+= sbin/blkid
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_FINDFS)		+= sbin/findfs
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_GETOPT)		+= bin/getopt
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_LSBLK)		+= bin/lsblk
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_MCOOKIE)		+= bin/mcookie
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_UUIDD)		+= sbin/uuidd
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_UUIDGEN)		+= bin/uuidgen
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_WIPEFS)		+= sbin/wipefs
# schedutils
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_CHRT)		+= bin/chrt
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_IONICE)		+= bin/ionice
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_TASKSET)		+= bin/taskset
# sys-utils
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_CHMEM)		+= bin/chmem
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_DMESG)		+= bin/dmesg
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_FLOCK)		+= bin/flock
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_FSFREEZE)		+= sbin/fsfreeze
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_FSTRIM)		+= sbin/fstrim
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_HWCLOCK)		+= sbin/hwclock
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_IPCRM)		+= bin/ipcrm
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_IPCS)		+= bin/ipcs
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_IRQTOP)		+= bin/irqtop
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_LDATTACH)		+= sbin/ldattach
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_LOSETUP)		+= sbin/losetup
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_LSCPU)		+= bin/lscpu
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_LSFD)		+= bin/lsfd
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_LSIRQ)		+= bin/lsirq
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_LSNS)		+= bin/lsns
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_LSMEM)		+= bin/lsmem
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_MOUNT)		+= bin/mount
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_MOUNTPOINT)		+= bin/mountpoint
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_NSENTER)		+= bin/nsenter
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_PIVOT_ROOT)		+= sbin/pivot_root
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_READPROFILE)	+= sbin/readprofile
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_RFKILL)		+= sbin/rfkill
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_SWAPON)		+= sbin/swapoff sbin/swapon
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_PIPESZ)		+= bin/pipesz
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_SWITCH_ROOT)	+= sbin/switch_root
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_UMOUNT)		+= bin/umount
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_WDCTL)		+= bin/wdctl
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_ZRAMCTL)		+= sbin/zramctl
# term-utils
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_AGETTY)		+= sbin/agetty
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_SETTERM)		+= bin/setterm
# text-utils
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_COLUMN)		+= bin/column
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_LINE)		+= bin/line

$(STATEDIR)/util-linux.targetinstall:
	@$(call targetinfo)

	@$(call install_init, util-linux)
	@$(call install_fixup, util-linux,PRIORITY,optional)
	@$(call install_fixup, util-linux,SECTION,base)
	@$(call install_fixup, util-linux,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, util-linux,DESCRIPTION,missing)

	@$(foreach lib, $(UTIL_LINUX_LIB-y), \
		$(call install_lib, util-linux, 0, 0, 0644, \
		lib$(lib))$(ptx/nl))

	@$(foreach tool, $(UTIL_LINUX_BIN-y), \
		$(call install_copy, util-linux, 0, 0, 0755, -, \
		/usr/$(tool))$(ptx/nl))

	@$(call install_finish, util-linux)

	@$(call touch)

# vim: syntax=make
