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
PACKAGES-$(PTXCONF_UTIL_LINUX_NG) += util-linux-ng

#
# Paths and names
#
UTIL_LINUX_NG_VERSION	:= 2.38.1
UTIL_LINUX_NG_MD5	:= cd11456f4ddd31f7fbfdd9488c0c0d02
UTIL_LINUX_NG		:= util-linux-$(UTIL_LINUX_NG_VERSION)
UTIL_LINUX_NG_SUFFIX	:= tar.xz
UTIL_LINUX_NG_BASENAME	:= v$(if $(filter 2,$(basename $(UTIL_LINUX_NG_VERSION))),$(UTIL_LINUX_NG_VERSION),$(basename $(UTIL_LINUX_NG_VERSION)))
UTIL_LINUX_NG_URL	:= $(call ptx/mirror, KERNEL, utils/util-linux/$(UTIL_LINUX_NG_BASENAME)/$(UTIL_LINUX_NG).$(UTIL_LINUX_NG_SUFFIX))
UTIL_LINUX_NG_SOURCE	:= $(SRCDIR)/$(UTIL_LINUX_NG).$(UTIL_LINUX_NG_SUFFIX)
UTIL_LINUX_NG_DIR	:= $(BUILDDIR)/$(UTIL_LINUX_NG)
UTIL_LINUX_NG_LICENSE	:= GPL-2.0-only AND GPL-2.0-or-later AND LGPL-2.0-or-later AND BSD-3-Clause AND BSD-4-Clause AND public_domain
UTIL_LINUX_NG_LICENSE_FILES := \
	file://Documentation/licenses/COPYING.GPL-2.0-or-later;md5=b234ee4d69f5fce4486a80fdaf4a4263 \
	file://Documentation/licenses/COPYING.BSD-3-Clause;md5=58dcd8452651fc8b07d1f65ce07ca8af \
	file://Documentation/licenses/COPYING.BSD-4-Clause-UC;md5=263860f8968d8bafa5392cab74285262 \
	file://Documentation/licenses/COPYING.LGPL-2.1-or-later;md5=4fbd65380cdd255951079008b364516c

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

UTIL_LINUX_NG_CONF_ENV	:= \
	$(CROSS_ENV) \
	$(call ptx/ncurses, PTXCONF_UTIL_LINUX_NG_USES_NCURSES) \
	scanf_cv_type_modifier=as \
	ac_cv_path_BLKID=no \
	ac_cv_path_PERL=no \
	ac_cv_path_VOLID=no

#
# autoconf
#
UTIL_LINUX_NG_CONF_TOOL	:= autoconf
UTIL_LINUX_NG_CONF_OPT	:= \
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
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_NG_LIBUUID)-libuuid \
	--disable-libuuid-force-uuidd \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_NG_LIBBLKID)-libblkid \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_NG_LIBMOUNT)-libmount \
	--disable-libmount-support-mtab \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_NG_LIBSMARTCOLS)-libsmartcols \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_NG_LIBFDISK)-libfdisk \
	$(call ptx/ifdef, PTXCONF_UTIL_LINUX_NG_FDISKS,,--disable-fdisks) \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_NG_MOUNT)-mount \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_NG_LOSETUP)-losetup \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_NG_ZRAMCTL)-zramctl \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_NG_FSCK)-fsck \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_NG_PARTX_TOOLS)-partx \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_NG_UUIDD)-uuidd \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_NG_UUIDGEN)-uuidgen \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_NG_BLKID)-blkid \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_NG_WIPEFS)-wipefs \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_NG_MOUNTPOINT)-mountpoint \
	--disable-fallocate \
	--disable-unshare \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_NG_NSENTER)-nsenter \
	--disable-setpriv \
	--disable-hardlink \
	--disable-eject \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_NG_AGETTY)-agetty \
	--disable-plymouth_support \
	--disable-cramfs \
	--disable-bfs \
	--disable-minix \
	--disable-fdformat \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_NG_HWCLOCK)-hwclock \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_NG_MKFS)-mkfs \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_NG_FSTRIM)-fstrim \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_NG_SWAPON)-swapon \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_NG_LSCPU)-lscpu \
	--disable-lslogins \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_NG_WDCTL)-wdctl \
	--disable-cal \
	--disable-logger \
	--disable-whereis \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_NG_SWITCH_ROOT)-switch_root \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_NG_PIVOT_ROOT)-pivot_root \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_NG_LSMEM)-lsmem \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_NG_CHMEM)-chmem \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_NG_IPCRM)-ipcrm \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_NG_IPCS)-ipcs \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_NG_IRQTOP)-irqtop \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_NG_LSIRQ)-lsirq \
	--disable-rfkill \
	--disable-scriptutils \
	--disable-tunelp \
	--disable-kill \
	--disable-last \
	--disable-utmpdump \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_NG_LINE)-line \
	--disable-mesg \
	--disable-raw \
	--disable-rename \
	--disable-vipw \
	--disable-newgrp \
	--disable-chfn-chsh-password \
	--disable-chfn-chsh \
	--disable-chsh-only-listed \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_NG_LOGIN)-login \
	--disable-login-chown-vcs \
	--disable-login-stat-mail \
	--disable-nologin \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_NG_SULOGIN)-sulogin \
	--disable-su \
	--disable-runuser \
	--disable-ul \
	--disable-more \
	--disable-pg \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_NG_SETTERM)-setterm \
	--$(call ptx/endis, PTXCONF_UTIL_LINUX_NG_SCHEDUTILS)-schedutils \
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
	--$(call ptx/wwo, PTXCONF_UTIL_LINUX_NG_USES_NCURSES)-ncurses \
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
UTIL_LINUX_LIB-$(PTXCONF_UTIL_LINUX_NG_LIBBLKID)	+= blkid
UTIL_LINUX_LIB-$(PTXCONF_UTIL_LINUX_NG_LIBUUID)		+= uuid
UTIL_LINUX_LIB-$(PTXCONF_UTIL_LINUX_NG_LIBMOUNT)	+= mount
UTIL_LINUX_LIB-$(PTXCONF_UTIL_LINUX_NG_LIBSMARTCOLS)	+= smartcols
UTIL_LINUX_LIB-$(PTXCONF_UTIL_LINUX_NG_LIBFDISK)	+= fdisk

