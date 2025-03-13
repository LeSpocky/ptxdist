# -*-makefile-*-
#
# Copyright (C) 2025 by <benjamin.gaignard@collabora.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_DRM_INFO) += drm-info

#
# Paths and names
#
DRM_INFO_VERSION	:= 2.7.0
DRM_INFO_MD5		:= 0066f5d02007b712d7b21a89e89785ba
DRM_INFO		:= drm_info-v$(DRM_INFO_VERSION)
DRM_INFO_SUFFIX		:= tar.bz2
DRM_INFO_URL		:= https://gitlab.freedesktop.org/emersion/drm_info/-/archive/$(DRM_INFO).$(DRM_INFO_SUFFIX)
DRM_INFO_SOURCE		:= $(SRCDIR)/$(DRM_INFO).$(DRM_INFO_SUFFIX)
DRM_INFO_DIR		:= $(BUILDDIR)/$(DRM_INFO)
DRM_INFO_LICENSE	:= MIT
DRM_INFO_LICENSE_FILES	:= file://LICENSE;md5=32fd56d355bd6a61017655d8da26b67c

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# meson
#
DRM_INFO_CONF_TOOL	:= meson
DRM_INFO_CONF_OPT	:=  \
	$(CROSS_MESON_USR) \
	-Dlibpci=disabled \
	-Dman-pages=disabled

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/drm-info.targetinstall:
	@$(call targetinfo)

	@$(call install_init, drm-info)
	@$(call install_fixup, drm-info,PRIORITY,optional)
	@$(call install_fixup, drm-info,SECTION,base)
	@$(call install_fixup, drm-info,AUTHOR,"Benjamin Gaignard <benjamin.gaignard@collabora.com>")
	@$(call install_fixup, drm-info,DESCRIPTION,missing)

	@$(call install_copy, drm-info, 0, 0, 0755, -, /usr/bin/drm_info)

	@$(call install_finish, drm-info)

	@$(call touch)

# vim: syntax=make
