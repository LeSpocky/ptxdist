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
WLROOTS_VERSION	:= 0.16.0
WLROOTS_SHA256	:= 3be91163208577761969a8ae499d737c4dbb764f73c46aa8f76a512ee36b7da4
WLROOTS		:= wlroots-$(WLROOTS_VERSION)
WLROOTS_SUFFIX	:= tar.bz2
WLROOTS_URL	:= https://gitlab.freedesktop.org/wlroots/wlroots/-/archive/$(WLROOTS_VERSION)/$(WLROOTS).$(WLROOTS_SUFFIX)
WLROOTS_SOURCE	:= $(SRCDIR)/$(WLROOTS).$(WLROOTS_SUFFIX)
WLROOTS_DIR	:= $(BUILDDIR)/$(WLROOTS)
WLROOTS_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

WLROOTS_CONF_TOOL := meson
WLROOTS_CONF_OPT := \
	$(CROSS_MESON_USR) \
	-Dwerror=false \
	-Dallocators=gbm \
	-Dbackends=drm,libinput \
	-Dexamples=false \
	-Dicon_directory= \
	-Drenderers=gles2 \
	-Dxcb-errors=disabled \
	-Dxwayland=$(call ptx/endis,PTXCONF_WLROOTS_XWAYLAND)d

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
