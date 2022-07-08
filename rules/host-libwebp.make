# -*-makefile-*-
#
# Copyright (C) 2022 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_LIBWEBP) += host-libwebp

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_LIBWEBP_CONF_TOOL	:= autoconf
HOST_LIBWEBP_CONF_OPT	:=  \
	$(HOST_AUTOCONF) \
	--disable-asserts \
	--enable-threading \
	--disable-gl \
	--disable-sdl \
	--disable-png \
	--disable-jpeg \
	--disable-tiff \
	--disable-gif \
	--disable-wic \
	--enable-swap-16bit-csp \
	--enable-near-lossless \
	--enable-libwebpmux \
	--enable-libwebpdemux \
	--enable-libwebpdecoder \
	--disable-libwebpextras

# vim: syntax=make
