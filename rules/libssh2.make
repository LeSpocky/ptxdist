# -*-makefile-*-
#
# Copyright (C) 2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBSSH2) += libssh2

#
# Paths and names
#
LIBSSH2_VERSION		:= 1.11.1
LIBSSH2_MD5		:= 38857d10b5c5deb198d6989dacace2e6
LIBSSH2			:= libssh2-$(LIBSSH2_VERSION)
LIBSSH2_SUFFIX		:= tar.gz
LIBSSH2_URL		:= http://www.libssh2.org/download/$(LIBSSH2).$(LIBSSH2_SUFFIX)
LIBSSH2_SOURCE		:= $(SRCDIR)/$(LIBSSH2).$(LIBSSH2_SUFFIX)
LIBSSH2_DIR		:= $(BUILDDIR)/$(LIBSSH2)
LIBSSH2_LICENSE		:= BSD-3-Clause AND MIT AND SAX-PD-2.0 AND BSD-2-Clause
LIBSSH2_LICENSE_FILES	:= \
	file://COPYING;md5=2fbf8f834408079bf1fcbadb9814b1bc \
	file://src/bcrypt_pbkdf.c;startline=2;endline=18;md5=d933fb4467b5e52106ccde6cebbf1262 \
	file://src/chacha.c;startline=1;endline=8;md5=18f01378620a2564f9273b395eddba70 \
	file://src/cipher-chachapoly.c;startline=1;endline=19;md5=ec5627e087ba4bbb68eed1151979a238

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBSSH2_CONF_TOOL := autoconf
LIBSSH2_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-rpath \
	--disable-ecdsa-wincng \
	--disable-clear-memory \
	--disable-werror \
	--enable-debug \
	--enable-hidden-symbols \
	--disable-deprecated \
	--disable-docker-tests \
	--disable-sshd-tests \
	--enable-examples-build \
	--disable-ossfuzzers \
	--$(call ptx/endis, PTXDIST_Y2038)-year2038 \
	--with-crypto=openssl \
	--with-libssl-prefix=$(SYSROOT)/usr \
	--with-libz \
	--with-libz-prefix=$(SYSROOT)/usr

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libssh2.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libssh2)
	@$(call install_fixup, libssh2,PRIORITY,optional)
	@$(call install_fixup, libssh2,SECTION,base)
	@$(call install_fixup, libssh2,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, libssh2,DESCRIPTION,missing)

	@$(call install_lib, libssh2, 0, 0, 0644, libssh2)

	@$(call install_finish, libssh2)

	@$(call touch)

# vim: syntax=make
