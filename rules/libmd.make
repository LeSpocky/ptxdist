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
LIBMD_VERSION		:= 1.3.0
LIBMD_SHA256		:= fc0f1eb6b6766470326f2c014693809190e67dba84274a6fbae9d4912d066706
LIBMD			:= libmd-$(LIBMD_VERSION)
LIBMD_SUFFIX		:= tar.xz
LIBMD_URL		:= https://libbsd.freedesktop.org/releases/$(LIBMD).$(LIBMD_SUFFIX)
LIBMD_SOURCE		:= $(SRCDIR)/$(LIBMD).$(LIBMD_SUFFIX)
LIBMD_DIR		:= $(BUILDDIR)/$(LIBMD)
LIBMD_LICENSE		:=  BSD-3-Clause AND BSD-2-Clause AND ISC AND Beerware AND public_domain
LIBMD_LICENSE_FILES	:= \
	file://COPYING;md5=261bf22602270e2b29c53930d409a3ca

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBMD_CONF_TOOL	:= autoconf
LIBMD_CONF_OPT	:=  \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--$(call ptx/endis, PTXDIST_Y2038)-year2038

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
