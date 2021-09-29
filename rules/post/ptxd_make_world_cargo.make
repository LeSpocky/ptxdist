# -*-makefile-*-
#
# Copyright (C) 2021 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

world/cargo-sync = \
	$(call world/env, $(1)) \
	ptxd_make_world_cargo_sync

$(STATEDIR)/%.cargosync:
	@$(call targetinfo)
	@$(call world/cargo-sync, $(PTX_MAP_TO_PACKAGE_$(*)))
	@$(call finish)

# vim: syntax=make:
