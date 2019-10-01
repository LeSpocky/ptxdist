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
PACKAGES-$(PTXCONF_XORG_APP_SETXKBMAP) += xorg-app-setxkbmap

#
# Paths and names
#
XORG_APP_SETXKBMAP_VERSION	:= 1.3.2
XORG_APP_SETXKBMAP_MD5		:= 93e736c98fb75856ee8227a0c49a128d
XORG_APP_SETXKBMAP		:= setxkbmap-$(XORG_APP_SETXKBMAP_VERSION)
XORG_APP_SETXKBMAP_SUFFIX	:= tar.bz2
XORG_APP_SETXKBMAP_URL		:= $(call ptx/mirror, XORG, individual/app/$(XORG_APP_SETXKBMAP).$(XORG_APP_SETXKBMAP_SUFFIX))
XORG_APP_SETXKBMAP_SOURCE	:= $(SRCDIR)/$(XORG_APP_SETXKBMAP).$(XORG_APP_SETXKBMAP_SUFFIX)
XORG_APP_SETXKBMAP_DIR		:= $(BUILDDIR)/$(XORG_APP_SETXKBMAP)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_APP_SETXKBMAP_CONF_TOOL	:= autoconf
XORG_APP_SETXKBMAP_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--datadir=$(XORG_DATADIR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-app-setxkbmap.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-app-setxkbmap)
	@$(call install_fixup, xorg-app-setxkbmap,PRIORITY,optional)
	@$(call install_fixup, xorg-app-setxkbmap,SECTION,base)
	@$(call install_fixup, xorg-app-setxkbmap,AUTHOR,"Juergen Beisert")
	@$(call install_fixup, xorg-app-setxkbmap,DESCRIPTION,missing)

	@$(call install_copy, xorg-app-setxkbmap,  0, 0, 0755, -, \
		/usr/bin/setxkbmap)

	@$(call install_finish, xorg-app-setxkbmap)

	@$(call touch)

# vim: syntax=make
