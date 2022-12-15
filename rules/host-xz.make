# -*-makefile-*-
#
# Copyright (C) 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_XZ) += host-xz

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_XZ_CONF_TOOL	:= autoconf
HOST_XZ_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--disable-debug \
	--disable-external-sha256 \
	--disable-microlzma \
	--disable-lzip-decoder \
	--enable-assembler \
	--enable-clmul-crc \
	--disable-small \
	--enable-threads \
	--enable-xz \
	--disable-xzdec \
	--disable-lzmadec \
	--disable-lzmainfo \
	--disable-lzma-links \
	--disable-scripts \
	--disable-doc \
	--disable-sandbox \
	--enable-shared \
	--disable-static \
	--enable-symbol-versions \
	--disable-nls \
	--enable-rpath \
	--enable-unaligned-access=auto \
	--disable-unsafe-type-punning \
	--disable-werror

# vim: syntax=make
