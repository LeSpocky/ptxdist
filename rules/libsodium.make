# -*-makefile-*-
#
# Copyright (C) 2016 by Clemens Gruber <clemens.gruber@pqgruber.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBSODIUM) += libsodium

#
# Paths and names
#
LIBSODIUM_VERSION	:= 1.0.20
LIBSODIUM_MD5		:= 597f2c7811f84e63e45e2277dfb5da46
LIBSODIUM		:= libsodium-$(LIBSODIUM_VERSION)
LIBSODIUM_SUFFIX	:= tar.gz
LIBSODIUM_URL		:= https://download.libsodium.org/libsodium/releases/$(LIBSODIUM).$(LIBSODIUM_SUFFIX)
LIBSODIUM_SOURCE	:= $(SRCDIR)/$(LIBSODIUM).$(LIBSODIUM_SUFFIX)
LIBSODIUM_DIR		:= $(BUILDDIR)/$(LIBSODIUM)
LIBSODIUM_LICENSE	:= ISC
LIBSODIUM_LICENSE_FILES	:= file://LICENSE;md5=c59be7bb29f8e431b5f2d690b6734185

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBSODIUM_CONF_TOOL	:= autoconf
LIBSODIUM_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--enable-ssp \
	--$(call ptx/endis, PTXCONF_ARCH_X86)-asm \
	--enable-pie \
	--disable-blocking-random \
	--disable-minimal \
	--disable-debug \
	--disable-opt \
	--disable-valgrind \
	--disable-valgrind-memcheck \
	--disable-valgrind-helgrind \
	--disable-valgrind-drd \
	--disable-valgrind-sgcheck \
	--enable-soname-versions \
	--disable-static \
	--with-pthreads \
	--without-safecode \
	--without-ctgrind

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libsodium.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libsodium)
	@$(call install_fixup, libsodium, PRIORITY, optional)
	@$(call install_fixup, libsodium, SECTION, base)
	@$(call install_fixup, libsodium, AUTHOR, "Clemens Gruber <clemens.gruber@pqgruber.com>")
	@$(call install_fixup, libsodium, DESCRIPTION, "The sodium crypto library")

	@$(call install_lib, libsodium, 0, 0, 0644, libsodium)

	@$(call install_finish, libsodium)

	@$(call touch)

# vim: syntax=make
