# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_LIB_XTRANS) += xorg-lib-xtrans

#
# Paths and names
#
XORG_LIB_XTRANS_VERSION	:= 1.6.0
XORG_LIB_XTRANS_MD5	:= 6ad67d4858814ac24e618b8072900664
XORG_LIB_XTRANS		:= xtrans-$(XORG_LIB_XTRANS_VERSION)
XORG_LIB_XTRANS_SUFFIX	:= tar.xz
XORG_LIB_XTRANS_URL	:= $(call ptx/mirror, XORG, individual/lib/$(XORG_LIB_XTRANS).$(XORG_LIB_XTRANS_SUFFIX))
XORG_LIB_XTRANS_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XTRANS).$(XORG_LIB_XTRANS_SUFFIX)
XORG_LIB_XTRANS_DIR	:= $(BUILDDIR)/$(XORG_LIB_XTRANS)
XORG_LIB_XTRANS_LICENSE	:= MIT-open-group AND HPND-sell-variant AND MIT AND X11
XORG_LIB_XTRANS_LICENSE_FILES := \
	file://COPYING;md5=d6091702432f176651d4bf09e61bbe2d

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_LIB_XTRANS_CONF_TOOL	:= autoconf
XORG_LIB_XTRANS_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-docs \
	$(XORG_OPTIONS_DOCS)

# vim: syntax=make
