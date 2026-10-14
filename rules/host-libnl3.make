# -*-makefile-*-
#
# Copyright (C) 2026 by Sven Püschel <s.pueschel@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_LIBNL3) += host-libnl3

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_LIBNL3_CONF_TOOL	:= autoconf
HOST_LIBNL3_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--enable-shared \
	--disable-static \
	--disable-cli \
	--disable-pthreads \
	--disable-debug

# vim: syntax=make
