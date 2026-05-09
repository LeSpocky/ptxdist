# -*-makefile-*-
#
# Copyright (C) 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BUSTLE) += bustle

#
# Paths and names
#
BUSTLE_VERSION	:= 0.2.4
BUSTLE_SHA256	:= 0ef8c94062eeffcbe1bf76dbb6191e56e281f462d2a17bf56d471f2181e42324
BUSTLE		:= bustle-$(BUSTLE_VERSION)
BUSTLE_SUFFIX	:= tar.gz
BUSTLE_URL	:= http://www.willthompson.co.uk/bustle/releases/$(BUSTLE).$(BUSTLE_SUFFIX)
BUSTLE_SOURCE	:= $(SRCDIR)/$(BUSTLE).$(BUSTLE_SUFFIX)
BUSTLE_DIR	:= $(BUILDDIR)/$(BUSTLE)
BUSTLE_LICENSE	:= GPL-2.0-or-later AND LGPL-2.1-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

BUSTLE_MAKE_ENV := $(CROSS_ENV)

$(STATEDIR)/bustle.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/bustle.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/bustle.targetinstall:
	@$(call targetinfo)

	@$(call install_init, bustle)
	@$(call install_fixup, bustle,PRIORITY,optional)
	@$(call install_fixup, bustle,SECTION,base)
	@$(call install_fixup, bustle,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, bustle,DESCRIPTION,missing)

	@$(call install_copy, bustle, 0, 0, 0755, $(BUSTLE_DIR)/bustle-dbus-monitor, /usr/bin/bustle-dbus-monitor)

	@$(call install_finish, bustle)

	@$(call touch)

# vim: syntax=make
