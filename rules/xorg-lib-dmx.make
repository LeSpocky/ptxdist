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
PACKAGES-$(PTXCONF_XORG_LIB_DMX) += xorg-lib-dmx

#
# Paths and names
#
XORG_LIB_DMX_VERSION	:= 1.1.4
XORG_LIB_DMX_MD5	:= d2f1f0ec68ac3932dd7f1d9aa0a7a11c
XORG_LIB_DMX		:= libdmx-$(XORG_LIB_DMX_VERSION)
XORG_LIB_DMX_SUFFIX	:= tar.bz2
XORG_LIB_DMX_URL	:= $(call ptx/mirror, XORG, individual/lib//$(XORG_LIB_DMX).$(XORG_LIB_DMX_SUFFIX))
XORG_LIB_DMX_SOURCE	:= $(SRCDIR)/$(XORG_LIB_DMX).$(XORG_LIB_DMX_SUFFIX)
XORG_LIB_DMX_DIR	:= $(BUILDDIR)/$(XORG_LIB_DMX)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_LIB_DMX_CONF_TOOL	:= autoconf
XORG_LIB_DMX_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-malloc0returnsnull

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-dmx.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-dmx)
	@$(call install_fixup, xorg-lib-dmx,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-dmx,SECTION,base)
	@$(call install_fixup, xorg-lib-dmx,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-dmx,DESCRIPTION,missing)

	@$(call install_lib, xorg-lib-dmx, 0, 0, 0644, libdmx)

	@$(call install_finish, xorg-lib-dmx)

	@$(call touch)

# vim: syntax=make
