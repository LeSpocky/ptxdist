# -*-makefile-*-
#
# Copyright (C) 2024 by Alexander Dahl <ada@thorsis.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SHARNESS) += sharness

#
# Paths and names
#
SHARNESS_VERSION	:= 1.2.1
SHARNESS_MD5		:= b816b21b278688b80453dfd5fbb69556
SHARNESS		:= sharness-$(SHARNESS_VERSION)
SHARNESS_SUFFIX		:= tar.gz
SHARNESS_URL		:= https://github.com/felipec/sharness/archive/refs/tags/v$(SHARNESS_VERSION).$(SHARNESS_SUFFIX)
SHARNESS_SOURCE		:= $(SRCDIR)/$(SHARNESS).$(SHARNESS_SUFFIX)
SHARNESS_DIR		:= $(BUILDDIR)/$(SHARNESS)
SHARNESS_LICENSE	:= GPL-2.0-or-later
SHARNESS_LICENSE_FILES	:= file://COPYING;md5=b234ee4d69f5fce4486a80fdaf4a4263

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SHARNESS_CONF_TOOL	:= NO
SHARNESS_INSTALL_OPT	:= prefix=/usr install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/sharness.targetinstall:
	@$(call targetinfo)

	@$(call install_init, sharness)
	@$(call install_fixup, sharness,PRIORITY,optional)
	@$(call install_fixup, sharness,SECTION,base)
	@$(call install_fixup, sharness,AUTHOR,"Alexander Dahl <ada@thorsis.com>")
	@$(call install_fixup, sharness,DESCRIPTION,missing)

	@$(call install_copy, sharness, 0, 0, 0644, -, \
		/usr/share/sharness/sharness.sh)
	@$(call install_copy, sharness, 0, 0, 0644, -, \
		/usr/share/sharness/lib-sharness/functions.sh)

	@$(call install_finish, sharness)

	@$(call touch)

# vim: ft=make noet tw=72 ts=8 sw=8
