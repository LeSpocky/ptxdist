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
PACKAGES-$(PTXCONF_XORG_APP_XKBCOMP) += xorg-app-xkbcomp

#
# Paths and names
#
XORG_APP_XKBCOMP_VERSION	:= 1.4.2
XORG_APP_XKBCOMP_MD5		:= 12610df19df2af3797f2c130ee2bce97
XORG_APP_XKBCOMP		:= xkbcomp-$(XORG_APP_XKBCOMP_VERSION)
XORG_APP_XKBCOMP_SUFFIX		:= tar.bz2
XORG_APP_XKBCOMP_URL		:= $(call ptx/mirror, XORG, individual/app/$(XORG_APP_XKBCOMP).$(XORG_APP_XKBCOMP_SUFFIX))
XORG_APP_XKBCOMP_SOURCE		:= $(SRCDIR)/$(XORG_APP_XKBCOMP).$(XORG_APP_XKBCOMP_SUFFIX)
XORG_APP_XKBCOMP_DIR		:= $(BUILDDIR)/$(XORG_APP_XKBCOMP)
XORG_APP_XKBCOMP_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_APP_XKBCOMP_CONF_TOOL	:= autoconf
XORG_APP_XKBCOMP_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--datadir=$(XORG_DATADIR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-app-xkbcomp.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-app-xkbcomp)
	@$(call install_fixup, xorg-app-xkbcomp,PRIORITY,optional)
	@$(call install_fixup, xorg-app-xkbcomp,SECTION,base)
	@$(call install_fixup, xorg-app-xkbcomp,AUTHOR,"Juergen Beisert")
	@$(call install_fixup, xorg-app-xkbcomp,DESCRIPTION,missing)

	@$(call install_copy, xorg-app-xkbcomp,  0, 0, 0755, -, \
		/usr/bin/xkbcomp)

	@$(call install_finish, xorg-app-xkbcomp)

	@$(call touch)

# vim: syntax=make
