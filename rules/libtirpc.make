# -*-makefile-*-
#
# Copyright (C) 2015 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBTIRPC) += libtirpc

#
# Paths and names
#
LIBTIRPC_VERSION	:= 1.3.7
LIBTIRPC_SHA256		:= b47d3ac19d3549e54a05d0019a6c400674da716123858cfdb6d3bdd70a66c702
LIBTIRPC		:= libtirpc-$(LIBTIRPC_VERSION)
LIBTIRPC_SUFFIX		:= tar.bz2
LIBTIRPC_URL		:= $(call ptx/mirror, SF, libtirpc/$(LIBTIRPC).$(LIBTIRPC_SUFFIX))
LIBTIRPC_SOURCE		:= $(SRCDIR)/$(LIBTIRPC).$(LIBTIRPC_SUFFIX)
LIBTIRPC_DIR		:= $(BUILDDIR)/$(LIBTIRPC)
LIBTIRPC_LICENSE	:= BSD-3-Clause
LIBTIRPC_LICENSE_FILES	:= \
	file://COPYING;md5=f835cce8852481e4b2bbbdd23b5e47f3

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBTIRPC_CONF_TOOL	:= autoconf
LIBTIRPC_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-gssapi \
	--disable-authdes \
	$(GLOBAL_IPV6_OPTION) \
	--enable-symvers

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libtirpc.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libtirpc)
	@$(call install_fixup, libtirpc,PRIORITY,optional)
	@$(call install_fixup, libtirpc,SECTION,base)
	@$(call install_fixup, libtirpc,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, libtirpc,DESCRIPTION,missing)

	@$(call install_lib, libtirpc, 0, 0, 0644, libtirpc)
	@$(call install_alternative, libtirpc, 0, 0, 0644, \
		/etc/netconfig)

	@$(call install_finish, libtirpc)

	@$(call touch)

# vim: syntax=make
