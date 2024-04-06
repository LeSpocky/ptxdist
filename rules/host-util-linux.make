# -*-makefile-*-
#
# Copyright (C) 2010 by Carsten Schlote <c.schlote@konzeptpark.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_UTIL_LINUX) += host-util-linux

#
# Paths and names
#
HOST_UTIL_LINUX_DIR	= $(HOST_BUILDDIR)/$(UTIL_LINUX)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# meson
#

HOST_UTIL_LINUX_CONF_TOOL	:= meson
HOST_UTIL_LINUX_CONF_OPT	:= \
	$(HOST_MESON_OPT) \
	-Daudit=disabled \
	-Dbtrfs=disabled \
	-Dbuild-agetty=disabled \
	-Dbuild-bash-completion=disabled \
	-Dbuild-bfs=disabled \
	-Dbuild-cal=disabled \
	-Dbuild-chfn-chsh=disabled \
	-Dbuild-chmem=disabled \
	-Dbuild-cramfs=disabled \
	-Dbuild-eject=disabled \
	-Dbuild-fallocate=disabled \
	-Dbuild-fdformat=disabled \
	-Dbuild-fdisks=disabled \
	-Dbuild-fsck=disabled \
	-Dbuild-hardlink=disabled \
	-Dbuild-hwclock=disabled \
	-Dbuild-ipcrm=disabled \
	-Dbuild-ipcs=disabled \
	-Dbuild-irqtop=disabled \
	-Dbuild-kill=disabled \
	-Dbuild-last=disabled \
	-Dbuild-libblkid=enabled \
	-Dbuild-libfdisk=disabled \
	-Dbuild-liblastlog2=disabled \
	-Dbuild-libmount=enabled \
	-Dbuild-libsmartcols=disabled \
	-Dbuild-libuuid=enabled \
	-Dbuild-line=disabled \
	-Dbuild-logger=disabled \
	-Dbuild-login=disabled \
	-Dbuild-losetup=disabled \
	-Dbuild-lsirq=disabled \
	-Dbuild-lslogins=disabled \
	-Dbuild-lsmem=disabled \
	-Dbuild-mesg=disabled \
	-Dbuild-minix=disabled \
	-Dbuild-more=disabled \
	-Dbuild-mount=disabled \
	-Dbuild-mountpoint=disabled \
	-Dbuild-newgrp=disabled \
	-Dbuild-nologin=disabled \
	-Dbuild-nsenter=disabled \
	-Dbuild-pam-lastlog2=disabled \
	-Dbuild-partx=disabled \
	-Dbuild-pg=disabled \
	-Dbuild-pipesz=disabled \
	-Dbuild-pivot_root=disabled \
	-Dbuild-plymouth-support=disabled \
	-Dbuild-pylibmount=disabled \
	-Dbuild-python=disabled \
	-Dbuild-raw=disabled \
	-Dbuild-rename=disabled \
	-Dbuild-rfkill=disabled \
	-Dbuild-runuser=disabled \
	-Dbuild-schedutils=disabled \
	-Dbuild-setpriv=disabled \
	-Dbuild-setterm=disabled \
	-Dbuild-su=disabled \
	-Dbuild-sulogin=disabled \
	-Dbuild-switch_root=disabled \
	-Dbuild-tunelp=disabled \
	-Dbuild-ul=disabled \
	-Dbuild-unshare=disabled \
	-Dbuild-utmpdump=disabled \
	-Dbuild-uuidd=disabled \
	-Dbuild-vipw=disabled \
	-Dbuild-wall=disabled \
	-Dbuild-wdctl=disabled \
	-Dbuild-wipefs=disabled \
	-Dbuild-write=disabled \
	-Dbuild-zramctl=disabled \
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
	-Dlibutil=enabled \
	-Dmagic=disabled \
	-Dncurses=disabled \
	-Dncursesw=disabled \
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

# vim: syntax=make
