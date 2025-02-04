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
LIBSSH2_VERSION	:= 1.11.1
LIBSSH2_MD5	:= 38857d10b5c5deb198d6989dacace2e6
LIBSSH2		:= libssh2-$(LIBSSH2_VERSION)
LIBSSH2_SUFFIX	:= tar.gz
LIBSSH2_URL	:= http://www.libssh2.org/download/$(LIBSSH2).$(LIBSSH2_SUFFIX)
LIBSSH2_SOURCE	:= $(SRCDIR)/$(LIBSSH2).$(LIBSSH2_SUFFIX)
LIBSSH2_DIR	:= $(BUILDDIR)/$(LIBSSH2)

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
