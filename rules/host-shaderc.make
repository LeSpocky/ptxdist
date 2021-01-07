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
HOST_PACKAGES-$(PTXCONF_HOST_SHADERC) += host-shaderc

HOST_SHADERC_GLSLANG_MD5		:= $(SHADERC_GLSLANG_MD5)
HOST_SHADERC_GLSLANG_URL		:= $(SHADERC_GLSLANG_URL)
HOST_SHADERC_GLSLANG_SOURCE		:= $(SHADERC_GLSLANG_SOURCE)
HOST_SHADERC_GLSLANG_DIR		:= $(HOST_SHADERC_DIR)/third_party/glslang

HOST_SHADERC_SPIRV_TOOLS_MD5		= $(SHADERC_SPIRV_TOOLS_MD5)
HOST_SHADERC_SPIRV_TOOLS_URL		= $(SHADERC_SPIRV_TOOLS_URL)
HOST_SHADERC_SPIRV_TOOLS_SOURCE		= $(SHADERC_SPIRV_TOOLS_SOURCE)
HOST_SHADERC_SPIRV_TOOLS_DIR		= $(HOST_SHADERC_DIR)/third_party/spirv-tools

HOST_SHADERC_SPIRV_HEADERS_MD5		= $(SHADERC_SPIRV_HEADERS_MD5)
HOST_SHADERC_SPIRV_HEADERS_URL		= $(SHADERC_SPIRV_HEADERS_URL)
HOST_SHADERC_SPIRV_HEADERS_SOURCE	= $(SHADERC_SPIRV_HEADERS_SOURCE)
HOST_SHADERC_SPIRV_HEADERS_DIR		= $(HOST_SHADERC_DIR)/third_party/spirv-tools/external/spirv-headers

HOST_SHADERC_SOURCES			= \
	$(HOST_SHADERC_SOURCE) \
	$(HOST_SHADERC_GLSLANG_SOURCE) \
	$(HOST_SHADERC_SPIRV_TOOLS_SOURCE) \
	$(HOST_SHADERC_SPIRV_HEADERS_SOURCE)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/host-shaderc.extract:
	@$(call targetinfo)
	@$(call clean, $(HOST_SHADERC_DIR))
	@$(call extract, HOST_SHADERC)
	@$(call extract, HOST_SHADERC_GLSLANG)
	@$(call extract, HOST_SHADERC_SPIRV_TOOLS)
	@$(call extract, HOST_SHADERC_SPIRV_HEADERS)
	@$(call patchin, HOST_SHADERC)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_SHADERC_CONF_TOOL	:= cmake
HOST_SHADERC_CONF_OPT	:= \
	$(HOST_CMAKE_OPT) \
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_INSTALL_LIBDIR=/usr/lib \
	-DSHADERC_SKIP_INSTALL=OFF \
	-DSHADERC_SKIP_TESTS=ON \
	-DSHADERC_ENABLE_WERROR_COMPILE=ON

# vim: syntax=make
