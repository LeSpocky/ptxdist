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
# autoconf
#

HOST_UTIL_LINUX_CONF_TOOL	:= autoconf
HOST_UTIL_LINUX_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--disable-werror \
	--disable-asan \
	--disable-ubsan \
	--disable-fuzzing-engine \
	--enable-shared \
	--disable-static \
	--enable-symvers \
	--disable-gtk-doc \
	--enable-assert \
	--disable-nls \
	--disable-rpath \
	--disable-static-programs \
	--disable-all-programs \
	--disable-asciidoc \
	--disable-poman \
	--enable-tls \
	--disable-widechar \
	--enable-libuuid \
	--disable-libuuid-force-uuidd \
	--enable-libblkid \
	--enable-libmount \
	--disable-libsmartcols \
	--disable-libfdisk \
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
	--without-audit \
	--without-udev \
	--without-ncurses \
	--without-slang \
	--without-tinfo \
	--without-readline \
	--without-utempter \
	--without-libz \
	--without-user \
	--without-systemd \
	--without-smack \
	--without-python

# vim: syntax=make
