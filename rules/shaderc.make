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
PACKAGES-$(PTXCONF_SHADERC) += shaderc

#
# Paths and names
#
SHADERC_VERSION			:= v2023.6
SHADERC_MD5			:= fd7536f8ad546a0b4d846e9d45de0715
SHADERC				:= shaderc-$(SHADERC_VERSION)
SHADERC_SUFFIX			:= tar.gz
SHADERC_URL			:= \
	https://github.com/google/shaderc/archive/$(SHADERC_VERSION).$(SHADERC_SUFFIX)
SHADERC_SOURCE			:= $(SRCDIR)/$(SHADERC).$(SHADERC_SUFFIX)
SHADERC_DIR			:= $(BUILDDIR)/$(SHADERC)
SHADERC_LICENSE			= \
	Apache-2.0 AND ($(GLSLANG_LICENSE)) AND ($(SPIRV_TOOLS_LICENSE))
SHADERC_LICENSE_FILES		= \
	file://LICENSE;md5=86d3f3a95c324c9479bd8986968f4327 \
	$(subst file://,file://third_party/glslang/,$(GLSLANG_LICENSE_FILES)) \
	$(subst file://,file://third_party/spirv-tools/,$(SPIRV_TOOLS_LICENSE_FILES))

SHADERC_GLSLANG_MD5		= $(GLSLANG_MD5)
SHADERC_GLSLANG_URL		= $(GLSLANG_URL)
SHADERC_GLSLANG_SOURCE		= $(GLSLANG_SOURCE)
SHADERC_GLSLANG_DIR		= $(SHADERC_DIR)/third_party/glslang

SHADERC_SPIRV_TOOLS_MD5		= $(SPIRV_TOOLS_MD5)
SHADERC_SPIRV_TOOLS_URL		= $(SPIRV_TOOLS_URL)
SHADERC_SPIRV_TOOLS_SOURCE	= $(SPIRV_TOOLS_SOURCE)
SHADERC_SPIRV_TOOLS_DIR		= $(SHADERC_DIR)/third_party/spirv-tools

SHADERC_SPIRV_HEADERS_MD5	= $(SPIRV_HEADERS_MD5)
SHADERC_SPIRV_HEADERS_URL	= $(SPIRV_HEADERS_URL)
SHADERC_SPIRV_HEADERS_SOURCE	= $(SPIRV_HEADERS_SOURCE)
SHADERC_SPIRV_HEADERS_DIR	= $(SHADERC_DIR)/third_party/spirv-tools/external/spirv-headers

SHADERC_SOURCES			= \
	$(SHADERC_SOURCE) \
	$(SHADERC_GLSLANG_SOURCE) \
	$(SHADERC_SPIRV_TOOLS_SOURCE) \
	$(SHADERC_SPIRV_HEADERS_SOURCE)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/shaderc.extract:
	@$(call targetinfo)
	@$(call clean, $(SHADERC_DIR))
	@$(call extract, SHADERC)
	@$(call extract, SHADERC_GLSLANG)
	@$(call extract, SHADERC_SPIRV_TOOLS)
	@$(call extract, SHADERC_SPIRV_HEADERS)
	@$(call patchin, SHADERC)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SHADERC_CONF_TOOL	:= cmake
SHADERC_CONF_OPT	:= \
	$(CROSS_CMAKE_USR) \
	-DCMAKE_BUILD_TYPE=Release \
	-DBUILD_EXTERNAL=ON \
	-DBUILD_SHARED_LIBS=OFF \
	-DBUILD_TESTING=ON \
	-DDISABLE_EXCEPTIONS=OFF \
	-DDISABLE_RTTI=OFF \
	-DENABLE_CTEST=ON \
	-DENABLE_EXCEPTIONS=OFF \
	-DENABLE_EXCEPTIONS_ON_MSVC=ON \
	-DENABLE_GLSLANG_BINARIES=ON \
	-DENABLE_GLSLANG_JS=OFF \
	-DENABLE_HLSL=ON \
	-DENABLE_OPT=ON \
	-DENABLE_PCH=ON \
	-DENABLE_RTTI=OFF \
	-DENABLE_SPVREMAPPER=ON \
	-DSHADERC_ENABLE_WERROR_COMPILE=ON \
	-DSHADERC_ENABLE_WGSL_OUTPUT=OFF \
	-DSHADERC_SKIP_COPYRIGHT_CHECK=OFF \
	-DSHADERC_SKIP_TESTS=ON \
	-DSPIRV_ALLOW_TIMERS=ON \
	-DSPIRV_BUILD_COMPRESSION=OFF \
	-DSPIRV_BUILD_FUZZER=OFF \
	-DSPIRV_BUILD_LIBFUZZER_TARGETS=OFF \
	-DSPIRV_CHECK_CONTEXT=ON \
	-DSPIRV_COLOR_TERMINAL=ON \
	-DSPIRV_CROSS_EXCEPTIONS_TO_ASSERTIONS=OFF \
	-DSPIRV_HEADERS_SKIP_EXAMPLES=ON \
	-DSPIRV_HEADERS_SKIP_INSTALL=ON \
	-DSPIRV_LIB_FUZZING_ENGINE_LINK_OPTIONS= \
	-DSPIRV_LOG_DEBUG=OFF \
	-DSPIRV_SKIP_EXECUTABLES=OFF \
	-DSPIRV_SKIP_TESTS=ON \
	-DSPIRV_TOOLS_BUILD_STATIC=ON \
	-DSPIRV_TOOLS_INSTALL_EMACS_HELPERS=OFF \
	-DSPIRV_WARN_EVERYTHING=OFF \
	-DSPIRV_WERROR=ON

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/shaderc.targetinstall:
	@$(call targetinfo)

	@$(call install_init, shaderc)
	@$(call install_fixup, shaderc, PRIORITY, optional)
	@$(call install_fixup, shaderc, SECTION, base)
	@$(call install_fixup, shaderc, AUTHOR, "Philipp Zabel <p.zabel@pengutronix.de>")
	@$(call install_fixup, shaderc, DESCRIPTION, A collection of tools, libraries and tests for shader compilation)

ifdef PTXCONF_SHADERC_GLSLC
	@$(call install_copy, shaderc, 0, 0, 0755, -, /usr/bin/glslc)
endif

ifdef PTXCONF_SHADERC_LIBSHADERC
	@$(call install_lib, shaderc, 0, 0, 0644, libshaderc_shared)
endif

	@$(call install_finish, shaderc)

	@$(call touch)

# vim: syntax=make
