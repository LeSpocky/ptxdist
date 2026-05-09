# -*-makefile-*-
#
# Copyright (C) 2020 by Alexander Dahl <ada@thorsis.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBSERIALPORT) += libserialport

#
# Paths and names
#
LIBSERIALPORT_VERSION	:= 0.1.1
LIBSERIALPORT_SHA256	:= 4a2af9d9c3ff488e92fb75b4ba38b35bcf9b8a66df04773eba2a7bbf1fa7529d
LIBSERIALPORT		:= libserialport-$(LIBSERIALPORT_VERSION)
LIBSERIALPORT_SUFFIX	:= tar.gz
LIBSERIALPORT_URL	:= http://sigrok.org/download/source/libserialport/$(LIBSERIALPORT).$(LIBSERIALPORT_SUFFIX)
LIBSERIALPORT_SOURCE	:= $(SRCDIR)/$(LIBSERIALPORT).$(LIBSERIALPORT_SUFFIX)
LIBSERIALPORT_DIR	:= $(BUILDDIR)/$(LIBSERIALPORT)
LIBSERIALPORT_LICENSE	:= LGPL-3.0-or-later
LIBSERIALPORT_LICENSE_FILES := file://COPYING;md5=e6a600fd5e1d9cbde2d983680233ad02

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBSERIALPORT_CONF_TOOL	:= autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libserialport.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libserialport)
	@$(call install_fixup, libserialport,PRIORITY,optional)
	@$(call install_fixup, libserialport,SECTION,base)
	@$(call install_fixup, libserialport,AUTHOR,"Alexander Dahl <ada@thorsis.com>")
	@$(call install_fixup, libserialport,DESCRIPTION,missing)

	@$(call install_lib, libserialport, 0, 0, 0644, libserialport)

	@$(call install_finish, libserialport)

	@$(call touch)

# vim: ft=make noet tw=72 ts=8 sw=8
