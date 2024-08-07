# -*-makefile-*-
#
# Copyright (C) 2003 by Benedikt Spranger
#               2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_FAKEROOT) += host-fakeroot

#
# Paths and names
#
HOST_FAKEROOT_VERSION	:= 1.35.1
HOST_FAKEROOT_MD5	:= 5a75981fd3e805c9f8143bf62103f341
HOST_FAKEROOT_SUFFIX	:= tar.gz
HOST_FAKEROOT		:= fakeroot-$(HOST_FAKEROOT_VERSION)
HOST_FAKEROOT_TARBALL	:= fakeroot_$(HOST_FAKEROOT_VERSION).orig.$(HOST_FAKEROOT_SUFFIX)
HOST_FAKEROOT_URL	:= https://snapshot.debian.org/archive/debian/20240713T143724Z/pool/main/f/fakeroot/$(HOST_FAKEROOT_TARBALL)
HOST_FAKEROOT_SOURCE	:= $(SRCDIR)/$(HOST_FAKEROOT_TARBALL)
HOST_FAKEROOT_DIR	:= $(HOST_BUILDDIR)/$(HOST_FAKEROOT)
HOST_FAKEROOT_LICENSE	:= GPL-3.0-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_FAKEROOT_CONF_ENV	:= \
	$(HOST_ENV) \
	CONFIG_SHELL=/bin/bash

HOST_FAKEROOT_CONF_TOOL := autoconf
HOST_FAKEROOT_CONF_OPT := \
	$(HOST_AUTOCONF) \
	--libdir=/usr/lib/fakeroot

HOST_FAKEROOT_CFLAGS := \
	-fpermissive

HOST_FAKEROOT_INSTALL_OPT := \
	SUBDIRS=scripts \
	install

# vim: syntax=make
