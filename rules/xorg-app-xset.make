# -*-makefile-*-
#
# Copyright (C) 2006 by Luotao Fu <lfu@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_APP_XSET) += xorg-app-xset

#
# Paths and names
#
XORG_APP_XSET_VERSION	:= 1.2.4
XORG_APP_XSET_MD5	:= 70ea7bc7bacf1a124b1692605883f620
XORG_APP_XSET		:= xset-$(XORG_APP_XSET_VERSION)
XORG_APP_XSET_SUFFIX	:= tar.bz2
XORG_APP_XSET_URL	:= $(call ptx/mirror, XORG, individual/app/$(XORG_APP_XSET).$(XORG_APP_XSET_SUFFIX))
XORG_APP_XSET_SOURCE	:= $(SRCDIR)/$(XORG_APP_XSET).$(XORG_APP_XSET_SUFFIX)
XORG_APP_XSET_DIR	:= $(BUILDDIR)/$(XORG_APP_XSET)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_APP_XSET_CONF_TOOL	:= autoconf
XORG_APP_XSET_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--datadir=$(XORG_DATADIR) \
	--with-xf86misc

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-app-xset.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-app-xset)
	@$(call install_fixup, xorg-app-xset,PRIORITY,optional)
	@$(call install_fixup, xorg-app-xset,SECTION,base)
	@$(call install_fixup, xorg-app-xset,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, xorg-app-xset,DESCRIPTION,missing)

	@$(call install_copy, xorg-app-xset, 0, 0, 0755, -, /usr/bin/xset)

	@$(call install_finish, xorg-app-xset)

	@$(call touch)

# vim: syntax=make
