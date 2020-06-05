# -*-makefile-*-
#
# Copyright (C) 2005 by Josef Holzmayr <holzmayr@rsi-elektrotechnik.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBMODBUS3) += libmodbus3

#
# Paths and names
#
LIBMODBUS3_VERSION		:= 3.1.6
LIBMODBUS3_MD5			:= 15c84c1f7fb49502b3efaaa668cfd25e
LIBMODBUS3			:= libmodbus-$(LIBMODBUS3_VERSION)
LIBMODBUS3_SUFFIX		:= tar.gz
LIBMODBUS3_URL			:= https://libmodbus.org/releases/$(LIBMODBUS3).$(LIBMODBUS3_SUFFIX)
LIBMODBUS3_SOURCE		:= $(SRCDIR)/$(LIBMODBUS3).$(LIBMODBUS3_SUFFIX)
LIBMODBUS3_DIR			:= $(BUILDDIR)/$(LIBMODBUS3)
LIBMODBUS3_LICENSE		:= LGPL-2.1-or-later
LIBMODBUS3_LICENSE_FILES	:= \
	file://COPYING.LESSER;md5=4fbd65380cdd255951079008b364516c \
	file://src/modbus.c;startline=4;endline=4;md5=09383b02650315a322dba1dcf8aad811

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBMODBUS3_CONF_TOOL := autoconf
LIBMODBUS3_CONF_OPT += \
	$(CROSS_AUTOCONF_USR) \
	--enable-silent-rules \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-tests \
	--without-documentation

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libmodbus3.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libmodbus3)
	@$(call install_fixup, libmodbus3,PRIORITY,optional)
	@$(call install_fixup, libmodbus3,SECTION,base)
	@$(call install_fixup, libmodbus3,AUTHOR,"Josef Holzmayr <holzmayr@rsi-elektrotechnik.de>")
	@$(call install_fixup, libmodbus3,DESCRIPTION,missing)

	@$(call install_lib, libmodbus3, 0, 0, 0644, libmodbus)

	@$(call install_finish, libmodbus3)

	@$(call touch)

# vim: syntax=make