# disk-utils
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_NG_ADDPART)		+= sbin/addpart
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_NG_CFDISK)		+= sbin/cfdisk
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_NG_DELPART)		+= sbin/delpart
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_NG_FDISK)		+= sbin/fdisk
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_NG_FSCK)		+= sbin/fsck
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_NG_MKFS)		+= sbin/mkfs
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_NG_MKSWAP)		+= sbin/mkswap
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_NG_PARTX)		+= sbin/partx
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_NG_SFDISK)		+= sbin/sfdisk
# login-utils
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_NG_LOGIN)		+= bin/login
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_NG_SULOGIN)		+= sbin/sulogin
# misc-utils
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_NG_BLKID)		+= sbin/blkid
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_NG_FINDFS)		+= sbin/findfs
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_NG_GETOPT)		+= bin/getopt
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_NG_LSBLK)		+= bin/lsblk
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_NG_MCOOKIE)		+= bin/mcookie
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_NG_UUIDD)		+= sbin/uuidd
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_NG_UUIDGEN)		+= bin/uuidgen
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_NG_WIPEFS)		+= sbin/wipefs
# schedutils
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_NG_CHRT)		+= bin/chrt
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_NG_IONICE)		+= bin/ionice
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_NG_TASKSET)		+= bin/taskset
# sys-utils
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_NG_CHMEM)		+= bin/chmem
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_NG_DMESG)		+= bin/dmesg
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_NG_FLOCK)		+= bin/flock
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_NG_FSFREEZE)	+= sbin/fsfreeze
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_NG_FSTRIM)		+= sbin/fstrim
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_NG_HWCLOCK)		+= sbin/hwclock
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_NG_IPCRM)		+= bin/ipcrm
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_NG_IPCS)		+= bin/ipcs
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_NG_IRQTOP)		+= bin/irqtop
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_NG_LDATTACH)	+= sbin/ldattach
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_NG_LOSETUP)		+= sbin/losetup
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_NG_LSCPU)		+= bin/lscpu
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_NG_LSIRQ)		+= bin/lsirq
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_NG_LSMEM)		+= bin/lsmem
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_NG_MOUNT)		+= bin/mount
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_NG_MOUNTPOINT)	+= bin/mountpoint
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_NG_NSENTER)		+= bin/nsenter
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_NG_PIVOT_ROOT)	+= sbin/pivot_root
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_NG_READPROFILE)	+= sbin/readprofile
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_NG_SWAPON)		+= sbin/swapoff sbin/swapon
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_NG_SWITCH_ROOT)	+= sbin/switch_root
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_NG_UMOUNT)		+= bin/umount
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_NG_WDCTL)		+= bin/wdctl
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_NG_ZRAMCTL)		+= sbin/zramctl
# term-utils
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_NG_AGETTY)		+= sbin/agetty
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_NG_SETTERM)		+= bin/setterm
# text-utils
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_NG_COLUMN)		+= bin/column
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_NG_LINE)		+= bin/line

$(STATEDIR)/util-linux-ng.targetinstall:
	@$(call targetinfo)

	@$(call install_init, util-linux-ng)
	@$(call install_fixup, util-linux-ng,PRIORITY,optional)
	@$(call install_fixup, util-linux-ng,SECTION,base)
	@$(call install_fixup, util-linux-ng,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, util-linux-ng,DESCRIPTION,missing)

	@$(foreach lib, $(UTIL_LINUX_LIB-y), \
		$(call install_lib, util-linux-ng, 0, 0, 0644, \
		lib$(lib))$(ptx/nl))

	@$(foreach tool, $(UTIL_LINUX_BIN-y), \
		$(call install_copy, util-linux-ng, 0, 0, 0755, -, \
		/usr/$(tool))$(ptx/nl))

	@$(call install_finish, util-linux-ng)

	@$(call touch)

# vim: syntax=make
