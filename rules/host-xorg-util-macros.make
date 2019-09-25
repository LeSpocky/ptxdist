# -*-makefile-*-
#
# Copyright (C) 2009 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_XORG_UTIL_MACROS) += host-xorg-util-macros

#
# Paths and names
#
HOST_XORG_UTIL_MACROS_VERSION	:= 1.19.2
HOST_XORG_UTIL_MACROS_MD5	:= 58edef899364f78fbde9479ded20211e
HOST_XORG_UTIL_MACROS		:= util-macros-$(HOST_XORG_UTIL_MACROS_VERSION)
HOST_XORG_UTIL_MACROS_SUFFIX	:= tar.bz2
HOST_XORG_UTIL_MACROS_URL	:= $(call ptx/mirror, XORG, individual/util/$(HOST_XORG_UTIL_MACROS).$(HOST_XORG_UTIL_MACROS_SUFFIX))
HOST_XORG_UTIL_MACROS_SOURCE	:= $(SRCDIR)/$(HOST_XORG_UTIL_MACROS).$(HOST_XORG_UTIL_MACROS_SUFFIX)
HOST_XORG_UTIL_MACROS_DIR	:= $(HOST_BUILDDIR)/$(HOST_XORG_UTIL_MACROS)
HOST_XORG_UTIL_MACROS_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_XORG_UTIL_MACROS_CONF_TOOL := autoconf

# vim: syntax=make
