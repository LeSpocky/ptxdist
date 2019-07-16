# -*-makefile-*-
#
# Copyright (C) 2008, 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_LIBGD) += host-libgd

#
# Paths and names
#
HOST_LIBGD_DIR	= $(HOST_BUILDDIR)/$(LIBGD)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_LIBGD_PATH	:= PATH=$(HOST_PATH)
HOST_LIBGD_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_LIBGD_AUTOCONF	:= \
	$(HOST_AUTOCONF) \
	--without-x \
	--without-jpeg \
	--with-png=$(PTXDIST_SYSROOT_HOST) \
	--without-xpm \
	--without-freetype \
	--without-fontconfig

# vim: syntax=make
