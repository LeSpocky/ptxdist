# -*-makefile-*-
#
# Copyright (C) 2018 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_CAIRO) += host-cairo

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# meson
#
HOST_CAIRO_CONF_TOOL	:= meson
HOST_CAIRO_CONF_OPT	:= \
	$(HOST_MESON_OPT) \
	-Ddwrite=disabled \
	-Dfontconfig=enabled \
	-Dfreetype=enabled \
	-Dglib=disabled \
	-Dgtk2-utils=disabled \
	-Dgtk_doc=false \
	-Dpng=disabled \
	-Dquartz=disabled \
	-Dspectre=disabled \
	-Dsymbol-lookup=disabled \
	-Dtee=disabled \
	-Dtests=disabled \
	-Dxcb=disabled \
	-Dxlib=disabled \
	-Dxlib-xcb=disabled \
	-Dzlib=disabled

# vim: syntax=make
