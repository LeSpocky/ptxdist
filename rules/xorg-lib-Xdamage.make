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
PACKAGES-$(PTXCONF_XORG_LIB_XDAMAGE) += xorg-lib-xdamage

#
# Paths and names
#
XORG_LIB_XDAMAGE_VERSION	:= 1.1.5
XORG_LIB_XDAMAGE_MD5		:= e3f554267a7a04b042dc1f6352bd6d99
XORG_LIB_XDAMAGE		:= libXdamage-$(XORG_LIB_XDAMAGE_VERSION)
XORG_LIB_XDAMAGE_SUFFIX		:= tar.bz2
XORG_LIB_XDAMAGE_URL		:= $(call ptx/mirror, XORG, individual/lib/$(XORG_LIB_XDAMAGE).$(XORG_LIB_XDAMAGE_SUFFIX))
XORG_LIB_XDAMAGE_SOURCE		:= $(SRCDIR)/$(XORG_LIB_XDAMAGE).$(XORG_LIB_XDAMAGE_SUFFIX)
XORG_LIB_XDAMAGE_DIR		:= $(BUILDDIR)/$(XORG_LIB_XDAMAGE)
XORG_LIB_XDAMAGE_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_LIB_XDAMAGE_CONF_TOOL := autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-xdamage.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-xdamage)
	@$(call install_fixup, xorg-lib-xdamage,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xdamage,SECTION,base)
	@$(call install_fixup, xorg-lib-xdamage,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xdamage,DESCRIPTION,missing)

	@$(call install_lib, xorg-lib-xdamage, 0, 0, 0644, libXdamage)

	@$(call install_finish, xorg-lib-xdamage)

	@$(call touch)

# vim: syntax=make
