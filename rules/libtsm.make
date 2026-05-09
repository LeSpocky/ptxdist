# -*-makefile-*-
#
# Copyright (C) 2026 by Philipp Zabel <p.zabel@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBTSM) += libtsm

#
# Paths and names
#
LIBTSM_VERSION		:= 4.4.1
LIBTSM_SHA256		:= 20f5c6fd69c4a701c25981ad6f3976f2578cdffb4b138c341b85d3a3b8a0017c
LIBTSM			:= libtsm-$(LIBTSM_VERSION)
LIBTSM_SUFFIX		:= tar.gz
LIBTSM_URL		:= https://github.com/kmscon/libtsm/archive/refs/tags/v$(LIBTSM_VERSION).$(LIBTSM_SUFFIX)
LIBTSM_SOURCE		:= $(SRCDIR)/$(LIBTSM).$(LIBTSM_SUFFIX)
LIBTSM_DIR		:= $(BUILDDIR)/$(LIBTSM)
LIBTSM_LICENSE		:= MIT AND BSD-2-Clause
LIBTSM_LICENSE_FILES	:= file://COPYING;md5=69e8256cdc4e949f86fedf94b1b320b4

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# meson
#
LIBTSM_CONF_TOOL	:= meson
LIBTSM_CONF_OPT		:=  \
	$(CROSS_MESON_USR) \
	-Dextra_debug=false \
	-Dtests=false \
	-Dgtktsm=false

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libtsm.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libtsm)
	@$(call install_fixup, libtsm,PRIORITY,optional)
	@$(call install_fixup, libtsm,SECTION,base)
	@$(call install_fixup, libtsm,AUTHOR,"Philipp Zabel <p.zabel@pengutronix.de>")
	@$(call install_fixup, libtsm,DESCRIPTION,missing)

	@$(call install_lib, libtsm, 0, 0, 0644, libtsm)

	@$(call install_finish, libtsm)

	@$(call touch)

# vim: ft=make
