# -*-makefile-*-
#
# Copyright (C) 2019 by Bjoern Esser <bes@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBXCRYPT) += libxcrypt

#
# Paths and names
#
LIBXCRYPT_VERSION	:= 4.4.36
LIBXCRYPT_MD5		:= b84cd4104e08c975063ec6c4d0372446
LIBXCRYPT		:= libxcrypt-$(LIBXCRYPT_VERSION)
LIBXCRYPT_SUFFIX	:= tar.xz
LIBXCRYPT_URL		:= https://github.com/besser82/libxcrypt/releases/download/v$(LIBXCRYPT_VERSION)/$(LIBXCRYPT).$(LIBXCRYPT_SUFFIX)
LIBXCRYPT_SOURCE	:= $(SRCDIR)/$(LIBXCRYPT).$(LIBXCRYPT_SUFFIX)
LIBXCRYPT_DIR		:= $(BUILDDIR)/$(LIBXCRYPT)
LIBXCRYPT_LICENSE	:= LGPL-2.1-or-later AND BSD-3-Clause AND BSD-2-Clause AND 0BSD AND public_domain
LIBXCRYPT_LICENSE_MD5	:= file://LICENSING;md5=3bb6614cf5880cbf1b9dbd9e3d145e2c

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# options
#

# Hash methods enabled by default.
HASH_METHODS := glibc,strong

#
# autoconf
#
LIBXCRYPT_CONF_TOOL	:= autoconf
LIBXCRYPT_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-failure-tokens \
	--disable-static \
	--disable-valgrind \
	--enable-obsolete-api \
	--enable-obsolete-api-enosys=$(call ptx/ifdef,PTXCONF_LIBXCRYPT_OBSOLETE_STUBS,yes,no) \
	--enable-hashes=$(HASH_METHODS) \
	--enable-xcrypt-compat-files

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libxcrypt.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libxcrypt)
	@$(call install_fixup, libxcrypt,PRIORITY,optional)
	@$(call install_fixup, libxcrypt,SECTION,base)
	@$(call install_fixup, libxcrypt,AUTHOR,"Bjoern Esser <bes@pengutronix.de>")
	@$(call install_fixup, libxcrypt,DESCRIPTION,Extended crypt library)

	@$(call install_lib, libxcrypt, 0, 0, 0644, libcrypt)

	@$(call install_finish, libxcrypt)

	@$(call touch)

# vim: syntax=make
