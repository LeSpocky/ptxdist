# -*-makefile-*-
#
# Copyright (C) 2007 by University of Illinois
#               2010 Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_HASERL) += haserl

#
# Paths and names
#
HASERL_VERSION	:= 0.9.26
HASERL_SHA256	:= a62dc85d442a68e2283936899219fba70d5c8e032cdd36dc5c5d428eebc98fd5
HASERL		:= haserl-$(HASERL_VERSION)
HASERL_SUFFIX	:= tar.gz
HASERL_URL	:= $(call ptx/mirror, SF, haserl/$(HASERL).$(HASERL_SUFFIX))
HASERL_SOURCE	:= $(SRCDIR)/$(HASERL).$(HASERL_SUFFIX)
HASERL_DIR	:= $(BUILDDIR)/$(HASERL)
HASERL_LICENSE	:= GPL-2.0-only
HASERL_LICENSE_FILES	:= file://COPYING;md5=94d55d512a9ba36caa9b7df079bae19f

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HASERL_CONF_TOOL := autoconf
HASERL_CONF_OPT := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/haserl.targetinstall:
	@$(call targetinfo)

	@$(call install_init, haserl)
	@$(call install_fixup, haserl,PRIORITY,optional)
	@$(call install_fixup, haserl,SECTION,base)
	@$(call install_fixup, haserl,AUTHOR,"N. Angelacos; PTXDist rule: Tom St")
	@$(call install_fixup, haserl,DESCRIPTION,missing)

	@$(call install_copy, haserl, 0, 0, 0755, -, /usr/bin/haserl)

	@$(call install_finish, haserl)

	@$(call touch)

# vim: syntax=make

