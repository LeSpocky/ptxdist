# -*-makefile-*-
#
# Copyright (C) 2013 by Philipp Zabel <p.zabel@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_WAYLAND) += wayland

#
# Paths and names
#
WAYLAND_VERSION	:= 1.23.1
WAYLAND_MD5	:= 5d27c7d3658fa90f40111b47cdb4a8fb
WAYLAND		:= wayland-$(WAYLAND_VERSION)
WAYLAND_SUFFIX	:= tar.xz
WAYLAND_URL	:= https://gitlab.freedesktop.org/wayland/wayland/-/releases/$(WAYLAND_VERSION)/downloads/$(WAYLAND).$(WAYLAND_SUFFIX)
WAYLAND_SOURCE	:= $(SRCDIR)/$(WAYLAND).$(WAYLAND_SUFFIX)
WAYLAND_DIR	:= $(BUILDDIR)/$(WAYLAND)
WAYLAND_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

WAYLAND_CONF_ENV	:= \
	$(HOST_ENV) \
	PKG_CONFIG_FOR_BUILD=$(PTXDIST_SYSROOT_HOST)/usr/bin/pkg-config

#
# meson
#
WAYLAND_CONF_TOOL	:= meson
WAYLAND_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Ddocumentation=false \
	-Ddtd_validation=false \
	-Dicon_directory= \
	-Dlibraries=true \
	-Dscanner=true \
	-Dtests=false

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/wayland.install.post:
	@$(call targetinfo)
#	# target wayland-scanner is not needed. Make sure nobody tries to use it
	@rm -f $(WAYLAND_PKGDIR)/usr/bin/wayland-scanner
	@$(call world/install.post, WAYLAND)
	@sed 's;^prefix=.*;prefix=$(PTXDIST_SYSROOT_HOST)/usr;' \
		$(PTXDIST_SYSROOT_HOST)/usr/lib/pkgconfig/wayland-scanner.pc \
		> $(PTXDIST_SYSROOT_TARGET)/usr/lib/pkgconfig/wayland-scanner.pc
	@$(call touch)
# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/wayland.targetinstall:
	@$(call targetinfo)

	@$(call install_init, wayland)
	@$(call install_fixup, wayland,PRIORITY,optional)
	@$(call install_fixup, wayland,SECTION,base)
	@$(call install_fixup, wayland,AUTHOR,"Philipp Zabel <p.zabel@pengutronix.de>")
	@$(call install_fixup, wayland,DESCRIPTION,wayland client and server libraries)

	@$(call install_lib, wayland, 0, 0, 0644, libwayland-client)
	@$(call install_lib, wayland, 0, 0, 0644, libwayland-server)
	@$(call install_lib, wayland, 0, 0, 0644, libwayland-cursor)
	@$(call install_lib, wayland, 0, 0, 0644, libwayland-egl)

	@$(call install_finish, wayland)

	@$(call touch)

# vim: syntax=make
