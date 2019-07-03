# -*-makefile-*-
#
# Copyright (C) 2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

$(PTXDIST_CMAKE_TOOLCHAIN_TARGET):
	@$(CROSS_ENV) \
		PTXCONF_ARCH_STRING="${PTXCONF_ARCH_STRING}" \
		ptxd_make_cmake_toolchain_target "${@}"

$(PTXDIST_CMAKE_TOOLCHAIN_HOST):
	@$(HOST_ENV) \
		PTXDIST_SYSROOT_HOST="${PTXDIST_SYSROOT_HOST}" \
		ptxd_make_cmake_toolchain_host "${@}"

# vim: syntax=make
