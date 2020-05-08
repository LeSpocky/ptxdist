# -*-makefile-*-
#
# Copyright (C) 2019 by Bastian Krause <bst@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_CRYPTSETUP) += host-cryptsetup

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_CRYPTSETUP_CONF_TOOL	:= autoconf
HOST_CRYPTSETUP_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--disable-rpath \
	--disable-keyring \
	--disable-nls \
	--disable-fips \
	--disable-pwquality \
	--disable-static-cryptsetup \
	--disable-cryptsetup \
	--enable-veritysetup \
	--disable-cryptsetup-reencrypt \
	--disable-integritysetup \
	--disable-selinux \
	--disable-udev \
	--disable-kernel_crypto \
	--disable-gcrypt-pbkdf2 \
	--enable-internal-argon2 \
	--disable-libargon2 \
	--disable-internal-sse-argon2 \
	--enable-blkid \
	--enable-dev-random \
	--enable-luks-adjust-xts-keysize \
	--with-crypto_backend=openssl

# vim: syntax=make
