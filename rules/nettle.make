# -*-makefile-*-
#
# Copyright (C) 2012 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_NETTLE) += nettle

#
# Paths and names
#
NETTLE_VERSION	:= 3.6
NETTLE_MD5	:= c45ee24ed7361dcda152a035d396fe8a
NETTLE		:= nettle-$(NETTLE_VERSION)
NETTLE_SUFFIX	:= tar.gz
NETTLE_SOURCE	:= $(SRCDIR)/$(NETTLE).$(NETTLE_SUFFIX)
NETTLE_DIR	:= $(BUILDDIR)/$(NETTLE)
NETTLE_LICENSE	:= GPL-2.0-or-later

NETTLE_URL	:= \
	http://www.lysator.liu.se/~nisse/archive/$(NETTLE).$(NETTLE_SUFFIX) \
	$(call ptx/mirror, GNU, nettle/$(NETTLE).$(NETTLE_SUFFIX))

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
NETTLE_CONF_TOOL	:= autoconf
NETTLE_CONF_OPT		:= \
	$(CROSS_AUTOCONF_USR) \
	--enable-public-key \
	--enable-assembler \
	--disable-static \
	--enable-shared \
	--disable-openssl \
	--disable-gcov \
	--disable-documentation \
	--disable-fat \
	--$(call ptx/endis,PTXCONF_ARCH_ARM_NEON)-arm-neon \
	--disable-x86-aesni \
	--$(call ptx/disen,PTXCONF_NETTLE_GMP)-mini-gmp

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/nettle.targetinstall:
	@$(call targetinfo)

	@$(call install_init, nettle)
	@$(call install_fixup, nettle,PRIORITY,optional)
	@$(call install_fixup, nettle,SECTION,base)
	@$(call install_fixup, nettle,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, nettle,DESCRIPTION,missing)

	@$(call install_lib, nettle, 0, 0, 0644, libnettle)
	@$(call install_lib, nettle, 0, 0, 0644, libhogweed)
	@$(call install_copy, nettle, 0, 0, 0755, -, /usr/bin/nettle-hash)
	@$(call install_copy, nettle, 0, 0, 0755, -, /usr/bin/sexp-conv)
	@$(call install_copy, nettle, 0, 0, 0755, -, /usr/bin/nettle-lfib-stream)

	@$(call install_finish, nettle)

	@$(call touch)

# vim: syntax=make
