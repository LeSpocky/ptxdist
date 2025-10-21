# -*-makefile-*-
#
# Copyright (C) 2007 by Robert Schwebel
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_FONTCONFIG) += host-fontconfig

#
# Paths and names
#
HOST_FONTCONFIG_DIR	= $(HOST_BUILDDIR)/$(FONTCONFIG)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_FONTCONFIG_CONF_TOOL	:= meson
HOST_FONTCONFIG_CONF_OPT	:= \
	$(HOST_MESON_OPT) \
	-Dbaseconfig-dir=default \
	-Dbitmap-conf=no-except-emoji \
	-Dcache-build=disabled \
	-Dcache-dir=$(PTXDIST_SYSROOT_HOST)/var/cache/fontconfig \
	-Ddefault-hinting=slight \
	-Ddefault-fonts-dirs=[\'$(XORG_FONTDIR)\'] \
	-Ddefault-sub-pixel-rendering=none \
	-Ddoc=disabled \
	-Dfontations=disabled \
	-Diconv=disabled \
	-Dnls=disabled \
	-Dtests=disabled \
	-Dtools=enabled \
	-Dxml-backend=expat

# vim: syntax=make
