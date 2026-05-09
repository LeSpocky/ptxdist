# -*-makefile-*-
#
# Copyright (C) 2012 by Wolfram Sang <w.sang@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBCGROUP) += libcgroup

#
# Paths and names
#
LIBCGROUP_VERSION	:= 0.38
LIBCGROUP_SHA256	:= 5d36d1a48b95f62fe9fcdf74a5a4089512e5e43e6011aa1504fd6f2a0909867f
LIBCGROUP		:= libcgroup-$(LIBCGROUP_VERSION)
LIBCGROUP_SUFFIX	:= tar.bz2
LIBCGROUP_URL		:= $(call ptx/mirror, SF, libcg/$(LIBCGROUP).$(LIBCGROUP_SUFFIX))
LIBCGROUP_SOURCE	:= $(SRCDIR)/$(LIBCGROUP).$(LIBCGROUP_SUFFIX)
LIBCGROUP_DIR		:= $(BUILDDIR)/$(LIBCGROUP)
LIBCGROUP_LICENSE	:= LGPL-2.1-only

#
# autoconf
#
LIBCGROUP_CONF_TOOL := autoconf
LIBCGROUP_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--disable-bindings \
	--disable-tools \
	--disable-pam \
	--enable-daemon

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libcgroup.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libcgroup)
	@$(call install_fixup, libcgroup,PRIORITY,optional)
	@$(call install_fixup, libcgroup,SECTION,base)
	@$(call install_fixup, libcgroup,AUTHOR,"Wolfram Sang <w.sang@pengutronix.de>")
	@$(call install_fixup, libcgroup,DESCRIPTION,missing)

	@$(call install_lib, libcgroup, 0, 0, 0644, libcgroup)

	@$(call install_finish, libcgroup)

	@$(call touch)

# vim: syntax=make
