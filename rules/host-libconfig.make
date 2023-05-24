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
HOST_PACKAGES-$(PTXCONF_HOST_LIBCONFIG) += host-libconfig

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_LIBCONFIG_CONF_TOOL	:= autoconf

# vim: syntax=make
