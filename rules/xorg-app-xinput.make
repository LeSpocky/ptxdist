# -*-makefile-*-
#
# Copyright (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_APP_XINPUT) += xorg-app-xinput

#
# Paths and names
#
XORG_APP_XINPUT_VERSION	:= 1.6.3
XORG_APP_XINPUT_MD5	:= ac6b7432726008b2f50eba82b0e2dbe4
XORG_APP_XINPUT		:= xinput-$(XORG_APP_XINPUT_VERSION)
XORG_APP_XINPUT_SUFFIX	:= tar.bz2
XORG_APP_XINPUT_URL	:= $(call ptx/mirror, XORG, individual/app/$(XORG_APP_XINPUT).$(XORG_APP_XINPUT_SUFFIX))
XORG_APP_XINPUT_SOURCE	:= $(SRCDIR)/$(XORG_APP_XINPUT).$(XORG_APP_XINPUT_SUFFIX)
XORG_APP_XINPUT_DIR	:= $(BUILDDIR)/$(XORG_APP_XINPUT)
XORG_APP_XINPUT_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_APP_XINPUT_CONF_TOOL := autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-app-xinput.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  xorg-app-xinput)
	@$(call install_fixup, xorg-app-xinput,PRIORITY,optional)
	@$(call install_fixup, xorg-app-xinput,SECTION,base)
	@$(call install_fixup, xorg-app-xinput,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, xorg-app-xinput,DESCRIPTION,missing)

	@$(call install_copy, xorg-app-xinput, 0, 0, 0755, -, /usr/bin/xinput)

	@$(call install_finish, xorg-app-xinput)

	@$(call touch)

# vim: syntax=make
