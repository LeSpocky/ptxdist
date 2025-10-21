# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
# Copyright (C) 2009 by Robert Schwebel <r.schwebel@pengutronix.de>
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_FONT_UTIL) += xorg-font-util

#
# Paths and names
#
XORG_FONT_UTIL_VERSION	:= 1.4.1
XORG_FONT_UTIL_MD5	:= a6541d12ceba004c0c1e3df900324642
XORG_FONT_UTIL		:= font-util-$(XORG_FONT_UTIL_VERSION)
XORG_FONT_UTIL_SUFFIX	:= tar.xz
XORG_FONT_UTIL_URL	:= $(call ptx/mirror, XORG, individual/font/$(XORG_FONT_UTIL).$(XORG_FONT_UTIL_SUFFIX))
XORG_FONT_UTIL_SOURCE	:= $(SRCDIR)/$(XORG_FONT_UTIL).$(XORG_FONT_UTIL_SUFFIX)
XORG_FONT_UTIL_DIR	:= $(BUILDDIR)/$(XORG_FONT_UTIL)
XORG_FONT_UTIL_LICENSE	:= MIT AND BSD-2-Clause-NetBSD AND BSD-Source-Code AND MIT-open-group AND Unicode-TOU
XORG_FONT_UTIL_LICENSE_FILES := \
	file://COPYING;md5=2a9e705c00e463c8d294f90486852e06

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_FONT_UTIL_CONF_TOOL := autoconf

# vim: syntax=make
