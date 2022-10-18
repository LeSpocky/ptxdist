# -*-makefile-*-
#
# Copyright (C) 2007, 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_LIBPNG) += host-libpng

#
# Paths and names
#
HOST_LIBPNG_DIR	= $(HOST_BUILDDIR)/$(LIBPNG)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_LIBPNG_CONF_TOOL := autoconf

# vim: syntax=make
