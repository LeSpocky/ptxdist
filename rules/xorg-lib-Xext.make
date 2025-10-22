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
XORG_LIB_XEXT_VERSION	:= 1.3.6
XORG_LIB_XEXT_MD5	:= e59476db179e48c1fb4487c12d0105d1
XORG_LIB_XEXT		:= libXext-$(XORG_LIB_XEXT_VERSION)
XORG_LIB_XEXT_SUFFIX	:= tar.xz
XORG_LIB_XEXT_URL	:= $(call ptx/mirror, XORG, individual/lib/$(XORG_LIB_XEXT).$(XORG_LIB_XEXT_SUFFIX))
XORG_LIB_XEXT_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XEXT).$(XORG_LIB_XEXT_SUFFIX)
XORG_LIB_XEXT_DIR	:= $(BUILDDIR)/$(XORG_LIB_XEXT)
XORG_LIB_XEXT_LICENSE	:= MIT-open-group AND X11 AND HPND-sell-variant AND SMLNJ AND NTP AND MIT AND ISC
XORG_LIB_XEXT_LICENSE_FILES := \
	file://COPYING;md5=4234bb3b2f1521ea101e4e9db7c33c69

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
