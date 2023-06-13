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
XKEYBOARD_CONFIG_VERSION	:= 2.39
XKEYBOARD_CONFIG_MD5		:= a7de43e9d9e8bb9d85d447da2e63bcc8
XKEYBOARD_CONFIG		:= xkeyboard-config-$(XKEYBOARD_CONFIG_VERSION)
XKEYBOARD_CONFIG_SUFFIX		:= tar.xz
XKEYBOARD_CONFIG_URL		:= $(call ptx/mirror, XORG, individual/data/xkeyboard-config/$(XKEYBOARD_CONFIG).$(XKEYBOARD_CONFIG_SUFFIX))
XKEYBOARD_CONFIG_SOURCE		:= $(SRCDIR)/$(XKEYBOARD_CONFIG).$(XKEYBOARD_CONFIG_SUFFIX)
XKEYBOARD_CONFIG_DIR		:= $(BUILDDIR)/$(XKEYBOARD_CONFIG)
XKEYBOARD_CONFIG_LICENSE	:= MIT
XKEYBOARD_CONFIG_LICENSE_FILES	:= \
	file://COPYING;md5=0e7f21ca7db975c63467d2e7624a12f9

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
	-Dxkb-base=$(XORG_DATADIR)/X11/xkb

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

	@$(call install_tree, xkeyboard-config, 0, 0, -, $(XORG_DATADIR)/X11/xkb)

	@$(call install_finish, xkeyboard-config)

	@$(call touch)

# vim: syntax=make
