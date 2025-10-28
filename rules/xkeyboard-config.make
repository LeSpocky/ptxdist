# -*-makefile-*-
#
# Copyright (C) 2009 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XKEYBOARD_CONFIG) += xkeyboard-config

#
# Paths and names
#
XKEYBOARD_CONFIG_VERSION	:= 2.46
XKEYBOARD_CONFIG_MD5		:= ca851f0e5bc0f52f2fb4629babc344c1
XKEYBOARD_CONFIG		:= xkeyboard-config-$(XKEYBOARD_CONFIG_VERSION)
XKEYBOARD_CONFIG_SUFFIX		:= tar.xz
XKEYBOARD_CONFIG_URL		:= $(call ptx/mirror, XORG, individual/data/xkeyboard-config/$(XKEYBOARD_CONFIG).$(XKEYBOARD_CONFIG_SUFFIX))
XKEYBOARD_CONFIG_SOURCE		:= $(SRCDIR)/$(XKEYBOARD_CONFIG).$(XKEYBOARD_CONFIG_SUFFIX)
XKEYBOARD_CONFIG_DIR		:= $(BUILDDIR)/$(XKEYBOARD_CONFIG)
XKEYBOARD_CONFIG_LICENSE	:= HPND-sell-variant AND X11-distribute-modifications-variant AND MIT-open-group AND MIT AND X11 AND xkeyboard-config-Zinoviev
XKEYBOARD_CONFIG_LICENSE_FILES	:= \
	file://COPYING;md5=faa756e04053029ddc602caf99e5ef1d

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XKEYBOARD_CONFIG_CONF_TOOL	:= meson
XKEYBOARD_CONFIG_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Dcompat-rules=true \
	-Dxorg-rules-symlinks=false \
	-Dnls=true \
	-Dnon-latin-layouts-list=false \
	-Ddatadir=$(XORG_DATADIR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xkeyboard-config.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  xkeyboard-config)
	@$(call install_fixup, xkeyboard-config,PRIORITY,optional)
	@$(call install_fixup, xkeyboard-config,SECTION,base)
	@$(call install_fixup, xkeyboard-config,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, xkeyboard-config,DESCRIPTION,missing)

	@$(call install_tree, xkeyboard-config, 0, 0, -, $(XORG_DATADIR)/xkeyboard-config-$(basename $(XKEYBOARD_CONFIG_VERSION)))
	@$(call install_link, xkeyboard-config, ../xkeyboard-config-$(basename $(XKEYBOARD_CONFIG_VERSION)), $(XORG_DATADIR)/X11/xkb)

	@$(call install_finish, xkeyboard-config)

	@$(call touch)

# vim: syntax=make
