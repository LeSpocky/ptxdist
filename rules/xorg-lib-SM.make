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
PACKAGES-$(PTXCONF_XORG_LIB_SM) += xorg-lib-sm

#
# Paths and names
#
XORG_LIB_SM_VERSION	:= 1.2.6
XORG_LIB_SM_MD5		:= 3aeeea05091db1c69e6f768e0950a431
XORG_LIB_SM		:= libSM-$(XORG_LIB_SM_VERSION)
XORG_LIB_SM_SUFFIX	:= tar.xz
XORG_LIB_SM_URL		:= $(call ptx/mirror, XORG, individual/lib/$(XORG_LIB_SM).$(XORG_LIB_SM_SUFFIX))
XORG_LIB_SM_SOURCE	:= $(SRCDIR)/$(XORG_LIB_SM).$(XORG_LIB_SM_SUFFIX)
XORG_LIB_SM_DIR		:= $(BUILDDIR)/$(XORG_LIB_SM)
XORG_LIB_SM_LICENSE	:= MIT AND MIT-open-group
XORG_LIB_SM_LICENSE_FILES := \
	file://COPYING;md5=e04a412a93c7cb2b5e07ebd8fd922917

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_LIB_SM_CONF_TOOL	:= autoconf
XORG_LIB_SM_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-docs \
	$(XORG_OPTIONS_TRANS) \
	$(XORG_OPTIONS_DOCS) \
	--without-libuuid

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-sm.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-sm)
	@$(call install_fixup, xorg-lib-sm,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-sm,SECTION,base)
	@$(call install_fixup, xorg-lib-sm,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-sm,DESCRIPTION,missing)

	@$(call install_lib, xorg-lib-sm, 0, 0, 0644, libSM)

	@$(call install_finish, xorg-lib-sm)

	@$(call touch)

# vim: syntax=make
