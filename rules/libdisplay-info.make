# -*-makefile-*-
#
# Copyright (C) 2023 by Philipp Zabel <p.zabel@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBDISPLAY_INFO) += libdisplay-info

#
# Paths and names
#
LIBDISPLAY_INFO_VERSION		:= 0.1.1
LIBDISPLAY_INFO_MD5		:= 56e8d2213d2aefd7defaaddfd9cb80e1
LIBDISPLAY_INFO			:= libdisplay-info-$(LIBDISPLAY_INFO_VERSION)
LIBDISPLAY_INFO_SUFFIX		:= tar.xz
LIBDISPLAY_INFO_URL		:= https://gitlab.freedesktop.org/emersion/libdisplay-info/-/releases/$(LIBDISPLAY_INFO_VERSION)/downloads/$(LIBDISPLAY_INFO).$(LIBDISPLAY_INFO_SUFFIX)
LIBDISPLAY_INFO_SOURCE		:= $(SRCDIR)/$(LIBDISPLAY_INFO).$(LIBDISPLAY_INFO_SUFFIX)
LIBDISPLAY_INFO_DIR		:= $(BUILDDIR)/$(LIBDISPLAY_INFO)
LIBDISPLAY_INFO_LICENSE		:= MIT
LIBDISPLAY_INFO_LICENSE_FILES	:= \
	file://LICENSE;md5=e4426409957080ee0352128354cea2de

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# meson
#
LIBDISPLAY_INFO_CONF_TOOL := meson
LIBDISPLAY_INFO_CONF_OPT := \
	$(CROSS_MESON_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libdisplay-info.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libdisplay-info)
	@$(call install_fixup, libdisplay-info,PRIORITY,optional)
	@$(call install_fixup, libdisplay-info,SECTION,base)
	@$(call install_fixup, libdisplay-info,AUTHOR,"Philipp Zabel <p.zabel@pengutronix.de>")
	@$(call install_fixup, libdisplay-info,DESCRIPTION,missing)

	@$(call install_lib, libdisplay-info, 0, 0, 0644, libdisplay-info)

	@$(call install_finish, libdisplay-info)

	@$(call touch)

# vim: syntax=make
