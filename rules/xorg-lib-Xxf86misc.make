# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
#               2010 Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_LIB_XXF86MISC) += xorg-lib-xxf86misc

#
# Paths and names
#
XORG_LIB_XXF86MISC_VERSION	:= 1.0.4
XORG_LIB_XXF86MISC_MD5		:= 37ad70f8b53b94b550f9290be97fbe2d
XORG_LIB_XXF86MISC		:= libXxf86misc-$(XORG_LIB_XXF86MISC_VERSION)
XORG_LIB_XXF86MISC_SUFFIX	:= tar.bz2
XORG_LIB_XXF86MISC_URL		:= $(call ptx/mirror, XORG, individual/lib/$(XORG_LIB_XXF86MISC).$(XORG_LIB_XXF86MISC_SUFFIX))
XORG_LIB_XXF86MISC_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XXF86MISC).$(XORG_LIB_XXF86MISC_SUFFIX)
XORG_LIB_XXF86MISC_DIR		:= $(BUILDDIR)/$(XORG_LIB_XXF86MISC)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_LIB_XXF86MISC_PATH	:= PATH=$(CROSS_PATH)
XORG_LIB_XXF86MISC_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XXF86MISC_AUTOCONF := $(CROSS_AUTOCONF_USR)

XORG_LIB_XXF86MISC_AUTOCONF += --disable-malloc0returnsnull

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-xxf86misc.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-xxf86misc)
	@$(call install_fixup, xorg-lib-xxf86misc,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xxf86misc,SECTION,base)
	@$(call install_fixup, xorg-lib-xxf86misc,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xxf86misc,DESCRIPTION,missing)

	@$(call install_lib, xorg-lib-xxf86misc, 0, 0, 0644, libXxf86misc)

	@$(call install_finish, xorg-lib-xxf86misc)

	@$(call touch)

# vim: syntax=make
