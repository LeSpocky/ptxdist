# -*-makefile-*-
#
# Copyright (C) 2016 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_WAYLAND_PROTOCOLS) += wayland-protocols

#
# Paths and names
#
WAYLAND_PROTOCOLS_VERSION	:= 1.25
WAYLAND_PROTOCOLS_MD5		:= 0c192bf32de09ec30de4a82d1c65329c
WAYLAND_PROTOCOLS		:= wayland-protocols-$(WAYLAND_PROTOCOLS_VERSION)
WAYLAND_PROTOCOLS_SUFFIX	:= tar.xz
WAYLAND_PROTOCOLS_URL		:= https://wayland.freedesktop.org/releases/$(WAYLAND_PROTOCOLS).$(WAYLAND_PROTOCOLS_SUFFIX)
WAYLAND_PROTOCOLS_SOURCE	:= $(SRCDIR)/$(WAYLAND_PROTOCOLS).$(WAYLAND_PROTOCOLS_SUFFIX)
WAYLAND_PROTOCOLS_DIR		:= $(BUILDDIR)/$(WAYLAND_PROTOCOLS)
WAYLAND_PROTOCOLS_LICENSE	:= MIT

#
# meson
#
WAYLAND_PROTOCOLS_CONF_TOOL	:= meson
WAYLAND_PROTOCOLS_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Dtests=false

# vim: syntax=make
