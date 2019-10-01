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
XORG_LIB_XXF86VM_VERSION	:= 1.1.4
XORG_LIB_XXF86VM_MD5		:= 298b8fff82df17304dfdb5fe4066fe3a
XORG_LIB_XXF86VM		:= libXxf86vm-$(XORG_LIB_XXF86VM_VERSION)
XORG_LIB_XXF86VM_SUFFIX		:= tar.bz2
XORG_LIB_XXF86VM_URL		:= $(call ptx/mirror, XORG, individual/lib/$(XORG_LIB_XXF86VM).$(XORG_LIB_XXF86VM_SUFFIX))
XORG_LIB_XXF86VM_SOURCE		:= $(SRCDIR)/$(XORG_LIB_XXF86VM).$(XORG_LIB_XXF86VM_SUFFIX)
XORG_LIB_XXF86VM_DIR		:= $(BUILDDIR)/$(XORG_LIB_XXF86VM)
XORG_LIB_XXF86VM_LICENSE	:= MIT

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
