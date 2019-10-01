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
PACKAGES-$(PTXCONF_XORG_LIB_XRENDER) += xorg-lib-xrender

#
# Paths and names
#
XORG_LIB_XRENDER_VERSION	:= 0.9.10
XORG_LIB_XRENDER_MD5		:= 802179a76bded0b658f4e9ec5e1830a4
XORG_LIB_XRENDER		:= libXrender-$(XORG_LIB_XRENDER_VERSION)
XORG_LIB_XRENDER_SUFFIX		:= tar.bz2
XORG_LIB_XRENDER_URL		:= $(call ptx/mirror, XORG, individual/lib/$(XORG_LIB_XRENDER).$(XORG_LIB_XRENDER_SUFFIX))
XORG_LIB_XRENDER_SOURCE		:= $(SRCDIR)/$(XORG_LIB_XRENDER).$(XORG_LIB_XRENDER_SUFFIX)
XORG_LIB_XRENDER_DIR		:= $(BUILDDIR)/$(XORG_LIB_XRENDER)
XORG_LIB_XRENDER_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_LIB_XRENDER_CONF_TOOL	:= autoconf
XORG_LIB_XRENDER_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-malloc0returnsnull

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-xrender.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-xrender)
	@$(call install_fixup, xorg-lib-xrender,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xrender,SECTION,base)
	@$(call install_fixup, xorg-lib-xrender,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xrender,DESCRIPTION,missing)

	@$(call install_lib, xorg-lib-xrender, 0, 0, 0644, libXrender)

	@$(call install_finish, xorg-lib-xrender)

	@$(call touch)

# vim: syntax=make
