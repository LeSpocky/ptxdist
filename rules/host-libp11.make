# -*-makefile-*-
#
# Copyright (C) 2016 by Steffen Trumtrar <s.trumtrar@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_LIBP11) += host-libp11

#
# Paths and names
#

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_LIBP11_CONF_TOOL	:= autoconf
HOST_LIBP11_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--disable-strict \
	--disable-pedantic \
	--disable-api-doc \
	--with-enginesdir=/usr/lib/engines-3 \
	--with-pkcs11-module=

HOST_LIBP11_MAKE_PAR	:= NO

# vim: syntax=make
