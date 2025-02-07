# -*-makefile-*-
#
# Copyright (C) 2025 by Philipp Zabel <p.zabel@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_VKMARK) += vkmark

#
# Paths and names
#
VKMARK_VERSION		:= 2025.01
VKMARK_MD5		:= c36c2953f99004e72aca985c0a6507d3
VKMARK			:= vkmark-$(VKMARK_VERSION)
VKMARK_SUFFIX		:= tar.gz
VKMARK_URL		:= https://github.com/vkmark/vkmark/archive/refs/tags/$(VKMARK_VERSION).$(VKMARK_SUFFIX)
VKMARK_SOURCE		:= $(SRCDIR)/$(VKMARK).$(VKMARK_SUFFIX)
VKMARK_DIR		:= $(BUILDDIR)/$(VKMARK)
VKMARK_LICENSE		:= LGPL-2.1-or-later
VKMARK_LICENSE_FILES	:= file://COPYING-LGPL2.1;md5=4fbd65380cdd255951079008b364516c

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

VKMARK_CONF_TOOL	:= meson
VKMARK_CONF_OPT		:= \
	$(CROSS_MESON_USR) \
	-Dkms=true \
	-Dwayland=$(call ptx/truefalse,PTXCONF_VKMARK_WAYLAND) \
	-Dxcb=$(call ptx/truefalse,PTXCONF_VKMARK_XCB)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/vkmark.targetinstall:
	@$(call targetinfo)

	@$(call install_init, vkmark)
	@$(call install_fixup, vkmark, PRIORITY, optional)
	@$(call install_fixup, vkmark, SECTION, base)
	@$(call install_fixup, vkmark, AUTHOR, "Philipp Zabel <p.zabel@pengutronix.de>")
	@$(call install_fixup, vkmark, DESCRIPTION, missing)

	$(call install_copy, vkmark, 0, 0, 0755, -, /usr/bin/vkmark)

	$(call install_copy, vkmark, 0, 0, 0755, -, /usr/lib/vkmark/display.so)
	$(call install_copy, vkmark, 0, 0, 0755, -, /usr/lib/vkmark/headless.so)
	$(call install_copy, vkmark, 0, 0, 0755, -, /usr/lib/vkmark/kms.so)
ifdef PTXCONF_VKMARK_WAYLAND
	$(call install_copy, vkmark, 0, 0, 0755, -, /usr/lib/vkmark/wayland.so)
endif
ifdef PTXCONF_VKMARK_XCB
	$(call install_copy, vkmark, 0, 0, 0755, -, /usr/lib/vkmark/xcb.so)
endif

	$(call install_tree, vkmark, 0, 0, -, /usr/share/vkmark)

	@$(call install_finish, vkmark)

	@$(call touch)

# vim: syntax=make
