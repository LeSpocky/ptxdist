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
HOST_PACKAGES-$(PTXCONF_HOST_ZSTD) += host-zstd

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_ZSTD_CONF_TOOL	:= cmake
# Use = instead of := because HOST_ZSTD_DIR is defined from ZSTD_* variables
HOST_ZSTD_BUILD_DIR	 = $(HOST_ZSTD_DIR)-build
HOST_ZSTD_CONF_OPT	 = \
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
