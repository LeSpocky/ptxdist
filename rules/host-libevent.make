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
HOST_PACKAGES-$(PTXCONF_HOST_LIBEVENT) += host-libevent

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_LIBEVENT_CONF_TOOL	:= autoconf
HOST_LIBEVENT_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--disable-gcc-warnings \
	--enable-gcc-hardening \
	--enable-thread-support \
	--disable-malloc-replacement \
	--disable-openssl \
	--disable-debug-mode \
	--enable-libevent-install \
	--disable-libevent-regress \
	--disable-samples \
	--enable-function-sections \
	--disable-verbose-debug \
	--enable-clock-gettime

# vim: syntax=make
