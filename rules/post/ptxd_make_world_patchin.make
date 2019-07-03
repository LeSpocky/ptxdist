# -*-makefile-*-
#
# Copyright (C) 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

world/patchin = \
	$(call world/env, $(1)) \
	ptxd_make_world_patchin

patchin = \
	pkg_deprecated_patchin_dir="$(call ptx/escape,$(2))" \
	pkg_deprecated_patchin_series="$(call ptx/escape,$(3))" \
	$(call world/patchin, $(1))

# vim: syntax=make
