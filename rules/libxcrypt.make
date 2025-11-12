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
LIBXCRYPT_VERSION	:= 4.5.2
LIBXCRYPT_MD5		:= 25e888919ddcd153a07daa95224fa436
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
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-werror \
	--disable-static \
	--disable-symvers \
	--disable-valgrind \
	--disable-valgrind-memcheck \
	--enable-valgrind-helgrind \
	--disable-valgrind-drd \
	--disable-valgrind-sgcheck \
	--disable-failure-tokens \
	--enable-xcrypt-compat-files \
	--enable-obsolete-api \
	--enable-obsolete-api-enosys=$(call ptx/ifdef,PTXCONF_LIBXCRYPT_OBSOLETE_STUBS,yes,no) \
	--enable-hashes=$(HASH_METHODS) \
	--$(call ptx/endis, PTXDIST_Y2038)-year2038

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
