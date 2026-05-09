# -*-makefile-*-
#
# Copyright (C) 2023 by Alexander Dahl <ada@thorsis.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SSHPASS) += sshpass

#
# Paths and names
#
SSHPASS_VERSION		:= 1.10
SSHPASS_SHA256		:= ad1106c203cbb56185ca3bad8c6ccafca3b4064696194da879f81c8d7bdfeeda
SSHPASS			:= sshpass-$(SSHPASS_VERSION)
SSHPASS_SUFFIX		:= tar.gz
SSHPASS_URL		:= $(call ptx/mirror, SF, sshpass/$(SSHPASS).$(SSHPASS_SUFFIX))
SSHPASS_SOURCE		:= $(SRCDIR)/$(SSHPASS).$(SSHPASS_SUFFIX)
SSHPASS_DIR		:= $(BUILDDIR)/$(SSHPASS)
SSHPASS_LICENSE		:= GPL-2.0-or-later
SSHPASS_LICENSE_FILES	:= file://COPYING;md5=94d55d512a9ba36caa9b7df079bae19f

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SSHPASS_CONF_TOOL	:= autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/sshpass.targetinstall:
	@$(call targetinfo)

	@$(call install_init, sshpass)
	@$(call install_fixup, sshpass,PRIORITY,optional)
	@$(call install_fixup, sshpass,SECTION,base)
	@$(call install_fixup, sshpass,AUTHOR,"Alexander Dahl <ada@thorsis.com>")
	@$(call install_fixup, sshpass,DESCRIPTION,missing)

	@$(call install_copy, sshpass, 0, 0, 0755, -, /usr/bin/sshpass)

	@$(call install_finish, sshpass)

	@$(call touch)

# vim: ft=make noet tw=72 ts=8 sw=8
