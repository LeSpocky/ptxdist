# -*-makefile-*-
#
# Copyright (C) 2006 by Sascha Hauer
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_APP_XEYES) += xorg-app-xeyes

#
# Paths and names
#
XORG_APP_XEYES_VERSION	:= 1.1.2
XORG_APP_XEYES_MD5	:= 6f0543ec84283df5743eeafc173bea4a
XORG_APP_XEYES		:= xeyes-$(XORG_APP_XEYES_VERSION)
XORG_APP_XEYES_SUFFIX	:= tar.bz2
XORG_APP_XEYES_URL	:= $(call ptx/mirror, XORG, individual/app/$(XORG_APP_XEYES).$(XORG_APP_XEYES_SUFFIX))
XORG_APP_XEYES_SOURCE	:= $(SRCDIR)/$(XORG_APP_XEYES).$(XORG_APP_XEYES_SUFFIX)
XORG_APP_XEYES_DIR	:= $(BUILDDIR)/$(XORG_APP_XEYES)
XORG_APP_XEYES_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_APP_XEYES_PATH	:= PATH=$(CROSS_PATH)
XORG_APP_XEYES_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_APP_XEYES_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--datadir=$(XORG_DATADIR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-app-xeyes.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-app-xeyes)
	@$(call install_fixup, xorg-app-xeyes,PRIORITY,optional)
	@$(call install_fixup, xorg-app-xeyes,SECTION,base)
	@$(call install_fixup, xorg-app-xeyes,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, xorg-app-xeyes,DESCRIPTION,missing)

	@$(call install_copy, xorg-app-xeyes, 0, 0, 0755, -, \
		$(XORG_PREFIX)/bin/xeyes)

	@$(call install_finish, xorg-app-xeyes)

	@$(call touch)

# vim: syntax=make
