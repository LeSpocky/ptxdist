# -*-makefile-*-
#
# Copyright (C) 2006 by Marc Kleine-Budde <mkl@pengutronix.de>
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_XORG_LIB_XFONT) += host-xorg-lib-xfont

#
# Paths and names
#
HOST_XORG_LIB_XFONT_VERSION	:= 1.5.4
HOST_XORG_LIB_XFONT_MD5		:= 16eaf156edd79b68038b6a7c44aa9e9b
HOST_XORG_LIB_XFONT		:= libXfont-$(HOST_XORG_LIB_XFONT_VERSION)
HOST_XORG_LIB_XFONT_SUFFIX	:= tar.bz2
HOST_XORG_LIB_XFONT_URL		:= $(call ptx/mirror, XORG, individual/lib/$(HOST_XORG_LIB_XFONT).$(HOST_XORG_LIB_XFONT_SUFFIX))
HOST_XORG_LIB_XFONT_SOURCE	:= $(SRCDIR)/$(HOST_XORG_LIB_XFONT).$(HOST_XORG_LIB_XFONT_SUFFIX)
HOST_XORG_LIB_XFONT_DIR		:= $(HOST_BUILDDIR)/$(HOST_XORG_LIB_XFONT)
HOST_XORG_LIB_XFONT_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_XORG_LIB_XFONT_PATH	:= PATH=$(HOST_PATH)
HOST_XORG_LIB_XFONT_ENV		:= $(HOST_ENV)

#
# autoconf
#
HOST_XORG_LIB_XFONT_CONF_TOOL	:= autoconf
HOST_XORG_LIB_XFONT_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--disable-static \
	--disable-freetype \
	--without-xmlto

# vim: syntax=make
