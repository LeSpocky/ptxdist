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
PACKAGES-$(PTXCONF_XORG_LIB_XSCRNSAVER) += xorg-lib-xscrnsaver

#
# Paths and names
#
XORG_LIB_XSCRNSAVER_VERSION	:= 1.2.3
XORG_LIB_XSCRNSAVER_MD5		:= eeea9d5af3e6c143d0ea1721d27a5e49
XORG_LIB_XSCRNSAVER		:= libXScrnSaver-$(XORG_LIB_XSCRNSAVER_VERSION)
XORG_LIB_XSCRNSAVER_SUFFIX	:= tar.bz2
XORG_LIB_XSCRNSAVER_URL		:= $(call ptx/mirror, XORG, individual/lib/$(XORG_LIB_XSCRNSAVER).$(XORG_LIB_XSCRNSAVER_SUFFIX))
XORG_LIB_XSCRNSAVER_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XSCRNSAVER).$(XORG_LIB_XSCRNSAVER_SUFFIX)
XORG_LIB_XSCRNSAVER_DIR		:= $(BUILDDIR)/$(XORG_LIB_XSCRNSAVER)
XORG_LIB_XSCRNSAVER_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_LIB_XSCRNSAVER_CONF_TOOL	:= autoconf
XORG_LIB_XSCRNSAVER_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-malloc0returnsnull

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-xscrnsaver.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-xscrnsaver)
	@$(call install_fixup, xorg-lib-xscrnsaver,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xscrnsaver,SECTION,base)
	@$(call install_fixup, xorg-lib-xscrnsaver,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xscrnsaver,DESCRIPTION,missing)

	@$(call install_lib, xorg-lib-xscrnsaver, 0, 0, 0644, libXss)

	@$(call install_finish, xorg-lib-xscrnsaver)

	@$(call touch)

# vim: syntax=make
