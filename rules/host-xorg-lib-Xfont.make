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
HOST_XORG_LIB_XFONT_SHA256	:= 1a7f7490774c87f2052d146d1e0e64518d32e6848184a18654e8d0bb57883242
HOST_XORG_LIB_XFONT		:= libXfont-$(HOST_XORG_LIB_XFONT_VERSION)
HOST_XORG_LIB_XFONT_SUFFIX	:= tar.bz2
HOST_XORG_LIB_XFONT_URL		:= $(call ptx/mirror, XORG, individual/lib/$(HOST_XORG_LIB_XFONT).$(HOST_XORG_LIB_XFONT_SUFFIX))
HOST_XORG_LIB_XFONT_SOURCE	:= $(SRCDIR)/$(HOST_XORG_LIB_XFONT).$(HOST_XORG_LIB_XFONT_SUFFIX)
HOST_XORG_LIB_XFONT_DIR		:= $(HOST_BUILDDIR)/$(HOST_XORG_LIB_XFONT)
HOST_XORG_LIB_XFONT_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

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
