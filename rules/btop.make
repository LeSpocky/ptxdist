# -*-makefile-*-
#
# Copyright (C) 2024 by Philipp Zabel <p.zabel@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BTOP) += btop

#
# Paths and names
#
BTOP_VERSION	:= 1.3.2
BTOP_MD5	:= 04ff8d32e7bf748705fe34dfea50c628
BTOP		:= btop-$(BTOP_VERSION)
BTOP_SUFFIX	:= tar.gz
BTOP_URL	:= https://github.com/aristocratos/btop/archive/v$(BTOP_VERSION).$(BTOP_SUFFIX)
BTOP_SOURCE	:= $(SRCDIR)/$(BTOP).$(BTOP_SUFFIX)
BTOP_DIR	:= $(BUILDDIR)/$(BTOP)
BTOP_LICENSE	:= Apache-2.0
BTOP_LICENSE_FILES := \
	file://LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

BTOP_CONF_TOOL	:= cmake
BTOP_CONF_OPT	:= \
	$(CROSS_CMAKE_USR) \
	-DBTOP_FORTIFY=ON \
	-DBTOP_GPU=ON \
	-DBTOP_LTO=OFF \
	-DBTOP_PEDANTIC=OFF \
	-DBTOP_RSMI_STATIC=OFF \
	-DBTOP_STATIC=OFF \
	-DBTOP_USE_MOLD=OFF \
	-DBTOP_WERROR=OFF

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/btop.targetinstall:
	@$(call targetinfo)

	@$(call install_init, btop)
	@$(call install_fixup, btop,PRIORITY,optional)
	@$(call install_fixup, btop,SECTION,base)
	@$(call install_fixup, btop,AUTHOR,"Philipp Zabel <p.zabel@pengutronix.de>")
	@$(call install_fixup, btop,DESCRIPTION,A monitor of resources)

	@$(call install_copy, btop, 0, 0, 0755, -, /usr/bin/btop)
	@$(call install_tree, btop, 0, 0, -, /usr/share/btop/themes)

	@$(call install_finish, btop)

	@$(call touch)

# vim: syntax=make
