# -*-makefile-*-
#
# Copyright (C) 2008, 2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

world/compile = \
	+$(call world/env, $(1)) \
	ptxd_make_world_compile

compile = \
	+$(call world/env, $(1)) \
	pkg_make_opt="$(call ptx/escape,$(2))" \
	ptxd_make_world_compile

$(STATEDIR)/%.compile:
	@$(call targetinfo)
	@$(call world/compile, $(PTX_MAP_TO_PACKAGE_$(*)))
	@$(call touch)

# vim: syntax=make:
