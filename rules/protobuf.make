# -*-makefile-*-
#
# Copyright (C) 2012 by Adrian Baumgarth <adrian.baumgarth@l-3com.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PROTOBUF) += protobuf

#
# Paths and names
#
PROTOBUF_VERSION	:= 33.0
PROTOBUF_MD5		:= 936b48fdf816b0341c74ba73a42348c0
PROTOBUF		:= protobuf-$(PROTOBUF_VERSION)
PROTOBUF_SUFFIX		:= tar.gz
PROTOBUF_URL		:= https://github.com/google/protobuf/releases/download/v$(PROTOBUF_VERSION)/$(PROTOBUF).$(PROTOBUF_SUFFIX)
PROTOBUF_SOURCE		:= $(SRCDIR)/$(PROTOBUF).$(PROTOBUF_SUFFIX)
PROTOBUF_DIR		:= $(BUILDDIR)/$(PROTOBUF)
PROTOBUF_LICENSE	:= BSD-3-Clause
PROTOBUF_LICENSE_FILES	:= \
	file://LICENSE;md5=37b5762e07f0af8c74ce80a8bda4266b

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PROTOBUF_CONF_TOOL	:= cmake
PROTOBUF_CONF_OPT	:= \
	$(CROSS_CMAKE_USR) \
	-Dprotobuf_BUILD_CONFORMANCE=OFF \
	-Dprotobuf_BUILD_EXAMPLES=OFF \
	-Dprotobuf_BUILD_LIBPROTOC=OFF \
	-Dprotobuf_BUILD_LIBUPB=OFF \
	-Dprotobuf_BUILD_PROTOBUF_BINARIES=ON \
	-Dprotobuf_BUILD_PROTOC_BINARIES=OFF \
	-Dprotobuf_BUILD_SHARED_LIBS=ON \
	-Dprotobuf_BUILD_TESTS=OFF \
	-Dprotobuf_DISABLE_RTTI=OFF \
	-Dprotobuf_FORCE_FETCH_DEPENDENCIES=OFF \
	-Dprotobuf_INSTALL=ON \
	-Dprotobuf_LOCAL_DEPENDENCIES_ONLY=ON \
	-Dprotobuf_WITH_ZLIB=$(call ptx/onoff, PTXCONF_PROTOBUF_ZLIB) \
	-Dutf8_range_ENABLE_INSTALL=ON \
	-Dutf8_range_ENABLE_TESTS=OFF

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/protobuf.targetinstall:
	@$(call targetinfo)

	@$(call install_init, protobuf)
	@$(call install_fixup, protobuf,PRIORITY,optional)
	@$(call install_fixup, protobuf,SECTION,base)
	@$(call install_fixup, protobuf,AUTHOR,"Adrian Baumgarth <adrian.baumgarth@l-3com.com>")
	@$(call install_fixup, protobuf,DESCRIPTION,missing)

	@$(call install_lib, protobuf, 0, 0, 0644, libutf8_validity)
	@$(call install_lib, protobuf, 0, 0, 0644, libprotobuf-lite)
	@$(call install_lib, protobuf, 0, 0, 0644, libprotobuf)

	@$(call install_finish, protobuf)

	@$(call touch)

# vim: syntax=make
