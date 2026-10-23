# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_LIB_XXF86VM) += xorg-lib-xxf86vm

#
# Paths and names
#
XORG_LIB_XXF86VM_VERSION	:= 1.1.7
XORG_LIB_XXF86VM_SHA256		:= ae50c0f669e0af5a67cc4cd0f54f21d64a64d2660af883e80e95d3fe51b945d8
XORG_LIB_XXF86VM		:= libXxf86vm-$(XORG_LIB_XXF86VM_VERSION)
XORG_LIB_XXF86VM_SUFFIX		:= tar.xz
XORG_LIB_XXF86VM_URL		:= $(call ptx/mirror, XORG, individual/lib/$(XORG_LIB_XXF86VM).$(XORG_LIB_XXF86VM_SUFFIX))
XORG_LIB_XXF86VM_SOURCE		:= $(SRCDIR)/$(XORG_LIB_XXF86VM).$(XORG_LIB_XXF86VM_SUFFIX)
XORG_LIB_XXF86VM_DIR		:= $(BUILDDIR)/$(XORG_LIB_XXF86VM)
XORG_LIB_XXF86VM_LICENSE	:= X11
XORG_LIB_XXF86VM_LICENSE_FILES	:= \
	file://COPYING;md5=fa0b9c462d8f2f13eba26492d42ea63d

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_LIB_XXF86VM_CONF_TOOL	:= autoconf
XORG_LIB_XXF86VM_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-malloc0returnsnull

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-xxf86vm.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-xxf86vm)
	@$(call install_fixup, xorg-lib-xxf86vm,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xxf86vm,SECTION,base)
	@$(call install_fixup, xorg-lib-xxf86vm,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xxf86vm,DESCRIPTION,missing)

	@$(call install_lib, xorg-lib-xxf86vm, 0, 0, 0644, libXxf86vm)

	@$(call install_finish, xorg-lib-xxf86vm)

	@$(call touch)

# vim: syntax=make
