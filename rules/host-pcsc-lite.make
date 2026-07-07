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
HOST_PACKAGES-$(PTXCONF_HOST_PCSC_LITE) += host-pcsc-lite

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_PCSC_LITE_CONF_TOOL := meson
HOST_PCSC_LITE_CONF_OPT := \
	$(HOST_MESON_OPT) \
	-Dlibsystemd=false \
	-Dlibudev=false \
	-Dlibusb=false \
	-Dpolkit=false \
	-Dserial=false \
	-Dsystemdunit=system \
	-Dusb=false

# vim: syntax=make
