# -*-makefile-*-
#
# Copyright (C) 2011 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_XORG_APP_XKBCOMP) += host-xorg-app-xkbcomp

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_XORG_APP_XKBCOMP_CONF_TOOL	:= autoconf

HOST_XORG_APP_XKBCOMP_MAKE_ENV	:= \
	ICECC_REMOTE_CPP=0

# vim: syntax=make
