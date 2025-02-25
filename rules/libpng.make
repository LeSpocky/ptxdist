# -*-makefile-*-
#
# Copyright (C) 2003 by Robert Schwebel <r.schwebel@pengutronix.de>
#                       Pengutronix <info@pengutronix.de>, Germany
#               2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBPNG) += libpng

#
# Paths and names
#
LIBPNG_VERSION	:= 1.6.47
LIBPNG_MD5	:= 9bfcaa394869ff2d8eaad32e03303636
LIBPNG		:= libpng-$(LIBPNG_VERSION)
LIBPNG_SUFFIX	:= tar.xz
LIBPNG_URL	:= $(call ptx/mirror, SF, libpng/$(LIBPNG).$(LIBPNG_SUFFIX))
LIBPNG_SOURCE	:= $(SRCDIR)/$(LIBPNG).$(LIBPNG_SUFFIX)
LIBPNG_DIR	:= $(BUILDDIR)/$(LIBPNG)
LIBPNG_LICENSE	:= libpng-2.0
LIBPNG_LICENSE_FILES := \
	file://LICENSE;md5=5516d77a3cf75f55a0d37254e3e65a20

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBPNG_WRAPPER_BLACKLIST := TARGET_DEBUG_FULL

LIBPNG_CONF_TOOL:= autoconf
LIBPNG_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--disable-tests \
	--disable-tools \
	--enable-unversioned-links \
	--enable-unversioned-libpng-pc \
	--enable-unversioned-libpng-config \
	--disable-mips-msa \
	--disable-mips-mmi \
	--$(call ptx/endis, PTXCONF_ARCH_X86)-intel-sse \
	--disable-powerpc-vsx \
	--disable-loongarch-lsx \
	--with-binconfigs

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libpng.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libpng)
	@$(call install_fixup, libpng,PRIORITY,optional)
	@$(call install_fixup, libpng,SECTION,base)
	@$(call install_fixup, libpng,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libpng,DESCRIPTION,missing)

	@$(call install_lib, libpng, 0, 0, 0644, libpng16)

	@$(call install_finish, libpng)

	@$(call touch)

# vim: syntax=make
