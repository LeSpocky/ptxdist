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
PACKAGES-$(PTXCONF_XORG_LIB_XRANDR) += xorg-lib-xrandr

#
# Paths and names
#
XORG_LIB_XRANDR_VERSION	:= 1.5.2
XORG_LIB_XRANDR_MD5	:= 18f3b20d522f45e4dadd34afb5bea048
XORG_LIB_XRANDR		:= libXrandr-$(XORG_LIB_XRANDR_VERSION)
XORG_LIB_XRANDR_SUFFIX	:= tar.bz2
XORG_LIB_XRANDR_URL	:= $(call ptx/mirror, XORG, individual/lib/$(XORG_LIB_XRANDR).$(XORG_LIB_XRANDR_SUFFIX))
XORG_LIB_XRANDR_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XRANDR).$(XORG_LIB_XRANDR_SUFFIX)
XORG_LIB_XRANDR_DIR	:= $(BUILDDIR)/$(XORG_LIB_XRANDR)
XORG_LIB_XRANDR_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_LIB_XRANDR_CONF_TOOL	:= autoconf
XORG_LIB_XRANDR_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-malloc0returnsnull

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-xrandr.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-xrandr)
	@$(call install_fixup, xorg-lib-xrandr,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xrandr,SECTION,base)
	@$(call install_fixup, xorg-lib-xrandr,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xrandr,DESCRIPTION,missing)

	@$(call install_lib, xorg-lib-xrandr, 0, 0, 0644, libXrandr)

	@$(call install_finish, xorg-lib-xrandr)

	@$(call touch)

# vim: syntax=make
