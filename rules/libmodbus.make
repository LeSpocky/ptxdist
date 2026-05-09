# -*-makefile-*-
#
# Copyright (C) 2005 by Robert Schwebel
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBMODBUS) += libmodbus

#
# Paths and names
#
LIBMODBUS_VERSION	:= 3.0.8
LIBMODBUS_SHA256	:= 022f0691d920b8aee3ee49d7af0f69b7ef80fc3c849a8e0281d5bc27db7a24ea
LIBMODBUS		:= libmodbus-$(LIBMODBUS_VERSION)
LIBMODBUS_SUFFIX	:= tar.gz
LIBMODBUS_URL		:= https://libmodbus.org/releases/$(LIBMODBUS).$(LIBMODBUS_SUFFIX)
LIBMODBUS_SOURCE	:= $(SRCDIR)/$(LIBMODBUS).$(LIBMODBUS_SUFFIX)
LIBMODBUS_DIR		:= $(BUILDDIR)/$(LIBMODBUS)
LIBMODBUS_LICENSE	:= LGPL-3.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------


LIBMODBUS_CONF_TOOL := autoconf
LIBMODBUS_CONF_OPT := \
	$(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libmodbus.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libmodbus)
	@$(call install_fixup, libmodbus,PRIORITY,optional)
	@$(call install_fixup, libmodbus,SECTION,base)
	@$(call install_fixup, libmodbus,AUTHOR,"Josef Holzmayr <holzmayr@rsi-elektrotechnik.de>")
	@$(call install_fixup, libmodbus,DESCRIPTION,missing)

	@$(call install_lib, libmodbus, 0, 0, 0644, libmodbus)

	@$(call install_finish, libmodbus)

	@$(call touch)

# vim: syntax=make
