# -*-makefile-*-
#
# Copyright (C) 2020 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_GDK_PIXBUF) += host-gdk-pixbuf

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# meson
#
HOST_GDK_PIXBUF_CONF_TOOL	:= meson
HOST_GDK_PIXBUF_CONF_OPT	:=  \
	$(HOST_MESON_OPT) \
	-Dbuiltin_loaders=png \
	-Ddocs=false \
	-Dgio_sniffing=false \
	-Dgtk_doc=false \
	-Dinstalled_tests=false \
	-Dintrospection=disabled \
	-Djpeg=disabled \
	-Dman=false \
	-Dnative_windows_loaders=false \
	-Dpng=enabled \
	-Drelocatable=false \
	-Dtests=false \
	-Dtiff=disabled

# vim: syntax=make
