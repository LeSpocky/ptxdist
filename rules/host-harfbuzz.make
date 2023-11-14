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
HOST_PACKAGES-$(PTXCONF_HOST_HARFBUZZ) += host-harfbuzz

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_HARFBUZZ_CONF_TOOL	:= autoconf
HOST_HARFBUZZ_CONF_OPT	:=  \
	$(HOST_AUTOCONF) \
	--disable-code-coverage \
	--disable-static \
	--disable-gtk-doc \
	--disable-gtk-doc-html \
	--disable-gtk-doc-pdf \
	--disable-introspection \
	--without-libstdc++ \
	--with-glib \
	--without-gobject \
	--without-cairo \
	--without-chafa \
	--$(call ptx/wwo, PTXCONF_HOST_HARFBUZZ_ICU)-icu \
	--$(call ptx/wwo, PTXCONF_HOST_HARFBUZZ_GRAPHITE)-graphite2 \
	--with-freetype \
	--without-uniscribe \
	--without-gdi \
	--without-directwrite \
	--without-coretext

# vim: syntax=make
