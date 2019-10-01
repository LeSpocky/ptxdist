# -*-makefile-*-
#
# Copyright (C) 2006 by Sascha Hauer
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_DATA_XBITMAPS) += xorg-data-xbitmaps

#
# Paths and names
#
XORG_DATA_XBITMAPS_VERSION	:= 1.1.2
XORG_DATA_XBITMAPS_MD5		:= cedeef095918aca86da79a2934e03daf
XORG_DATA_XBITMAPS		:= xbitmaps-$(XORG_DATA_XBITMAPS_VERSION)
XORG_DATA_XBITMAPS_SUFFIX	:= tar.bz2
XORG_DATA_XBITMAPS_URL		:= $(call ptx/mirror, XORG, individual/data/$(XORG_DATA_XBITMAPS).$(XORG_DATA_XBITMAPS_SUFFIX))
XORG_DATA_XBITMAPS_SOURCE	:= $(SRCDIR)/$(XORG_DATA_XBITMAPS).$(XORG_DATA_XBITMAPS_SUFFIX)
XORG_DATA_XBITMAPS_DIR		:= $(BUILDDIR)/$(XORG_DATA_XBITMAPS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_DATA_XBITMAPS_PATH	:= PATH=$(CROSS_PATH)
XORG_DATA_XBITMAPS_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_DATA_XBITMAPS_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-data-xbitmaps.targetinstall:
	@$(call targetinfo)
	@$(call touch)

# vim: syntax=make
