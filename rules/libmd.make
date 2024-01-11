# -*-makefile-*-
#
# Copyright (C) 2021 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBMD) += libmd

#
# Paths and names
#
LIBMD_VERSION		:= 1.1.0
LIBMD_MD5		:= b2a0650c78d92c7a9632a2a3cdd4f6a6
LIBMD			:= libmd-$(LIBMD_VERSION)
LIBMD_SUFFIX		:= tar.xz
LIBMD_URL		:= https://libbsd.freedesktop.org/releases/$(LIBMD).$(LIBMD_SUFFIX)
LIBMD_SOURCE		:= $(SRCDIR)/$(LIBMD).$(LIBMD_SUFFIX)
LIBMD_DIR		:= $(BUILDDIR)/$(LIBMD)
LIBMD_LICENSE		:=  BSD-3-Clause AND BSD-2-Clause AND ISC AND Beerware AND public_domain
LIBMD_LICENSE_FILES	:= \
	file://COPYING;md5=0436d4fb62a71f661d6e8b7812f9e1df

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBMD_CONF_TOOL	:= autoconf
LIBMD_CONF_OPT	:=  \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libmd.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libmd)
	@$(call install_fixup, libmd,PRIORITY,optional)
	@$(call install_fixup, libmd,SECTION,base)
	@$(call install_fixup, libmd,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, libmd,DESCRIPTION,missing)

	@$(call install_lib, libmd, 0, 0, 0644, libmd)

	@$(call install_finish, libmd)

	@$(call touch)

# vim: syntax=make
