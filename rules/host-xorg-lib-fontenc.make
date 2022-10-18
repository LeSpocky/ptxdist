# -*-makefile-*-
#
# Copyright (C) 2006 by Marc Kleine-Budde <mkl@pengutronix.de>
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_XORG_LIB_FONTENC) += host-xorg-lib-fontenc

#
# Paths and names
#
HOST_XORG_LIB_FONTENC_DIR	= $(HOST_BUILDDIR)/$(XORG_LIB_FONTENC)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_XORG_LIB_FONTENC_CONF_TOOL	:= autoconf

# vim: syntax=make
