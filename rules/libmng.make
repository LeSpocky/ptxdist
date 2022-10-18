# -*-makefile-*-
#
# Copyright (C) 2009 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBMNG) += libmng

#
# Paths and names
#
LIBMNG_VERSION	:= 1.0.10
LIBMNG_MD5	:= eaf1476a3bb29f6190bca660e6abef16
LIBMNG		:= libmng-$(LIBMNG_VERSION)
LIBMNG_SUFFIX	:= tar.bz2
LIBMNG_URL	:= $(call ptx/mirror, SF, libmng/$(LIBMNG).$(LIBMNG_SUFFIX))
LIBMNG_SOURCE	:= $(SRCDIR)/$(LIBMNG).$(LIBMNG_SUFFIX)
LIBMNG_DIR	:= $(BUILDDIR)/$(LIBMNG)
LIBMNG_LICENSE	:= custom
LIBMNG_LICENSE_FILES	:= file://LICENSE;md5=32becdb8930f90eab219a8021130ec09

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBMNG_CONF_TOOL := autoconf
LIBMNG_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--with-jpeg \
	--$(call ptx/wwo, PTXCONF_LIBMNG_LCMS)-lcms

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libmng.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libmng)
	@$(call install_fixup, libmng,PRIORITY,optional)
	@$(call install_fixup, libmng,SECTION,base)
	@$(call install_fixup, libmng,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, libmng,DESCRIPTION,missing)

	@$(call install_lib, libmng, 0, 0, 0644, libmng)

	@$(call install_finish, libmng)

	@$(call touch)

# vim: syntax=make
