# -*-makefile-*-
#
# Copyright (C) 2021 by Michael Riesch <michael.riesch@wolfvision.net>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

world/inject/env = \
	$(call world/env, $(1)) \
	pkg_inject_path="$(call ptx/escape,$($(1)_INJECT_PATH))" \
	pkg_inject_files="$(call ptx/escape,$($(1)_INJECT_FILES))" \
	pkg_inject_oot="$(call ptx/escape,$($(1)_INJECT_OOT))"

world/inject = \
	$(call world/inject/env,$(strip $(1))) \
	ptxd_make_world_inject

# vim: syntax=make
