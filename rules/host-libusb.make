# -*-makefile-*-
#
# Copyright (C) 2012 by Juergen Beisert <jbe@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_LIBUSB) += host-libusb

#
# Paths and names
#

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_LIBUSB_CONF_TOOL := autoconf
HOST_LIBUSB_CONF_OPT := \
	$(HOST_AUTOCONF) \
	--enable-shared \
	--disable-static \
	--disable-udev \
	--enable-eventfd \
	--enable-timerfd \
	--enable-log \
	--disable-debug-log \
	--disable-system-log \
	--disable-examples-build \
	--disable-tests-build

# vim: syntax=make
