# -*-makefile-*-
#
# Copyright (C) 2006 by Sascha Hauer
#               2010 by George McCollister <george.mccollister@gmail.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_APP_XPROP) += xorg-app-xprop

#
# Paths and names
#
XORG_APP_XPROP_VERSION	:= 1.2.4
XORG_APP_XPROP_MD5	:= cc369c28383a5d7144e7197ee7d30bfa
XORG_APP_XPROP		:= xprop-$(XORG_APP_XPROP_VERSION)
XORG_APP_XPROP_SUFFIX	:= tar.bz2
XORG_APP_XPROP_URL	:= $(call ptx/mirror, XORG, individual/app/$(XORG_APP_XPROP).$(XORG_APP_XPROP_SUFFIX))
XORG_APP_XPROP_SOURCE	:= $(SRCDIR)/$(XORG_APP_XPROP).$(XORG_APP_XPROP_SUFFIX)
XORG_APP_XPROP_DIR	:= $(BUILDDIR)/$(XORG_APP_XPROP)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_APP_XPROP_CONF_TOOL	:= autoconf
XORG_APP_XPROP_CONF_OPT		:= \
	$(CROSS_AUTOCONF_USR) \
	--datadir=$(XORG_DATADIR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-app-xprop.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-app-xprop)
	@$(call install_fixup, xorg-app-xprop,PRIORITY,optional)
	@$(call install_fixup, xorg-app-xprop,SECTION,base)
	@$(call install_fixup, xorg-app-xprop,AUTHOR,"george.mccollister@gmail.com>")
	@$(call install_fixup, xorg-app-xprop,DESCRIPTION,missing)

	@$(call install_copy, xorg-app-xprop, 0, 0, 0755, -, \
		$(XORG_PREFIX)/bin/xprop)

	@$(call install_finish, xorg-app-xprop)

	@$(call touch)

# vim: syntax=make
