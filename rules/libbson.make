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
PACKAGES-$(PTXCONF_LIBBSON) += libbson

#
# Paths and names
#
LIBBSON_VERSION		:= 1.23.4
LIBBSON_MD5		:= 28f2f253777e8d80839c41239de44188
LIBBSON			:= libbson-$(LIBBSON_VERSION)
LIBBSON_SUFFIX		:= tar.gz
LIBBSON_URL		:= https://github.com/mongodb/mongo-c-driver/releases/download/$(LIBBSON_VERSION)/mongo-c-driver-$(LIBBSON_VERSION).$(LIBBSON_SUFFIX)
LIBBSON_SOURCE		:= $(SRCDIR)/$(LIBBSON).$(LIBBSON_SUFFIX)
LIBBSON_DIR		:= $(BUILDDIR)/$(LIBBSON)
LIBBSON_LICENSE		:= Apache-2.0 AND MIT
LIBBSON_LICENSE_FILES	:= \
	file://src/libbson/src/bson/bson.c;endline=15;md5=24960268974cd1c54441e1999c9b5d38 \
	file://COPYING;md5=2ee41112a44fe7014dce33e26468ba93 \
	file://src/libbson/THIRD_PARTY_NOTICES;md5=7c6dab59ecb788b1bfe8a307e54c203a

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# cmake
#
LIBBSON_CONF_TOOL	:= cmake
LIBBSON_CONF_OPT	:=  \
	$(CROSS_CMAKE_USR) \
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

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libbson.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libbson)
	@$(call install_fixup, libbson,PRIORITY,optional)
	@$(call install_fixup, libbson,SECTION,base)
	@$(call install_fixup, libbson,AUTHOR,"Roland Hieber <rhi@pengutronix.de>")
	@$(call install_fixup, libbson,DESCRIPTION,missing)

	@$(call install_lib, libbson, 0, 0, 0755, libbson-1.0)

	@$(call install_finish, libbson)

	@$(call touch)

# vim: syntax=make
