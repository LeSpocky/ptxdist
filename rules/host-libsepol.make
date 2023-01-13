# -*-makefile-*-
#
# Copyright (C) 2013 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_LIBSEPOL) += host-libsepol

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_LIBSEPOL_CONF_TOOL := NO
HOST_LIBSEPOL_MAKE_ENV := \
	$(HOST_ENV) \
	SHLIBDIR=$(HOST_LIBSEPOL_PKGDIR)/usr/lib \
	CFLAGS="-O2 -Wall -g"

# vim: syntax=make
