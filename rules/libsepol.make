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
PACKAGES-$(PTXCONF_LIBSEPOL) += libsepol

#
# Paths and names
#
LIBSEPOL_VERSION	:= $(SELINUX_VERSION)
LIBSEPOL_SHA256		:= 79f3d2c88f44b7eb5cf54d9792e03232297e17f97a179163f2750099a00f164d
LIBSEPOL		:= libsepol-$(LIBSEPOL_VERSION)
LIBSEPOL_SUFFIX		:= tar.gz
LIBSEPOL_URL		:= $(SELINUX_URL)/$(LIBSEPOL).$(LIBSEPOL_SUFFIX)
LIBSEPOL_SOURCE		:= $(SRCDIR)/$(LIBSEPOL).$(LIBSEPOL_SUFFIX)
LIBSEPOL_DIR		:= $(BUILDDIR)/$(LIBSEPOL)
LIBSEPOL_LICENSE	:= LGPL-2.1-or-later
LIBSEPOL_LICENSE_FILES	:= file://LICENSE;md5=a6f89e2100d9b6cdffcea4f398e37343
LIBSEPOL_CVE_PRODUCT	:= selinuxproject:libsepol

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBSEPOL_CONF_TOOL	:= NO
LIBSEPOL_MAKE_ENV	:= $(CROSS_ENV)
LIBSEPOL_MAKE_OPT	:= \
	SHLIBDIR=/usr/lib \
	CFLAGS="-O2 -Wall -g"
LIBSEPOL_INSTALL_OPT	:= \
	$(LIBSEPOL_MAKE_OPT) \
	install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libsepol.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libsepol)
	@$(call install_fixup, libsepol,PRIORITY,optional)
	@$(call install_fixup, libsepol,SECTION,base)
	@$(call install_fixup, libsepol,AUTHOR,"Wolfram Sang <w.sang@pengutronix.de>")
	@$(call install_fixup, libsepol,DESCRIPTION,missing)

	@$(call install_lib, libsepol, 0, 0, 0644, libsepol)

	@$(call install_finish, libsepol)

	@$(call touch)

# vim: syntax=make
