# -*-makefile-*-
#
# Copyright (C) 2017 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_MESON) += host-meson

#
# Paths and names
#
HOST_MESON_VERSION	:= 1.6.0
HOST_MESON_MD5		:= 0031ea392f8ef97eeadfe1906c5cc5b4
HOST_MESON		:= meson-$(HOST_MESON_VERSION)
HOST_MESON_SUFFIX	:= tar.gz
HOST_MESON_URL		:= https://github.com/mesonbuild/meson/releases/download/$(HOST_MESON_VERSION)/$(HOST_MESON).$(HOST_MESON_SUFFIX)
HOST_MESON_SOURCE	:= $(SRCDIR)/$(HOST_MESON).$(HOST_MESON_SUFFIX)
HOST_MESON_DIR		:= $(HOST_BUILDDIR)/$(HOST_MESON)
HOST_MESON_LICENSE	:= Apache-2.0
HOST_MESON_LICENSE_FILES	:= file://COPYING;md5=3b83ef96387f14655fc854ddc3c6bd57

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_MESON_CONF_TOOL	:= python3

$(STATEDIR)/host-meson.install.post: $(PTXDIST_MESON_CROSS_FILE)

# vim: syntax=make
