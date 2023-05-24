# -*-makefile-*-
#
# Copyright (C) 2023 by Roland Hieber <rhi@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_LIBBSON) += host-libbson

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# cmake
#
HOST_LIBBSON_CONF_TOOL	:= cmake
HOST_LIBBSON_CONF_OPT	:=  \
	$(HOST_CMAKE_OPT) \
	-DBSON_OUTPUT_BASENAME=bson \
	-DENABLE_APPLE_FRAMEWORK=OFF \
	-DENABLE_AUTOMATIC_INIT_AND_CLEANUP=ON \
	-DENABLE_BSON=ON \
	-DENABLE_CLIENT_SIDE_ENCRYPTION=OFF \
	-DENABLE_COVERAGE=OFF \
	-DENABLE_CRYPTO_SYSTEM_PROFILE=OFF \
	-DENABLE_DEBUG_ASSERTIONS=OFF \
	-DENABLE_EXAMPLES=OFF \
	-DENABLE_EXTRA_ALIGNMENT=ON \
	-DENABLE_HTML_DOCS=OFF \
	-DENABLE_ICU=OFF \
	-DENABLE_MAINTAINER_FLAGS=OFF \
	-DENABLE_MAN_PAGES=OFF \
	-DENABLE_MONGOC=OFF \
	-DENABLE_MONGODB_AWS_AUTH=AUTO \
	-DENABLE_PIC=ON \
	-DENABLE_RDTSCP=OFF \
	-DENABLE_SASL=OFF \
	-DENABLE_SHM_COUNTERS=ON \
	-DENABLE_SNAPPY=OFF \
	-DENABLE_SRV=OFF \
	-DENABLE_SSL=OFF \
	-DENABLE_STATIC=OFF \
	-DENABLE_TESTS=OFF \
	-DENABLE_TRACING=OFF \
	-DENABLE_UNINSTALL=ON \
	-DENABLE_ZLIB=OFF \
	-DENABLE_ZSTD=OFF

# vim: syntax=make
