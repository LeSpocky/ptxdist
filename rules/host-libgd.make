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

#
# autoconf
#
HOST_LIBGD_CONF_TOOL	:= autoconf
HOST_LIBGD_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--without-x \
	--without-jpeg \
	--with-png=$(PTXDIST_SYSROOT_HOST) \
	--without-xpm \
	--without-freetype \
	--without-fontconfig

# vim: syntax=make
