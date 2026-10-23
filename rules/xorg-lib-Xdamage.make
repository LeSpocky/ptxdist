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
XORG_LIB_XDAMAGE_VERSION	:= 1.1.7
XORG_LIB_XDAMAGE_SHA256		:= 127067f521d3ee467b97bcb145aeba1078e2454d448e8748eb984d5b397bde24
XORG_LIB_XDAMAGE		:= libXdamage-$(XORG_LIB_XDAMAGE_VERSION)
XORG_LIB_XDAMAGE_SUFFIX		:= tar.xz
XORG_LIB_XDAMAGE_URL		:= $(call ptx/mirror, XORG, individual/lib/$(XORG_LIB_XDAMAGE).$(XORG_LIB_XDAMAGE_SUFFIX))
XORG_LIB_XDAMAGE_SOURCE		:= $(SRCDIR)/$(XORG_LIB_XDAMAGE).$(XORG_LIB_XDAMAGE_SUFFIX)
XORG_LIB_XDAMAGE_DIR		:= $(BUILDDIR)/$(XORG_LIB_XDAMAGE)
XORG_LIB_XDAMAGE_LICENSE	:= HPND-sell-variant
XORG_LIB_XDAMAGE_LICENSE_FILES	:= \
	file://COPYING;md5=9fe101f30dd24134cf43146863241868

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
