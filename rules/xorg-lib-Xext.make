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
PACKAGES-$(PTXCONF_XORG_LIB_XEXT) += xorg-lib-xext

#
# Paths and names
#
XORG_LIB_XEXT_VERSION	:= 1.3.4
XORG_LIB_XEXT_MD5	:= f5b48bb76ba327cd2a8dc7a383532a95
XORG_LIB_XEXT		:= libXext-$(XORG_LIB_XEXT_VERSION)
XORG_LIB_XEXT_SUFFIX	:= tar.bz2
XORG_LIB_XEXT_URL	:= $(call ptx/mirror, XORG, individual/lib/$(XORG_LIB_XEXT).$(XORG_LIB_XEXT_SUFFIX))
XORG_LIB_XEXT_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XEXT).$(XORG_LIB_XEXT_SUFFIX)
XORG_LIB_XEXT_DIR	:= $(BUILDDIR)/$(XORG_LIB_XEXT)
XORG_LIB_XEXT_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_LIB_XEXT_CONF_TOOL	:= autoconf
XORG_LIB_XEXT_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-specs \
	--disable-malloc0returnsnull \
	$(XORG_OPTIONS_DOCS)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-xext.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-xext)
	@$(call install_fixup, xorg-lib-xext,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xext,SECTION,base)
	@$(call install_fixup, xorg-lib-xext,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xext,DESCRIPTION,missing)

	@$(call install_lib, xorg-lib-xext, 0, 0, 0644, libXext)

	@$(call install_finish, xorg-lib-xext)

	@$(call touch)

# vim: syntax=make
