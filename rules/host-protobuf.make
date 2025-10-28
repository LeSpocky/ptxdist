# -*-makefile-*-
#
# Copyright (C) 2012 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_PROTOBUF) += host-protobuf

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_PROTOBUF_CONF_TOOL	:= cmake
HOST_PROTOBUF_CONF_OPT	:= \
	$(HOST_CMAKE_OPT) \
	-Dprotobuf_BUILD_CONFORMANCE=OFF \
	-Dprotobuf_BUILD_EXAMPLES=OFF \
	-Dprotobuf_BUILD_LIBPROTOC=OFF \
	-Dprotobuf_BUILD_LIBUPB=ON \
	-Dprotobuf_BUILD_PROTOBUF_BINARIES=ON \
	-Dprotobuf_BUILD_PROTOC_BINARIES=ON \
	-Dprotobuf_BUILD_SHARED_LIBS=OFF \
	-Dprotobuf_BUILD_TESTS=OFF \
	-Dprotobuf_DISABLE_RTTI=OFF \
	-Dprotobuf_FORCE_FETCH_DEPENDENCIES=OFF \
	-Dprotobuf_INSTALL=ON \
	-Dprotobuf_LOCAL_DEPENDENCIES_ONLY=ON \
	-Dprotobuf_WITH_ZLIB=OFF \
	-Dutf8_range_ENABLE_INSTALL=ON \
	-Dutf8_range_ENABLE_TESTS=OFF

# vim: syntax=make
