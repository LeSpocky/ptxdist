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
UTIL_LINUX_VERSION	:= 2.39.3
UTIL_LINUX_MD5		:= f3591e6970c017bb4bcd24ae762a98f5
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

# only one of -Dncurses= and -Dncursesw= can be enabled.
ifndef PTXCONF_UTIL_LINUX_USES_NCURSESW
UTIL_LINUX_USES_NCURSES := $(PTXCONF_UTIL_LINUX_USES_NCURSES)
else
UTIL_LINUX_USES_NCURSES :=
endif

#
# meson
#
UTIL_LINUX_CONF_TOOL	:= meson
UTIL_LINUX_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Daudit=disabled \
	-Dbtrfs=disabled \
	-Dbuild-agetty=$(call ptx/endis, PTXCONF_UTIL_LINUX_AGETTY)d \
	-Dbuild-bash-completion=disabled \
	-Dbuild-bfs=disabled \
	-Dbuild-cal=disabled \
	-Dbuild-chfn-chsh=disabled \
	-Dbuild-chmem=$(call ptx/endis, PTXCONF_UTIL_LINUX_CHMEM)d \
	-Dbuild-cramfs=disabled \
	-Dbuild-eject=disabled \
	-Dbuild-fallocate=disabled \
	-Dbuild-fdformat=disabled \
	-Dbuild-fdisks=$(call ptx/endis, PTXCONF_UTIL_LINUX_FDISKS)d \
	-Dbuild-fsck=$(call ptx/endis, PTXCONF_UTIL_LINUX_FSCK)d \
	-Dbuild-hardlink=disabled \
	-Dbuild-hwclock=$(call ptx/endis, PTXCONF_UTIL_LINUX_HWCLOCK)d \
	-Dbuild-ipcrm=$(call ptx/endis, PTXCONF_UTIL_LINUX_IPCRM)d \
	-Dbuild-ipcs=$(call ptx/endis, PTXCONF_UTIL_LINUX_IPCS)d \
	-Dbuild-irqtop=$(call ptx/endis, PTXCONF_UTIL_LINUX_IRQTOP)d \
	-Dbuild-kill=disabled \
	-Dbuild-last=disabled \
	-Dbuild-libblkid=$(call ptx/endis, PTXCONF_UTIL_LINUX_LIBBLKID)d \
	-Dbuild-libfdisk=$(call ptx/endis, PTXCONF_UTIL_LINUX_LIBFDISK)d \
	-Dbuild-libmount=$(call ptx/endis, PTXCONF_UTIL_LINUX_LIBMOUNT)d \
	-Dbuild-libsmartcols=$(call ptx/endis, PTXCONF_UTIL_LINUX_LIBSMARTCOLS)d \
	-Dbuild-libuuid=$(call ptx/endis, PTXCONF_UTIL_LINUX_LIBUUID)d \
	-Dbuild-line=$(call ptx/endis, PTXCONF_UTIL_LINUX_LINE)d \
	-Dbuild-logger=disabled \
	-Dbuild-login=$(call ptx/endis, PTXCONF_UTIL_LINUX_LOGIN)d \
	-Dbuild-losetup=$(call ptx/endis, PTXCONF_UTIL_LINUX_LOSETUP)d \
	-Dbuild-lsirq=$(call ptx/endis, PTXCONF_UTIL_LINUX_LSIRQ)d \
	-Dbuild-lslogins=disabled \
	-Dbuild-lsmem=$(call ptx/endis, PTXCONF_UTIL_LINUX_LSMEM)d \
	-Dbuild-mesg=disabled \
	-Dbuild-minix=disabled \
	-Dbuild-more=disabled \
	-Dbuild-mount=$(call ptx/endis, PTXCONF_UTIL_LINUX_MOUNT)d \
	-Dbuild-mountpoint=$(call ptx/endis, PTXCONF_UTIL_LINUX_MOUNTPOINT)d \
	-Dbuild-newgrp=disabled \
	-Dbuild-nologin=disabled \
	-Dbuild-nsenter=$(call ptx/endis, PTXCONF_UTIL_LINUX_NSENTER)d \
	-Dbuild-partx=$(call ptx/endis, PTXCONF_UTIL_LINUX_PARTX_TOOLS)d \
	-Dbuild-pg=disabled \
	-Dbuild-pipesz=$(call ptx/endis, PTXCONF_UTIL_LINUX_PIPESZ)d \
	-Dbuild-pivot_root=$(call ptx/endis, PTXCONF_UTIL_LINUX_PIVOT_ROOT)d \
	-Dbuild-plymouth-support=disabled \
	-Dbuild-pylibmount=disabled \
	-Dbuild-python=disabled \
	-Dbuild-raw=disabled \
	-Dbuild-rename=disabled \
	-Dbuild-rfkill=$(call ptx/endis, PTXCONF_UTIL_LINUX_RFKILL)d \
	-Dbuild-runuser=disabled \
	-Dbuild-schedutils=$(call ptx/endis, PTXCONF_UTIL_LINUX_SCHEDUTILS)d \
	-Dbuild-setpriv=disabled \
	-Dbuild-setterm=$(call ptx/endis, PTXCONF_UTIL_LINUX_SETTERM)d \
	-Dbuild-su=disabled \
	-Dbuild-sulogin=$(call ptx/endis, PTXCONF_UTIL_LINUX_SULOGIN)d \
	-Dbuild-switch_root=$(call ptx/endis, PTXCONF_UTIL_LINUX_SWITCH_ROOT)d \
	-Dbuild-tunelp=disabled \
	-Dbuild-ul=disabled \
	-Dbuild-unshare=disabled \
	-Dbuild-utmpdump=disabled \
	-Dbuild-uuidd=$(call ptx/endis, PTXCONF_UTIL_LINUX_UUIDD)d \
	-Dbuild-vipw=disabled \
	-Dbuild-wall=disabled \
	-Dbuild-wdctl=$(call ptx/endis, PTXCONF_UTIL_LINUX_WDCTL)d \
	-Dbuild-wipefs=$(call ptx/endis, PTXCONF_UTIL_LINUX_WIPEFS)d \
	-Dbuild-write=disabled \
	-Dbuild-zramctl=$(call ptx/endis, PTXCONF_UTIL_LINUX_ZRAMCTL)d \
	-Dchfn-chsh-password=true \
	-Dchsh-only-listed=true \
	-Dcolors-default=true \
	-Dcryptsetup=disabled \
	-Dcryptsetup-dlopen=disabled \
	-Deconf=disabled \
	-Dfs-search-path=/usr/sbin \
	-Dfs-search-path-extra= \
	-Dlibpcre2-posix=disabled \
	-Dlibuser=disabled \
	-Dlibutempter=disabled \
	-Dlibutil=disabled \
	-Dmagic=disabled \
	-Dncurses=$(call ptx/endis, UTIL_LINUX_USES_NCURSES)d \
	-Dncursesw=$(call ptx/endis, PTXCONF_UTIL_LINUX_USES_NCURSESW)d \
	-Dnls=disabled \
	-Dpg-bell=false \
	-Dpython=false \
	-Dreadline=disabled \
	-Dselinux=disabled \
	-Dslang=disabled \
	-Dsmack=disabled \
	-Dstatic-programs= \
	-Dsystemd=disabled \
	-Dsysvinit=disabled \
	-Dtinfo=disabled \
	-Duse-tls=true \
	-Duse-tty-group=false \
	-Dvendordir= \
	-Dwidechar=$(call ptx/disen, UTIL_LINUX_USES_NCURSES)d \
	-Dzlib=disabled

ifndef PTXCONF_GLIBC_2_34
UTIL_LINUX_LDFLAGS := -lutil
endif

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
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_RESIZEPART)		+= sbin/resizepart
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
UTIL_LINUX_BIN-$(PTXCONF_UTIL_LINUX_SETSID)		+= bin/setsid
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
