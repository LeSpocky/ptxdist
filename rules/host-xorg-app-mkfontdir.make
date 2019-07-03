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
HOST_PACKAGES-$(PTXCONF_HOST_XORG_APP_MKFONTDIR) += host-xorg-app-mkfontdir

#
# Paths and names
#
HOST_XORG_APP_MKFONTDIR_DIR	= $(HOST_BUILDDIR)/$(XORG_APP_MKFONTDIR)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_XORG_APP_MKFONTDIR_CONF_TOOL	:= autoconf

# vim: syntax=make
