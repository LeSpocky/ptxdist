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
PACKAGES-$(PTXCONF_XORG_LIB_XI) += xorg-lib-xi

#
# Paths and names
#
XORG_LIB_XI_VERSION	:= 1.8.2
XORG_LIB_XI_MD5		:= 95a960c1692a83cc551979f7ffe28cf4
XORG_LIB_XI		:= libXi-$(XORG_LIB_XI_VERSION)
XORG_LIB_XI_SUFFIX	:= tar.xz
XORG_LIB_XI_URL		:= $(call ptx/mirror, XORG, individual/lib/$(XORG_LIB_XI).$(XORG_LIB_XI_SUFFIX))
XORG_LIB_XI_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XI).$(XORG_LIB_XI_SUFFIX)
XORG_LIB_XI_DIR		:= $(BUILDDIR)/$(XORG_LIB_XI)
XORG_LIB_XI_LICENSE	:= MIT-open-group AND SMLNJ AND MIT
XORG_LIB_XI_LICENSE_FILES := \
	file://COPYING;md5=17b064789fab936a1c58c4e13d965b0f

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_LIB_XI_CONF_TOOL	:= autoconf
XORG_LIB_XI_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-docs \
	--disable-specs \
	--disable-malloc0returnsnull \
	$(XORG_OPTIONS_DOCS)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-xi.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-xi)
	@$(call install_fixup, xorg-lib-xi,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xi,SECTION,base)
	@$(call install_fixup, xorg-lib-xi,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xi,DESCRIPTION,missing)

	@$(call install_lib, xorg-lib-xi, 0, 0, 0644, libXi)

	@$(call install_finish, xorg-lib-xi)

	@$(call touch)

# vim: syntax=make
