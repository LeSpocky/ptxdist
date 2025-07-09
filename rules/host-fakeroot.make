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
HOST_FAKEROOT_VERSION	:= 1.37.1.2
HOST_FAKEROOT_MD5	:= e1ed8058217779bb364a8268010a60c4
HOST_FAKEROOT_SUFFIX	:= tar.gz
HOST_FAKEROOT		:= fakeroot-$(HOST_FAKEROOT_VERSION)
HOST_FAKEROOT_TARBALL	:= fakeroot_$(HOST_FAKEROOT_VERSION).orig.$(HOST_FAKEROOT_SUFFIX)
HOST_FAKEROOT_URL	:= https://snapshot.debian.org/archive/debian/20250707T203754Z/pool/main/f/fakeroot/$(HOST_FAKEROOT_TARBALL)
HOST_FAKEROOT_SOURCE	:= $(SRCDIR)/$(HOST_FAKEROOT_TARBALL)
HOST_FAKEROOT_DIR	:= $(HOST_BUILDDIR)/$(HOST_FAKEROOT)
HOST_FAKEROOT_LICENSE	:= GPL-3.0-or-later
HOST_FAKEROOT_LICENSE_FILES := \
	file://COPYING;md5=f27defe1e96c2e1ecd4e0c9be8967949

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

HOST_FAKEROOT_INSTALL_OPT := \
	SUBDIRS=scripts \
	install

# vim: syntax=make
