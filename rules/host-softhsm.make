# -*-makefile-*-
#
# Copyright (C) 2018 by Juergen Borleis <jbe@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_SOFTHSM) += host-softhsm

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_SOFTHSM_CONF_TOOL	:= autoconf
HOST_SOFTHSM_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--disable-non-paged-memory \
	--disable-gost \
	--with-crypto-backend=openssl \
	--with-objectstore-backend-db \
	--without-migrate \
	--with-p11-kit=/share/p11-kit/modules
HOST_SOFTHSM_CPPFLAGS := \
	-DDEBUG_LOG_STDERR=1

# vim: syntax=make
