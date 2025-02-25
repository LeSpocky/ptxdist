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
HOST_CHRPATH_MD5	:= 3220be4f47361bfd0b76e2132c0219c0
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
