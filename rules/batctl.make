# -*-makefile-*-
#
# Copyright (C) 2014 by Markus Pargmann <mpa@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BATCTL) += batctl

#
# Paths and names
#
BATCTL_VERSION		:= 2025.2
BATCTL_MD5		:= 344c58f531bc7b2b7409cb9dc0843ffe
BATCTL			:= batctl-$(BATCTL_VERSION)
BATCTL_SUFFIX		:= tar.gz
BATCTL_URL		:= https://downloads.open-mesh.org/batman/stable/sources/batctl/$(BATCTL).$(BATCTL_SUFFIX)
BATCTL_SOURCE		:= $(SRCDIR)/$(BATCTL).$(BATCTL_SUFFIX)
BATCTL_DIR		:= $(BUILDDIR)/$(BATCTL)
BATCTL_LICENSE		:= GPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

BATCTL_CONF_TOOL	:= NO
BATCTL_MAKE_ENV		:= $(CROSS_ENV)

BATCTL_INSTALL_OPT	:= \
	PREFIX=/usr \
	install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/batctl.targetinstall:
	@$(call targetinfo)

	@$(call install_init, batctl)
	@$(call install_fixup, batctl,PRIORITY,optional)
	@$(call install_fixup, batctl,SECTION,base)
	@$(call install_fixup, batctl,AUTHOR,"Markus Pargmann <mpa@pengutronix.de>")
	@$(call install_fixup, batctl,DESCRIPTION,missing)

	@$(call install_copy, batctl, 0, 0, 0755, -, /usr/sbin/batctl)

	@$(call install_finish, batctl)

	@$(call touch)

# vim: syntax=make
