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
XORG_FONT_UTIL_VERSION	:= 1.3.2
XORG_FONT_UTIL_MD5	:= 3d6adb76fdd072db8c8fae41b40855e8
XORG_FONT_UTIL		:= font-util-$(XORG_FONT_UTIL_VERSION)
XORG_FONT_UTIL_SUFFIX	:= tar.bz2
XORG_FONT_UTIL_URL	:= $(call ptx/mirror, XORG, individual/font/$(XORG_FONT_UTIL).$(XORG_FONT_UTIL_SUFFIX))
XORG_FONT_UTIL_SOURCE	:= $(SRCDIR)/$(XORG_FONT_UTIL).$(XORG_FONT_UTIL_SUFFIX)
XORG_FONT_UTIL_DIR	:= $(BUILDDIR)/$(XORG_FONT_UTIL)
XORG_FONT_UTIL_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_FONT_UTIL_CONF_TOOL := autoconf

# vim: syntax=make
