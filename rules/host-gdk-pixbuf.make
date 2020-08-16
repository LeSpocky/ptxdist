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
	-Dgir=false \
	-Dinstalled_tests=false \
	-Djasper=false \
	-Djpeg=false \
	-Dman=false \
	-Dnative_windows_loaders=false \
	-Dpng=true \
	-Drelocatable=false \
	-Dtiff=false \
	-Dx11=false

# vim: syntax=make
