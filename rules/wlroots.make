# -*-makefile-*-
#
# Copyright (C) 2019 by Michael Tretter <m.tretter@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_WLROOTS) += wlroots

#
# Paths and names
#
WLROOTS_VERSION	:= 0.14.1
WLROOTS_MD5	:= 3fbe8f81d2ba59362f041940869ed1e2
WLROOTS		:= wlroots-$(WLROOTS_VERSION)
WLROOTS_SUFFIX	:= tar.gz
WLROOTS_URL	:= https://github.com/swaywm/wlroots/archive/$(WLROOTS_VERSION).$(WLROOTS_SUFFIX)
WLROOTS_SOURCE	:= $(SRCDIR)/$(WLROOTS).$(WLROOTS_SUFFIX)
WLROOTS_DIR	:= $(BUILDDIR)/$(WLROOTS)
WLROOTS_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

WLROOTS_CONF_TOOL := meson
WLROOTS_CONF_OPT := \
	$(CROSS_MESON_USR) \
	-Dexamples=false \
	-Dicon_directory= \
	-Drenderers=gles2 \
	-Dx11-backend=disabled \
	-Dxcb-errors=disabled \
	-Dxwayland=disabled

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/wlroots.targetinstall:
	@$(call targetinfo)

	@$(call install_init, wlroots)
	@$(call install_fixup, wlroots,PRIORITY,optional)
	@$(call install_fixup, wlroots,SECTION,base)
	@$(call install_fixup, wlroots,AUTHOR,"Michael Tretter <m.tretter@pengutronix.de>")
	@$(call install_fixup, wlroots,DESCRIPTION,missing)

	@$(call install_lib, wlroots, 0, 0, 0644, libwlroots)

	@$(call install_finish, wlroots)

	@$(call touch)

# vim: syntax=make
