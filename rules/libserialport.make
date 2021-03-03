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
LIBSERIALPORT_MD5	:= b93f0325a6157198152b5bd7e8182b51
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
