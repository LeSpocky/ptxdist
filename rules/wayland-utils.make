# -*-makefile-*-
#
# Copyright (C) 2020 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_WAYLAND_UTILS) += wayland-utils

#
# Paths and names
#
WAYLAND_UTILS_VERSION		:= 1.2.0
WAYLAND_UTILS_MD5		:= 736dbcefc534407d4e774087726844a1
WAYLAND_UTILS			:= wayland-utils-$(WAYLAND_UTILS_VERSION)
WAYLAND_UTILS_SUFFIX		:= tar.xz
WAYLAND_UTILS_URL		:= https://gitlab.freedesktop.org/wayland/wayland-utils/-/releases/$(WAYLAND_UTILS_VERSION)/downloads/$(WAYLAND_UTILS).$(WAYLAND_UTILS_SUFFIX)
WAYLAND_UTILS_SOURCE		:= $(SRCDIR)/$(WAYLAND_UTILS).$(WAYLAND_UTILS_SUFFIX)
WAYLAND_UTILS_DIR		:= $(BUILDDIR)/$(WAYLAND_UTILS)
WAYLAND_UTILS_LICENSE		:= MIT
WAYLAND_UTILS_LICENSE_FILES	:= file://COPYING;md5=548a66038a77415e1df51118625e832f

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# meson
#
WAYLAND_UTILS_CONF_TOOL	:= meson
WAYLAND_UTILS_CONF_OPT	:=  \
	$(CROSS_MESON_USR) \
	-Ddrm=enabled

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/wayland-utils.targetinstall:
	@$(call targetinfo)

	@$(call install_init, wayland-utils)
	@$(call install_fixup, wayland-utils,PRIORITY,optional)
	@$(call install_fixup, wayland-utils,SECTION,base)
	@$(call install_fixup, wayland-utils,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, wayland-utils,DESCRIPTION,missing)

	@$(call install_copy, wayland-utils, 0, 0, 0755, -, /usr/bin/wayland-info)

	@$(call install_finish, wayland-utils)

	@$(call touch)

# vim: syntax=make
