# -*-makefile-*-
#
# Copyright (C) 2023 by Ladislav Michl <ladis@linux-mips.org>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBASS) += libass

#
# Paths and names
#
LIBASS_VERSION		:= 0.17.1
LIBASS_MD5		:= e920cfac44bf9e729d9a0aeed22d9ddb
LIBASS			:= libass-$(LIBASS_VERSION)
LIBASS_SUFFIX		:= tar.gz
LIBASS_URL		:= https://github.com/libass/libass/archive/$(LIBASS_VERSION).$(LIBASS_SUFFIX)
LIBASS_SOURCE		:= $(SRCDIR)/$(LIBASS).$(LIBASS_SUFFIX)
LIBASS_DIR		:= $(BUILDDIR)/$(LIBASS)
LIBASS_LICENSE		:= ISC
LIBASS_LICENSE_FILES	:= \
	file://COPYING;md5=a42532a0684420bdb15556c3cdd49a75

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBASS_CONF_TOOL	:= autoconf
LIBASS_CONF_OPT		:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-test \
	--disable-profile

$(STATEDIR)/libass.prepare:
	@$(call targetinfo)
	@$(call world/execute, LIBASS, ./autogen.sh)
	@$(call world/prepare, LIBASS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libass.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libass)
	@$(call install_fixup, libass,PRIORITY,optional)
	@$(call install_fixup, libass,SECTION,base)
	@$(call install_fixup, libass,AUTHOR,"Ladislav Michl <ladis@linux-mips.org>")
	@$(call install_fixup, libass,DESCRIPTION,missing)

	@$(call install_lib, libass, 0, 0, 0644, libass)

	@$(call install_finish, libass)

	@$(call touch)

# vim: syntax=make
