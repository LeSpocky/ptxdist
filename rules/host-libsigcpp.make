# -*-makefile-*-
#
# Copyright (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_LIBSIGCPP) += host-libsigcpp

#
# Paths and names
#
HOST_LIBSIGCPP_DIR	= $(HOST_BUILDDIR)/$(LIBSIGCPP)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_LIBSIGCPP_PATH	:= PATH=$(HOST_PATH)
HOST_LIBSIGCPP_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_LIBSIGCPP_AUTOCONF	:= $(HOST_AUTOCONF)

# vim: syntax=make
