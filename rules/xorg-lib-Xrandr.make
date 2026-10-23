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
XORG_LIB_XRANDR_VERSION	:= 1.5.5
XORG_LIB_XRANDR_SHA256	:= 72b922c2e765434e9e9f0960148070bd4504b288263e2868a4ccce1b7cf2767a
XORG_LIB_XRANDR		:= libXrandr-$(XORG_LIB_XRANDR_VERSION)
XORG_LIB_XRANDR_SUFFIX	:= tar.xz
XORG_LIB_XRANDR_URL	:= $(call ptx/mirror, XORG, individual/lib/$(XORG_LIB_XRANDR).$(XORG_LIB_XRANDR_SUFFIX))
XORG_LIB_XRANDR_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XRANDR).$(XORG_LIB_XRANDR_SUFFIX)
XORG_LIB_XRANDR_DIR	:= $(BUILDDIR)/$(XORG_LIB_XRANDR)
XORG_LIB_XRANDR_LICENSE	:= HPND-sell-variant
XORG_LIB_XRANDR_LICENSE_FILES := \
	file://COPYING;md5=c9d1a2118a6cd5727521db8e7a2fee69

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
