# -*-makefile-*-
#
# Copyright (C) 2014 by Alexander Aring <aar@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBZMQ) += libzmq

#
# Paths and names
#
LIBZMQ_VERSION		:= 4.3.4
LIBZMQ_MD5		:= c897d4005a3f0b8276b00b7921412379
LIBZMQ			:= zeromq-$(LIBZMQ_VERSION)
LIBZMQ_SUFFIX		:= tar.gz
LIBZMQ_URL		:= https://github.com/zeromq/libzmq/releases/download/v$(LIBZMQ_VERSION)/$(LIBZMQ).$(LIBZMQ_SUFFIX)
LIBZMQ_SOURCE		:= $(SRCDIR)/$(LIBZMQ).$(LIBZMQ_SUFFIX)
LIBZMQ_DIR		:= $(BUILDDIR)/$(LIBZMQ)
LIBZMQ_LICENSE		:= LGPL-3.0-or-later WITH custom-exception
LIBZMQ_LICENSE_FILES	:= \
	file://COPYING;md5=f7b40df666d41e6508d03e1c207d498f \
	file://COPYING.LESSER;md5=d5311495d952062e0e4fbba39cbf3de1

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBZMQ_CONF_ENV		:= \
	$(CROSS_ENV) \
	ac_cv_lib_sodium_sodium_init=no

#
# autoconf
#
LIBZMQ_CONF_TOOL	:= autoconf
LIBZMQ_CONF_OPT		:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-code-coverage \
	--disable-static \
	--enable-shared \
	--disable-valgrind \
	--enable-symvers \
	--disable-force-CXX98-compat \
	--disable-debug \
	--disable-pedantic \
	--disable-thread-sanitizer \
	--disable-address-sanitizer \
	--disable-Werror \
	--enable-eventfd \
	--disable-perf \
	--enable-curve-keygen \
	--enable-curve \
	--disable-ws \
	--disable-libbsd \
	--disable-drafts \
	--disable-libunwind \
	--without-gcov \
	--with-gnu-ld \
	--without-militant \
	--without-docs \
	--with-poller=epoll \
	--without-libgssapi_krb5 \
	--with-libsodium \
	--without-nss \
	--without-tls \
	--without-pgm \
	--without-norm \
	--without-vmci \
	--without-fuzzing-engine

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libzmq.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libzmq)
	@$(call install_fixup, libzmq,PRIORITY,optional)
	@$(call install_fixup, libzmq,SECTION,base)
	@$(call install_fixup, libzmq,AUTHOR,"Alexander Aring <aar@pengutronix.de>")
	@$(call install_fixup, libzmq,DESCRIPTION,missing)

	@$(call install_lib, libzmq, 0, 0, 0644, libzmq)
	@$(call install_copy, libzmq, 0, 0, 0755, -, /usr/bin/curve_keygen)

	@$(call install_finish, libzmq)

	@$(call touch)

# vim: syntax=make
