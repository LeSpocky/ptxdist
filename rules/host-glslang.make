# -*-makefile-*-
#
# Copyright (C) 2020 by Philipp Zabel <p.zabel@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_GLSLANG) += host-glslang

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_GLSLANG_CONF_TOOL	:= cmake
HOST_GLSLANG_CONF_OPT	:= \
	$(HOST_CMAKE_OPT) \
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_INSTALL_LIBDIR=/usr/lib \
	-DBUILD_SHARED_LIBS=OFF \
	-DBUILD_EXTERNAL=OFF \
	-DSKIP_GLSLANG_INSTALL=OFF \
	-DENABLE_SPVREMAPPER=ON \
	-DENABLE_GLSLANG_BINARIES=ON \
	-DENABLE_GLSLANG_JS=OFF \
	-DENABLE_HLSL=OFF \
	-DENABLE_RTTI=OFF \
	-DENABLE_OPT=ON \
	-DENABLE_PCH=ON \
	-DENABLE_CTEST=OFF

# vim: syntax=make
