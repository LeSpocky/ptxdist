# -*-makefile-*-
#
# Copyright (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_CHRPATH) += host-chrpath

#
# Paths and names
#
HOST_CHRPATH_VERSION	:= 0.18
HOST_CHRPATH_SHA256	:= f09c49f0618660ca11fc6d9580ddde904c7224d4c6d0f6f2d1f9bcdc9102c9aa
HOST_CHRPATH_SUFFIX	:= tar.gz
HOST_CHRPATH		:= chrpath-$(HOST_CHRPATH_VERSION)
HOST_CHRPATH_TARBALL	:= chrpath_$(HOST_CHRPATH_VERSION).orig.$(HOST_CHRPATH_SUFFIX)
HOST_CHRPATH_URL	:= http://snapshot.debian.org/archive/debian/20250106T091447Z/pool/main/c/chrpath/$(HOST_CHRPATH_TARBALL)
HOST_CHRPATH_SOURCE	:= $(SRCDIR)/$(HOST_CHRPATH).$(HOST_CHRPATH_SUFFIX)
HOST_CHRPATH_DIR	:= $(HOST_BUILDDIR)/$(HOST_CHRPATH)
HOST_CHRPATH_LICENSE	:= GPL-2.0-or-later
HOST_CHRPATH_LICENSE_FILES := \
	file://COPYING;md5=59530bdf33659b29e73d4adb9f9f6552 \
	file://main.c;startline=10;endline=13;md5=1b5e3f7c30bb16a7ea4210bfed447f68

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_CHRPATH_CONF_TOOL	:= autoconf

# vim: syntax=make
