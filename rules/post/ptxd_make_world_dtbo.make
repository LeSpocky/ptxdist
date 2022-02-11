# -*-makefile-*-
#
# Copyright (C) 2020 by Michael Tretter <m.tretter@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

world/dtbo/env = \
	$(call world/env, $(1)) \
	pkg_dtso_path="$($(1)_DTSO_PATH)" \
	pkg_dtso="$($(1)_DTSO)" \
	pkg_dtbo_dir="$($(1)_DTBO_DIR)" \
	pkg_kernel_dir="$($(1)_KERNEL_DIR)" \
	pkg_kernel_build_dir="$($(1)_KERNEL_DIR)" \
	pkg_arch="$(GENERIC_KERNEL_ARCH)"

world/dtbo = \
	$(call world/dtbo/env,$(strip $(1))) \
	ptxd_make_world_dtbo

# vim: syntax=make
