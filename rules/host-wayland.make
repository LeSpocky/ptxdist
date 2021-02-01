# -*-makefile-*-
#
# Copyright (C) 2013 by Philipp Zabel <p.zabel@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_WAYLAND) += host-wayland

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# meson
#
HOST_WAYLAND_CONF_TOOL	:= meson
HOST_WAYLAND_CONF_OPT	:= \
	$(HOST_MESON_OPT) \
	-Ddocumentation=false \
	-Ddtd_validation=false \
	-Dicon_directory= \
	-Dlibraries=false \
	-Dscanner=true

# vim: syntax=make
