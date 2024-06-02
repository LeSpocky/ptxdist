# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
# Copyright (C) 2009 by Wolfram Sang, Pengutronix
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PCIUTILS) += pciutils

#
# Paths and names
#
PCIUTILS_VERSION	:= 3.13.0
PCIUTILS_MD5		:= 03cf42b53406618b35782a1fb729e330
PCIUTILS		:= pciutils-$(PCIUTILS_VERSION)
PCIUTILS_SUFFIX		:= tar.gz
PCIUTILS_URL		:= https://github.com/pciutils/pciutils/archive/refs/tags/v$(PCIUTILS_VERSION).$(PCIUTILS_SUFFIX)
PCIUTILS_SOURCE		:= $(SRCDIR)/$(PCIUTILS).$(PCIUTILS_SUFFIX)
PCIUTILS_DIR		:= $(BUILDDIR)/$(PCIUTILS)
PCIUTILS_LICENSE	:= GPL-2.0-or-later
PCIUTILS_LICENSE_FILES	:= \
	file://README;startline=4;endline=8;md5=2ae7724797a960932b288272eed49a30

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PCIUTILS_CONF_TOOL	:= NO
PCIUTILS_MAKE_ENV	:= $(CROSS_ENV)

PCIUTILS_MAKE_OPT := \
	CROSS_COMPILE=$(COMPILER_PREFIX) \
	PREFIX=/usr \
	SBINDIR=/usr/bin \
	HOST=$(PTXCONF_ARCH_STRING)-linux \
	RELEASE=$(KERNEL_HEADER_VERSION) \
	ZLIB=no \
	LIBKMOD=$(call ptx/yesno, PTXCONF_PCIUTILS_LIBKMOD) \
	SHARED=$(call ptx/yesno, PTXCONF_PCIUTILS_LIBPCI) \
	STRIP= \
	DNS=no \
	HWDB=$(call ptx/yesno, PTXCONF_PCIUTILS_HWDB)

PCIUTILS_INSTALL_OPT := \
	$(PCIUTILS_MAKE_OPT) \
	install \
	$(call ptx/ifdef,PTXCONF_PCIUTILS_LIBPCI,install-lib,)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/pciutils.targetinstall:
	@$(call targetinfo)

	@$(call install_init, pciutils)
	@$(call install_fixup, pciutils,PRIORITY,optional)
	@$(call install_fixup, pciutils,SECTION,base)
	@$(call install_fixup, pciutils,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, pciutils,DESCRIPTION,missing)

ifdef PTXCONF_PCIUTILS_TOOLS
	@$(call install_copy, pciutils, 0, 0, 0755, -, /usr/bin/lspci)
	@$(call install_copy, pciutils, 0, 0, 0755, -, /usr/bin/setpci)
endif

ifdef PTXCONF_PCIUTILS_LIBPCI
	@$(call install_lib, pciutils, 0, 0, 0644, libpci)
endif

	@$(call install_finish, pciutils)

	@$(call touch)

# vim: syntax=make
