# -*-makefile-*-
#
# Copyright (C) 2020 by Bruno Thomsen <bruno.thomsen@gmail.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_HOST_ZSTD) += host-zstd

#
# Paths and names
#
HOST_ZSTD_DIR		:= $(HOST_BUILDDIR)/$(ZSTD)
HOST_ZSTD_SUBDIR	:= build/cmake

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_ZSTD_CONF_TOOL	:= cmake
HOST_ZSTD_BUILD_DIR	:= $(HOST_ZSTD_DIR)-build
HOST_ZSTD_CONF_OPT	:= \
	$(HOST_CMAKE_OPT) \
	-B$(HOST_ZSTD_BUILD_DIR) \
	-DZSTD_LEGACY_SUPPORT=OFF \
	-DZSTD_MULTITHREAD_SUPPORT=ON \
	-DZSTD_BUILD_PROGRAMS=ON \
	-DZSTD_BUILD_CONTRIB=OFF \
	-DZSTD_BUILD_TESTS=OFF \
	-DZSTD_USE_STATIC_RUNTIME=OFF \
	-DZSTD_PROGRAMS_LINK_SHARED=ON \
	-DZSTD_BUILD_STATIC=OFF \
	-DZSTD_BUILD_SHARED=ON \
	-DZSTD_ZLIB_SUPPORT=OFF \
	-DZSTD_LZMA_SUPPORT=OFF \
	-DZSTD_LZ4_SUPPORT=OFF

# vim: syntax=make
