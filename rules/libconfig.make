# -*-makefile-*-
#
# Copyright (C) 2014 by Bernhard Walle <bernhard@bwalle.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBCONFIG) += libconfig

#
# Paths and names
#
LIBCONFIG_VERSION	:= 1.8
LIBCONFIG_MD5		:= 7dc4b7c9767be2b68d5bd1e56f713ee2
LIBCONFIG		:= libconfig-$(LIBCONFIG_VERSION)
LIBCONFIG_SUFFIX	:= tar.gz
LIBCONFIG_URL		:= https://github.com/hyperrealm/libconfig/archive/refs/tags/v$(LIBCONFIG_VERSION).$(LIBCONFIG_SUFFIX)
LIBCONFIG_SOURCE	:= $(SRCDIR)/$(LIBCONFIG).$(LIBCONFIG_SUFFIX)
LIBCONFIG_DIR		:= $(BUILDDIR)/$(LIBCONFIG)
LIBCONFIG_LICENSE	:= LGPL-2.1-or-later
LIBCONFIG_LICENSE_FILES	:= \
	file://lib/libconfig.c;startline=2;endline=15;md5=58ad0ed92e5b2a7e656128eba80a9c89 \
	file://COPYING.LIB;md5=fad9b3332be894bab9bc501572864b29

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBCONFIG_CONF_TOOL	:= autoconf
LIBCONFIG_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--$(call ptx/endis, PTXCONF_LIBCONFIG_CXX)-cxx \
	--disable-doc \
	--disable-examples \
	--disable-tests

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libconfig.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libconfig)
	@$(call install_fixup, libconfig,PRIORITY,optional)
	@$(call install_fixup, libconfig,SECTION,base)
	@$(call install_fixup, libconfig,AUTHOR,"Bernhard Walle <bernhard@bwalle.de>")
	@$(call install_fixup, libconfig,DESCRIPTION,missing)

	@$(call install_lib, libconfig, 0, 0, 0644, libconfig)
ifdef PTXCONF_LIBCONFIG_CXX
	@$(call install_lib, libconfig, 0, 0, 0644, libconfig++)
endif

	@$(call install_finish, libconfig)

	@$(call touch)

# vim: syntax=make
