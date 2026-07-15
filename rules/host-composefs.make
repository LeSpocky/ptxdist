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
HOST_PACKAGES-$(PTXCONF_HOST_COMPOSEFS) += host-composefs

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# meson
#
HOST_COMPOSEFS_CONF_TOOL	:= meson
HOST_COMPOSEFS_CONF_OPT		:= \
	$(HOST_MESON_OPT) \
	-Dfuse=disabled \
	-Dman=disabled

# vim: syntax=make
