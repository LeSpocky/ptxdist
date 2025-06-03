# -*-makefile-*-
#
# Copyright (C) 2025 by Alexander Dahl <ada@thorsis.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBONIG) += libonig

#
# Paths and names
#
LIBONIG_VERSION		:= 6.9.10
LIBONIG_MD5		:= 46c48d072eafe29a0dd0489df7f6f212
LIBONIG			:= onig-$(LIBONIG_VERSION)
LIBONIG_SUFFIX		:= tar.gz
LIBONIG_URL		:= https://github.com/kkos/oniguruma/releases/download/v$(LIBONIG_VERSION)/$(LIBONIG).$(LIBONIG_SUFFIX)
LIBONIG_SOURCE		:= $(SRCDIR)/$(LIBONIG).$(LIBONIG_SUFFIX)
LIBONIG_DIR		:= $(BUILDDIR)/$(LIBONIG)
LIBONIG_LICENSE		:= BSD-2-Clause
LIBONIG_LICENSE_FILES	:= file://COPYING;md5=e6365c225bb5cc4321d0913f0baffa04

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBONIG_CONF_TOOL	:= autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libonig.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libonig)
	@$(call install_fixup, libonig,PRIORITY,optional)
	@$(call install_fixup, libonig,SECTION,base)
	@$(call install_fixup, libonig,AUTHOR,"Alexander Dahl <ada@thorsis.com>")
	@$(call install_fixup, libonig,DESCRIPTION,missing)

	@$(call install_lib, libonig, 0, 0, 0644, libonig)

	@$(call install_finish, libonig)

	@$(call touch)

# vim: ft=make noet ts=8 sw=8
