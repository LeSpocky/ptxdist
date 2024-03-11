# -*-makefile-*-
#
# Copyright (C) 2024 by Markus Heidelberg <m.heidelberg@cab.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_NETTLE) += host-nettle

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_NETTLE_CONF_TOOL	:= autoconf
HOST_NETTLE_CONF_OPT	:=  \
	$(HOST_AUTOCONF) \
	--enable-public-key \
	--enable-assembler \
	--disable-static \
	--enable-shared \
	--disable-openssl \
	--disable-gcov \
	--disable-documentation \
	--disable-fat \
	--disable-arm-neon \
	--disable-arm64-crypto \
	--disable-x86-aesni \
	--disable-x86-sha-ni \
	--disable-x86-pclmul \
	--disable-power-crypto-ext \
	--disable-power-altivec \
	--disable-s390x-vf \
	--disable-s390x-msa \
	--enable-mini-gmp \
	--without-include-path \
	--without-lib-path

# vim: syntax=make
