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
PACKAGES-$(PTXCONF_XORG_LIB_XKBFILE) += xorg-lib-xkbfile

#
# Paths and names
#
XORG_LIB_XKBFILE_VERSION	:= 1.1.0
XORG_LIB_XKBFILE_MD5		:= dd7e1e946def674e78c0efbc5c7d5b3b
XORG_LIB_XKBFILE		:= libxkbfile-$(XORG_LIB_XKBFILE_VERSION)
XORG_LIB_XKBFILE_SUFFIX		:= tar.bz2
XORG_LIB_XKBFILE_URL		:= $(call ptx/mirror, XORG, individual/lib/$(XORG_LIB_XKBFILE).$(XORG_LIB_XKBFILE_SUFFIX))
XORG_LIB_XKBFILE_SOURCE		:= $(SRCDIR)/$(XORG_LIB_XKBFILE).$(XORG_LIB_XKBFILE_SUFFIX)
XORG_LIB_XKBFILE_DIR		:= $(BUILDDIR)/$(XORG_LIB_XKBFILE)
XORG_LIB_XKBFILE_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_LIB_XKBFILE_CONF_TOOL := autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-xkbfile.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-xkbfile)
	@$(call install_fixup, xorg-lib-xkbfile,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xkbfile,SECTION,base)
	@$(call install_fixup, xorg-lib-xkbfile,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xkbfile,DESCRIPTION,missing)

	@$(call install_lib, xorg-lib-xkbfile, 0, 0, 0644, libxkbfile)

	@$(call install_finish, xorg-lib-xkbfile)

	@$(call touch)

# vim: syntax=make
