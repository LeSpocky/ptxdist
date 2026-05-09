# -*-makefile-*-
#
# Copyright (C) 2009 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_EGGDBUS) += eggdbus

#
# Paths and names
#
EGGDBUS_VERSION	:= 0.6
EGGDBUS_SHA256	:= 045b1904c90a5acb2ddc93504cdbc5e1317c8021bbf919cea3bf18a686911085
EGGDBUS		:= eggdbus-$(EGGDBUS_VERSION)
EGGDBUS_SUFFIX	:= tar.gz
EGGDBUS_URL	:= https://hal.freedesktop.org/releases/$(EGGDBUS).$(EGGDBUS_SUFFIX)
EGGDBUS_SOURCE	:= $(SRCDIR)/$(EGGDBUS).$(EGGDBUS_SUFFIX)
EGGDBUS_DIR	:= $(BUILDDIR)/$(EGGDBUS)
EGGDBUS_LICENSE	:= LGPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

EGGDBUS_CONF_TOOL := autoconf
EGGDBUS_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-static \
	--disable-ansi \
	--disable-verbose-mode \
	--disable-man-pages \
	--disable-gtk-doc \
	--with-eggdbus-tools=$(PTXDIST_SYSROOT_HOST)/usr/bin

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/eggdbus.targetinstall:
	@$(call targetinfo)

	@$(call install_init, eggdbus)
	@$(call install_fixup, eggdbus,PRIORITY,optional)
	@$(call install_fixup, eggdbus,SECTION,base)
	@$(call install_fixup, eggdbus,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, eggdbus,DESCRIPTION,missing)

	@$(call install_lib, eggdbus, 0, 0, 0644, libeggdbus-1)

	@$(call install_finish, eggdbus)

	@$(call touch)

# vim: syntax=make
