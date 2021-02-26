# -*-makefile-*-
#
# Copyright (C) 2021 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

PHONY += ptxdist-lint

ptx/lint = \
	$(call ptx/env) \
	ptx_dgen_rulesfiles_make="$(PTX_DGEN_RULESFILES_MAKE)" \
	ptx_patch_dir_all="$(sort $(foreach v,$(filter %_PATCH_DIRS, $(.VARIABLES)),$($(v))))" \
	ptx_missing_version_pkgs="$(strip $(foreach pkg,$(filter-out host-system-%,$(filter-out image-%,$(PTX_PACKAGES_ALL))),$(if $($(PTX_MAP_TO_PACKAGE_$(pkg))_VERSION),,$(pkg))))" \
	ptxd_make_world_lint

ptxdist-lint:
	@$(call targetinfo)
	@$(call ptx/lint)

# vim: syntax=make
