# -*-makefile-*-
#
# Copyright (C) 2012 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_LIBCONFUSE) += host-libconfuse

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_LIBCONFUSE_CONF_TOOL	:= autoconf
HOST_LIBCONFUSE_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--disable-examples \
	--disable-nls \
	--enable-shared

# vim: syntax=make
