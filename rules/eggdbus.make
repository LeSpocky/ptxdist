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
EGGDBUS_MD5	:= b43d2a6c523fcb8b9d0b0300c4222386
EGGDBUS		:= eggdbus-$(EGGDBUS_VERSION)
EGGDBUS_SUFFIX	:= tar.gz
EGGDBUS_URL	:= http://hal.freedesktop.org/releases/$(EGGDBUS).$(EGGDBUS_SUFFIX)
EGGDBUS_SOURCE	:= $(SRCDIR)/$(EGGDBUS).$(EGGDBUS_SUFFIX)
EGGDBUS_DIR	:= $(BUILDDIR)/$(EGGDBUS)
EGGDBUS_LICENSE	:= LGPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

EGGDBUS_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-static \
	--disable-ansi \
	--disable-verbose-mode \
	--disable-man-pages \
	--disable-gtk-doc \
	--with-eggdbus-tools=$(PTXDIST_SYSROOT_HOST)/bin

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
