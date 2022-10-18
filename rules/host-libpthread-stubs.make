# -*-makefile-*-
#
# Copyright (C) 2007 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_LIBPTHREAD_STUBS) += host-libpthread-stubs

#
# Paths and names
#
HOST_LIBPTHREAD_STUBS_DIR	= $(HOST_BUILDDIR)/$(LIBPTHREAD_STUBS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_LIBPTHREAD_STUBS_CONF_TOOL	:= autoconf

# vim: syntax=make
