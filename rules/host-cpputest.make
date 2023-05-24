# -*-makefile-*-
#
# Copyright (C) 2023 by Roland Hieber <rhi@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_CPPUTEST) += host-cpputest

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_CPPUTEST_CONF_TOOL	:= autoconf
CPPUTEST_CONF_OPT	:=  \
	$(HOST_AUTOCONF_USR) \
	--enable-std-c \
	--enable-std-cpp \
	--enable-std-cpp11 \
	--enable-cpputest-flags \
	--enable-memory-leak-detection \
	--enable-extensions \
	--enable-longlong \
	--enable-generate-map-file \
	--enable-coverage

# vim: syntax=make
