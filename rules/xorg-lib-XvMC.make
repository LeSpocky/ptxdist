# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_LIB_XVMC) += xorg-lib-xvmc

#
# Paths and names
#
XORG_LIB_XVMC_VERSION	:= 1.0.11
XORG_LIB_XVMC_MD5	:= 707175185a2e0490b8173686c657324f
XORG_LIB_XVMC		:= libXvMC-$(XORG_LIB_XVMC_VERSION)
XORG_LIB_XVMC_SUFFIX	:= tar.bz2
XORG_LIB_XVMC_URL	:= $(call ptx/mirror, XORG, individual/lib/$(XORG_LIB_XVMC).$(XORG_LIB_XVMC_SUFFIX))
XORG_LIB_XVMC_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XVMC).$(XORG_LIB_XVMC_SUFFIX)
XORG_LIB_XVMC_DIR	:= $(BUILDDIR)/$(XORG_LIB_XVMC)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_LIB_XVMC_CONF_TOOL	:= autoconf
XORG_LIB_XVMC_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-malloc0returnsnull

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-xvmc.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-xvmc)
	@$(call install_fixup, xorg-lib-xvmc,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xvmc,SECTION,base)
	@$(call install_fixup, xorg-lib-xvmc,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xvmc,DESCRIPTION,missing)

	@$(call install_lib, xorg-lib-xvmc, 0, 0, 0644, libXvMC)
	@$(call install_lib, xorg-lib-xvmc, 0, 0, 0644, libXvMCW)

	@$(call install_finish, xorg-lib-xvmc)

	@$(call touch)

# vim: syntax=make
