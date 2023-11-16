# -*-makefile-*-
#
# Copyright (C) 2015 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GLIB_NETWORKING) += glib-networking

#
# Paths and names
#
GLIB_NETWORKING_VERSION	:= 2.78.0
GLIB_NETWORKING_MD5	:= 402ff1e8f24dafb02354d9b66ffa11df
GLIB_NETWORKING		:= glib-networking-$(GLIB_NETWORKING_VERSION)
GLIB_NETWORKING_SUFFIX	:= tar.xz
GLIB_NETWORKING_URL	:= $(call ptx/mirror, GNOME, glib-networking/$(basename $(GLIB_NETWORKING_VERSION))/$(GLIB_NETWORKING).$(GLIB_NETWORKING_SUFFIX))
GLIB_NETWORKING_SOURCE	:= $(SRCDIR)/$(GLIB_NETWORKING).$(GLIB_NETWORKING_SUFFIX)
GLIB_NETWORKING_DIR	:= $(BUILDDIR)/$(GLIB_NETWORKING)
GLIB_NETWORKING_LICENSE	:= LGPL-2.0-or-later
GLIB_NETWORKING_LICENSE_FILES := \
	file://tls/gnutls/gnutls-module.c;startline=2;endline=23;md5=2eca03d4880fd21dbb04b8bcafe2cd59 \
	file://COPYING;md5=4fbd65380cdd255951079008b364516c

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GLIB_NETWORKING_CONF_ENV	:= \
	PTXDIST_PKG_CONFIG_VAR_NO_SYSROOT=giomoduledir

#
# meson
#
GLIB_NETWORKING_CONF_TOOL	:= meson
GLIB_NETWORKING_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Dgnome_proxy=disabled \
	-Dgnutls=enabled \
	-Dinstalled_tests=false \
	-Dlibproxy=disabled \
	-Dopenssl=disabled

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/glib-networking.targetinstall:
	@$(call targetinfo)

	@$(call install_init, glib-networking)
	@$(call install_fixup, glib-networking,PRIORITY,optional)
	@$(call install_fixup, glib-networking,SECTION,base)
	@$(call install_fixup, glib-networking,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, glib-networking,DESCRIPTION,missing)

	@$(call install_lib, glib-networking, 0, 0, 0644, gio/modules/libgiognutls)

	@$(call install_finish, glib-networking)

	@$(call touch)

# vim: syntax=make
