# -*-makefile-*-
#
# Copyright (C) 2025 by Alexander Dahl <ada@thorsis.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PHYTOOL) += phytool

#
# Paths and names
#
PHYTOOL_VERSION	:= 2
PHYTOOL_MD5	:= 972982f8e5f7237cbccfc6d275da7348
PHYTOOL		:= phytool-$(PHYTOOL_VERSION)
PHYTOOL_SUFFIX	:= tar.xz
PHYTOOL_URL	:= https://github.com/wkz/phytool/releases/download/v$(PHYTOOL_VERSION)/$(PHYTOOL).$(PHYTOOL_SUFFIX)
PHYTOOL_SOURCE	:= $(SRCDIR)/$(PHYTOOL).$(PHYTOOL_SUFFIX)
PHYTOOL_DIR	:= $(BUILDDIR)/$(PHYTOOL)
PHYTOOL_LICENSE	:= GPL-2.0-or-later
PHYTOOL_LICENSE_FILES := \
	file://LICENSE;md5=39bba7d2cf0ba1036f2a6e2be52fe3f0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PHYTOOL_CONF_TOOL	:= NO

PHYTOOL_MAKE_ENV	:= $(CROSS_ENV)
PHYTOOL_MAKE_OPT	:= \
	PREFIX=/usr \
	all

PHYTOOL_INSTALL_OPT	:= \
	PREFIX=/usr \
	DESTDIR=$(PHYTOOL_PKGDIR) \
	install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/phytool.targetinstall:
	@$(call targetinfo)

	@$(call install_init, phytool)
	@$(call install_fixup, phytool,PRIORITY,optional)
	@$(call install_fixup, phytool,SECTION,base)
	@$(call install_fixup, phytool,AUTHOR,"Alexander Dahl <ada@thorsis.com>")
	@$(call install_fixup, phytool,DESCRIPTION,missing)

	@$(call install_copy, phytool, 0, 0, 0755, -, /usr/bin/phytool)

	@$(call install_finish, phytool)

	@$(call touch)

# vim: ft=make
