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
PACKAGES-$(PTXCONF_XORG_LIB_XRES) += xorg-lib-xres

#
# Paths and names
#
XORG_LIB_XRES_VERSION	:= 1.2.0
XORG_LIB_XRES_MD5	:= 5d6d443d1abc8e1f6fc1c57fb27729bb
XORG_LIB_XRES		:= libXres-$(XORG_LIB_XRES_VERSION)
XORG_LIB_XRES_SUFFIX	:= tar.bz2
XORG_LIB_XRES_URL	:= $(call ptx/mirror, XORG, individual/lib/$(XORG_LIB_XRES).$(XORG_LIB_XRES_SUFFIX))
XORG_LIB_XRES_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XRES).$(XORG_LIB_XRES_SUFFIX)
XORG_LIB_XRES_DIR	:= $(BUILDDIR)/$(XORG_LIB_XRES)
XORG_LIB_XRES_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_LIB_XRES_CONF_TOOL	:= autoconf
XORG_LIB_XRES_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-malloc0returnsnull

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-xres.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-xres)
	@$(call install_fixup, xorg-lib-xres,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xres,SECTION,base)
	@$(call install_fixup, xorg-lib-xres,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xres,DESCRIPTION,missing)

	@$(call install_lib, xorg-lib-xres, 0, 0, 0644, libXRes)

	@$(call install_finish, xorg-lib-xres)

	@$(call touch)

# vim: syntax=make
