# -*-makefile-*-
#
# Copyright (C) 2016 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_PIXMAN) += host-pixman

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_PIXMAN_CONF_TOOL	:= meson
HOST_PIXMAN_CONF_OPT	:= \
	$(HOST_MESON_OPT) \
	-Da64-neon=disabled \
	-Darm-simd=disabled \
	-Dcpu-features-path= \
	-Ddemos=disabled \
	-Dgnu-inline-asm=disabled \
	-Dgnuplot=false \
	-Dgtk=disabled \
	-Dlibpng=disabled \
	-Dloongson-mmi=disabled \
	-Dmips-dspr2=disabled \
	-Dmmx=disabled \
	-Dneon=disabled \
	-Dopenmp=disabled \
	-Dsse2=enabled \
	-Dssse3=disabled \
	-Dtests=disabled \
	-Dtimers=false \
	-Dvmx=disabled

# vim: syntax=make
