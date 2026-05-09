# -*-makefile-*-
#
# Copyright (C) 2005 by Gary Thomas <gary@mlbassoc.com>
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BRIDGE_UTILS) += bridge-utils

#
# Paths and names
#
BRIDGE_UTILS_VERSION	:= 1.7.1
BRIDGE_UTILS_SHA256	:= a61d8be4f1a1405c60c8ef38d544f0c18c05b33b9b07e5b4b31033536165e60e
BRIDGE_UTILS		:= bridge-utils-$(BRIDGE_UTILS_VERSION)
BRIDGE_UTILS_SUFFIX	:= tar.xz
BRIDGE_UTILS_URL	:= $(call ptx/mirror, KERNEL, utils/net/bridge-utils/$(BRIDGE_UTILS).$(BRIDGE_UTILS_SUFFIX))
BRIDGE_UTILS_SOURCE	:= $(SRCDIR)/$(BRIDGE_UTILS).$(BRIDGE_UTILS_SUFFIX)
BRIDGE_UTILS_DIR	:= $(BUILDDIR)/$(BRIDGE_UTILS)
BRIDGE_UTILS_LICENSE	:= GPL-2.0-or-later


# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
BRIDGE_UTILS_CONF_TOOL	:= autoconf

# Set with-linux-headers to something that doesn't exist to avoid the default
# path picking up a path from the build host.
BRIDGE_UTILS_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--with-linux-headers=/this/path/must/not/exist

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/bridge-utils.targetinstall:
	@$(call targetinfo)

	@$(call install_init, bridge-utils)
	@$(call install_fixup, bridge-utils,PRIORITY,optional)
	@$(call install_fixup, bridge-utils,SECTION,base)
	@$(call install_fixup, bridge-utils,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, bridge-utils,DESCRIPTION,missing)

	@$(call install_copy, bridge-utils, 0, 0, 0755, -, /usr/sbin/brctl)

	@$(call install_finish, bridge-utils)
	@$(call touch)

# vim: syntax=make
