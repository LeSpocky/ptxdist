# -*-makefile-*-
#
# Copyright (C) 2025 by Roman Schnider <r.schnider@cab.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ZINT) += zint

#
# Paths and names
#
ZINT_VERSION		:= 2.15.0
ZINT_MD5		:= ea0065f7ea67fca17a443bc064252340
ZINT			:= zint-$(ZINT_VERSION)
ZINT_SUFFIX		:= tar.gz
ZINT_URL		:= https://sourceforge.net/projects/zint/files/zint/$(ZINT_VERSION)/$(ZINT)-src.$(ZINT_SUFFIX)
ZINT_SOURCE		:= $(SRCDIR)/$(ZINT).$(ZINT_SUFFIX)
ZINT_DIR		:= $(BUILDDIR)/$(ZINT)
ZINT_LICENSE		:= BSD-3-Clause AND GPL-3.0-or-later
ZINT_LICENSE_FILES	:= file://LICENSE;md5=7a60e5da828a98fbdf48c9a327c7cdfa \
			   file://frontend/COPYING;md5=d32239bcb673463ab874e80d47fae504

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# cmake
#
ZINT_CONF_TOOL	:= cmake
ZINT_CONF_OPT	:= $(CROSS_CMAKE_USR) \
	-DZINT_COVERAGE=OFF \
	-DZINT_DEBUG=OFF \
	-DZINT_FRONTEND=$(call ptx/onoff,PTXCONF_ZINT_FRONTEND) \
	-DZINT_NOOPT=OFF \
	-DZINT_SANITIZE=OFF \
	-DZINT_SHARED=ON \
	-DZINT_STATIC=OFF \
	-DZINT_TEST=OFF \
	-DZINT_UNINSTALL=OFF \
	-DZINT_USE_PNG=$(call ptx/onoff,PTXCONF_ZINT_FRONTEND) \
	-DZINT_USE_QT=OFF

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/zint.targetinstall:
	@$(call targetinfo)

	@$(call install_init, zint)
	@$(call install_fixup, zint, PRIORITY, optional)
	@$(call install_fixup, zint, SECTION, base)
	@$(call install_fixup, zint, AUTHOR, "Roman Schnider <r.schnider@cab.de>")
	@$(call install_fixup, zint, DESCRIPTION, missing)

	@$(call install_lib, zint, 0, 0, 0644, libzint)

ifdef PTXCONF_ZINT_FRONTEND
	@$(call install_copy, zint, 0, 0, 0755, -, /usr/bin/zint)
endif

	@$(call install_finish, zint)

	@$(call touch)

# vim: syntax=make
