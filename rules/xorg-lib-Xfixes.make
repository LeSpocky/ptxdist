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
PACKAGES-$(PTXCONF_XORG_LIB_XFIXES) += xorg-lib-xfixes

#
# Paths and names
#
XORG_LIB_XFIXES_VERSION	:= 6.0.2
XORG_LIB_XFIXES_MD5	:= baa39ada682dd524491a165bb0dfc708
XORG_LIB_XFIXES		:= libXfixes-$(XORG_LIB_XFIXES_VERSION)
XORG_LIB_XFIXES_SUFFIX	:= tar.xz
XORG_LIB_XFIXES_URL	:= $(call ptx/mirror, XORG, individual/lib/$(XORG_LIB_XFIXES).$(XORG_LIB_XFIXES_SUFFIX))
XORG_LIB_XFIXES_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XFIXES).$(XORG_LIB_XFIXES_SUFFIX)
XORG_LIB_XFIXES_DIR	:= $(BUILDDIR)/$(XORG_LIB_XFIXES)
XORG_LIB_XFIXES_LICENSE	:= HPND-sell-variant AND MIT
XORG_LIB_XFIXES_LICENSE_FILES := \
	file://COPYING;md5=a5a9755c8921cc7dc08a5cfe4267d0ff

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_LIB_XFIXES_CONF_TOOL := autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-xfixes.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-xfixes)
	@$(call install_fixup, xorg-lib-xfixes,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xfixes,SECTION,base)
	@$(call install_fixup, xorg-lib-xfixes,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xfixes,DESCRIPTION,missing)

	@$(call install_lib, xorg-lib-xfixes, 0, 0, 0644, libXfixes)

	@$(call install_finish, xorg-lib-xfixes)

	@$(call touch)

# vim: syntax=make
