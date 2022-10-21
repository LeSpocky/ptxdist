# -*-makefile-*-
#
# Copyright (C) 2009 by Erwin Rol
#               2010, 2013 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBGCRYPT) += libgcrypt

#
# Paths and names
#
LIBGCRYPT_VERSION	:= 1.10.1
LIBGCRYPT_MD5		:= 8fadbe1fddafa341dce5ef3869f70e25
LIBGCRYPT		:= libgcrypt-$(LIBGCRYPT_VERSION)
LIBGCRYPT_SUFFIX	:= tar.bz2
LIBGCRYPT_URL		:= https://www.gnupg.org/ftp/gcrypt/libgcrypt/$(LIBGCRYPT).$(LIBGCRYPT_SUFFIX)
LIBGCRYPT_SOURCE	:= $(SRCDIR)/$(LIBGCRYPT).$(LIBGCRYPT_SUFFIX)
LIBGCRYPT_DIR		:= $(BUILDDIR)/$(LIBGCRYPT)
LIBGCRYPT_LICENSE	:= GPL-2.0-only AND LGPL-2.0-only
LIBGCRYPT_LICENSE_FILES	:= \
	file://COPYING;md5=94d55d512a9ba36caa9b7df079bae19f \
	file://COPYING.LIB;md5=bbb461211a33b134d42ed5ee802b37ff

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBGCRYPT_ASM := y
ifneq ($(PTXCONF_ARCH_M68K)$(PTXCONF_ARCH_PPC),)
LIBGCRYPT_ASM :=
endif

LIBGCRYPT_CONF_ENV := \
	$(CROSS_ENV) \
	ac_cv_path_GPGRT_CONFIG=$(PTXDIST_SYSROOT_CROSS)/bin/gpgrt-config

ifdef PTXCONF_ARCH_X86
LIBGCRYPT_CONF_ENV += ac_cv_sys_symbol_underscore=no
endif

#
# autoconf
#
LIBGCRYPT_CONF_TOOL := autoconf
LIBGCRYPT_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--disable-static \
	--enable-shared \
	--enable-endian-check \
	--enable-random=linux \
	--enable-dev-random \
	--disable-random-daemon \
	--$(call ptx/endis,LIBGCRYPT_ASM)-asm \
	--disable-m-guard \
	--disable-large-data-tests \
	--disable-force-soft-hwfeatures \
	--disable-hmac-binary-check \
	--enable-jent-support \
	--enable-padlock-support \
	--enable-aesni-support \
	--disable-shaext-support \
	--enable-pclmul-support \
	--enable-sse41-support \
	--enable-drng-support \
	--enable-avx-support \
	--enable-avx2-support \
	--$(call ptx/endis,PTXCONF_ARCH_ARM_NEON)-neon-support \
	--enable-arm-crypto-support \
	--disable-ppc-crypto-support \
	--enable-O-flag-munging \
	--disable-instrumentation-munging \
	--disable-amd64-as-feature-detection \
	--enable-optimization \
	--enable-noexecstack \
	--disable-doc \
	--enable-build-timestamp="$(PTXDIST_BUILD_TIMESTAMP)" \
	--without-capabilities

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libgcrypt.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libgcrypt)
	@$(call install_fixup, libgcrypt,PRIORITY,optional)
	@$(call install_fixup, libgcrypt,SECTION,base)
	@$(call install_fixup, libgcrypt,AUTHOR,"Erwin Rol")
	@$(call install_fixup, libgcrypt,DESCRIPTION,missing)

	@$(call install_lib, libgcrypt, 0, 0, 0644, libgcrypt)

	@$(call install_finish, libgcrypt)

	@$(call touch)

# vim: syntax=make
