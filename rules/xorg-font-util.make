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
XORG_FONT_UTIL_VERSION	:= 1.4.2
XORG_FONT_UTIL_SHA256	:= 02e4f8afdcf03cc8372ca9c37aa104b1e36b47722dbc79531be08f0a4c622999
XORG_FONT_UTIL		:= font-util-$(XORG_FONT_UTIL_VERSION)
XORG_FONT_UTIL_SUFFIX	:= tar.xz
XORG_FONT_UTIL_URL	:= $(call ptx/mirror, XORG, individual/font/$(XORG_FONT_UTIL).$(XORG_FONT_UTIL_SUFFIX))
XORG_FONT_UTIL_SOURCE	:= $(SRCDIR)/$(XORG_FONT_UTIL).$(XORG_FONT_UTIL_SUFFIX)
XORG_FONT_UTIL_DIR	:= $(BUILDDIR)/$(XORG_FONT_UTIL)
XORG_FONT_UTIL_LICENSE	:= MIT AND BSD-2-Clause-NetBSD AND BSD-Source-Code AND MIT-open-group AND Unicode-TOU
XORG_FONT_UTIL_LICENSE_FILES := \
	file://COPYING;md5=756e7412ee04c80f5833cd2f35242f7a

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_FONT_UTIL_CONF_TOOL := autoconf
XORG_FONT_UTIL_CONF_OPT  :=  \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--$(call ptx/endis, PTXCONF_GLIBC_Y2038)-year2038

# vim: syntax=make
