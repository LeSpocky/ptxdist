# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
#               2008 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_LIB_XDMCP) += xorg-lib-xdmcp

#
# Paths and names
#
XORG_LIB_XDMCP_VERSION	:= 1.1.3
XORG_LIB_XDMCP_MD5	:= 115c5c12ecce0e749cd91d999a5fd160
XORG_LIB_XDMCP		:= libXdmcp-$(XORG_LIB_XDMCP_VERSION)
XORG_LIB_XDMCP_SUFFIX	:= tar.bz2
XORG_LIB_XDMCP_URL	:= $(call ptx/mirror, XORG, individual/lib/$(XORG_LIB_XDMCP).$(XORG_LIB_XDMCP_SUFFIX))
XORG_LIB_XDMCP_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XDMCP).$(XORG_LIB_XDMCP_SUFFIX)
XORG_LIB_XDMCP_DIR	:= $(BUILDDIR)/$(XORG_LIB_XDMCP)
XORG_LIB_XDMCP_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_LIB_XDMCP_CONF_ENV		:= \
	$(CROSS_ENV) \
	ac_cv_lib_bsd_arc4random_buf=no

#
# autoconf
#
XORG_LIB_XDMCP_CONF_TOOL	:= autoconf
XORG_LIB_XDMCP_CONF_OPT		= \
	$(CROSS_AUTOCONF_USR) \
	--disable-docs \
	$(XORG_OPTIONS_DOCS)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-xdmcp.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-xdmcp)
	@$(call install_fixup, xorg-lib-xdmcp,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xdmcp,SECTION,base)
	@$(call install_fixup, xorg-lib-xdmcp,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xdmcp,DESCRIPTION,missing)

	@$(call install_lib, xorg-lib-xdmcp, 0, 0, 0644, libXdmcp)

	@$(call install_finish, xorg-lib-xdmcp)

	@$(call touch)

# vim: syntax=make
