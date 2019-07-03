# -*-makefile-*-
#
# Copyright (C) 2007 by Robert Schwebel
#               2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_LIBXSLT) += host-libxslt

#
# Paths and names
#
HOST_LIBXSLT_DIR	= $(HOST_BUILDDIR)/$(LIBXSLT)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_LIBXSLT_PATH	:= PATH=$(HOST_PATH)
HOST_LIBXSLT_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_LIBXSLT_AUTOCONF := \
	$(HOST_AUTOCONF) \
	--disable-static \
	--without-crypto \
	--without-python

# vim: syntax=make
