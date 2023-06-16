# -*-makefile-*-
#
# Copyright (C) 2023 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

world/nested = \
	+$(call world/env, $(1)) \
	pkg_workspace="$(call ptx/escape,$($(strip $(1))_WORKSPACE))" \
	ptxd_make_nested_ptxdist $(2)


# vim: syntax=make:
