# -*-makefile-*-
#
# Copyright (C) 2018 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORGPROTO) += xorgproto

#
# Paths and names
#
XORGPROTO_VERSION	:= 2023.1
XORGPROTO_MD5		:= c1ba00071316114b7dac58a2aa9b81db
XORGPROTO		:= xorgproto-$(XORGPROTO_VERSION)
XORGPROTO_SUFFIX	:= tar.xz
XORGPROTO_URL		:= $(call ptx/mirror, XORG, individual/proto/$(XORGPROTO).$(XORGPROTO_SUFFIX))
XORGPROTO_SOURCE	:= $(SRCDIR)/$(XORGPROTO).$(XORGPROTO_SUFFIX)
XORGPROTO_DIR		:= $(BUILDDIR)/$(XORGPROTO)
XORGPROTO_LICENSE	:= X11 AND MIT AND BSD-2-Clause

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORGPROTO_CONF_TOOL	:= meson
XORGPROTO_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Dlegacy=true

# vim: syntax=make
