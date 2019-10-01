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
PACKAGES-$(PTXCONF_XORG_LIB_XPM) += xorg-lib-xpm

#
# Paths and names
#
XORG_LIB_XPM_VERSION	:= 3.5.12
XORG_LIB_XPM_MD5	:= 20f4627672edb2bd06a749f11aa97302
XORG_LIB_XPM		:= libXpm-$(XORG_LIB_XPM_VERSION)
XORG_LIB_XPM_SUFFIX	:= tar.bz2
XORG_LIB_XPM_URL	:= $(call ptx/mirror, XORG, individual/lib/$(XORG_LIB_XPM).$(XORG_LIB_XPM_SUFFIX))
XORG_LIB_XPM_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XPM).$(XORG_LIB_XPM_SUFFIX)
XORG_LIB_XPM_DIR	:= $(BUILDDIR)/$(XORG_LIB_XPM)
XORG_LIB_XPM_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_LIB_XPM_CONF_ENV	:= \
	$(CROSS_ENV) \
	ac_cv_search_gettext=no

#
# autoconf
#
XORG_LIB_XPM_CONF_TOOL := autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-xpm.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-xpm)
	@$(call install_fixup, xorg-lib-xpm,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xpm,SECTION,base)
	@$(call install_fixup, xorg-lib-xpm,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xpm,DESCRIPTION,missing)

	@$(call install_lib, xorg-lib-xpm, 0, 0, 0644, libXpm)

	@$(call install_finish, xorg-lib-xpm)

	@$(call touch)

# vim: syntax=make
