# -*-makefile-*-
#
# Copyright (C) 2008 by Luotao Fu <l.fu@pengutronix.de>
#               2010 Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BC) += bc

#
# Paths and names
#
BC_VERSION	:= 1.08.1
BC_MD5		:= 26c11787a7a1d76de8a2ac3a7ba92098
BC		:= bc-$(BC_VERSION)
BC_SUFFIX	:= tar.xz
BC_URL		:= $(call ptx/mirror, GNU, bc/$(BC).$(BC_SUFFIX))
BC_SOURCE	:= $(SRCDIR)/$(BC).$(BC_SUFFIX)
BC_DIR		:= $(BUILDDIR)/$(BC)
BC_LICENSE	:= GPL-3.0-or-later
BC_LICENSE_FILES	:= \
	file://COPYING;md5=d32239bcb673463ab874e80d47fae504 \
	file://bc/bc.c;startline=3;endline=46;md5=d65c804470e1c96f665f0d07debdbc34

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
BC_CONF_TOOL	:= autoconf
BC_CONF_OPT	:= $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/bc.targetinstall:
	@$(call targetinfo)

	@$(call install_init, bc)
	@$(call install_fixup, bc,PRIORITY,optional)
	@$(call install_fixup, bc,SECTION,base)
	@$(call install_fixup, bc,AUTHOR,"Luotao Fu <l.fu@pengutronix.de>")
	@$(call install_fixup, bc,DESCRIPTION,missing)

	@$(call install_copy, bc, 0, 0, 0755, -, /usr/bin/bc)

	@$(call install_finish, bc)

	@$(call touch)

# vim: syntax=make
