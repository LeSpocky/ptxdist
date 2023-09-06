#!/bin/bash
#
# Copyright (C) 2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

PTXDIST_CMAKE_TOOLCHAIN_TARGET="${PTXDIST_GEN_CONFIG_DIR}/toolchain-target.cmake"
export PTXDIST_CMAKE_TOOLCHAIN_TARGET

PTXDIST_CMAKE_TOOLCHAIN_HOST="${PTXDIST_GEN_CONFIG_DIR}/toolchain-host.cmake"
export PTXDIST_CMAKE_TOOLCHAIN_HOST

PTXDIST_CMAKE_TOOLCHAIN_CROSS="${PTXDIST_GEN_CONFIG_DIR}/toolchain-cross.cmake"
export PTXDIST_CMAKE_TOOLCHAIN_CROSS

#
# generate cmake toolchain file from template
#
# $1:	cmake toolchain file
#
# FIXME: take care about non linux
#
ptxd_make_cmake_toolchain_target() {
    local sysroot_prefix="${PTXDIST_PATH_SYSROOT_PREFIX}:"

    case "${PTXCONF_ARCH_STRING}" in
	arm64) CMAKE_ARCH_STRING=aarch64 ;;
	riscv) CMAKE_ARCH_STRING=riscv64 ;;
	*) CMAKE_ARCH_STRING=${PTXCONF_ARCH_STRING} ;;
    esac
    SYSTEM_NAME="Linux" \
	SYSTEM_VERSION="1" \
	\
	SYSTEM_PROCESSOR="${CMAKE_ARCH_STRING}" \
	\
	CC="$(which "${CC}")" \
	CXX="$(which "${CXX}")" \
	\
	SYSROOT="${PTXDIST_PATH_SYSROOT_ALL//:/ }" \
	INCLUDE_DIRECTORIES="${sysroot_prefix//://include }" \
	LINK_DIRECTORIES="${sysroot_prefix//://lib }" \
	\
	ptxd_replace_magic "${PTXDIST_TOPDIR}/config/cmake/toolchain-target.cmake.in" > "${1}"
}
export -f ptxd_make_cmake_toolchain_target


#
# generate cmake toolchain file from template
#
ptxd_make_cmake_toolchain_host() {
    CC="$(which "${CC}")" \
	CXX="$(which "${CXX}")" \
	\
	PREFIX_PATH="${PTXDIST_SYSROOT_HOST}/usr" \
	\
	INCLUDE_DIRECTORIES="${PTXDIST_SYSROOT_HOST}/usr/include" \
	LINK_DIRECTORIES="${PTXDIST_SYSROOT_HOST}/usr/lib" \
	\
	ptxd_replace_magic "${PTXDIST_TOPDIR}/config/cmake/toolchain-host.cmake.in" > "${1}"
}
export -f ptxd_make_cmake_toolchain_host


#
# generate cmake toolchain file from template
#
ptxd_make_cmake_toolchain_cross() {
    CC="$(which "${CC}")" \
	CXX="$(which "${CXX}")" \
	\
	PREFIX_PATH="${PTXDIST_SYSROOT_CROSS}/usr" \
	\
	INCLUDE_DIRECTORIES="${PTXDIST_SYSROOT_CROSS}/usr/include" \
	LINK_DIRECTORIES="${PTXDIST_SYSROOT_CROSS}/usr/lib" \
	\
	ptxd_replace_magic "${PTXDIST_TOPDIR}/config/cmake/toolchain-host.cmake.in" > "${1}"
}
export -f ptxd_make_cmake_toolchain_cross
