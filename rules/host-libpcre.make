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
HOST_PACKAGES-$(PTXCONF_HOST_LIBPCRE) += host-libpcre

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_LIBPCRE_CONF_TOOL := autoconf
HOST_LIBPCRE_CONF_OPT :=\
	 $(HOST_AUTOCONF) \
	--disable-pcregrep-libz \
	--disable-pcregrep-libbz2 \
	--enable-utf8 \
	--enable-unicode-properties

# vim: syntax=make
