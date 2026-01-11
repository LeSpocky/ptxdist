# -*-makefile-*-
#
# Copyright (C) 2015 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_ORC) += host-orc

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# meson
#
HOST_ORC_CONF_TOOL	:= meson
HOST_ORC_CONF_OPT	:= \
	$(HOST_MESON_OPT) \
	-Dorc-target=all \
	-Dorc-test=disabled \
	-Dbenchmarks=disabled \
	-Dexamples=disabled \
	-Dhotdoc=disabled \
	-Dtests=disabled \
	-Dtools=enabled

# vim: syntax=make
