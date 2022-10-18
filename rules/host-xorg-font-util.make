# -*-makefile-*-
#
# Copyright (C) 2006 by Luotao Fu <lfu@pengutronix.de>
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_XORG_FONT_UTIL) += host-xorg-font-util

#
# Paths and names
#
HOST_XORG_FONT_UTIL_DIR	= $(HOST_BUILDDIR)/$(XORG_FONT_UTIL)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_XORG_FONT_UTIL_CONF_TOOL := autoconf

# vim: syntax=make
