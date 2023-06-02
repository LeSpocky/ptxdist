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
PACKAGES-$(PTXCONF_SPIRV_TOOLS) += spirv-tools

#
# Paths and names
#
SPIRV_TOOLS_VERSION	:= 1.3.250.0
SPIRV_TOOLS_MD5		:= 3d9dea654f65a28285df53a65cafe252
SPIRV_TOOLS		:= spirv-tools-$(SPIRV_TOOLS_VERSION)
SPIRV_TOOLS_SUFFIX	:= tar.gz
SPIRV_TOOLS_URL		:= https://github.com/KhronosGroup/SPIRV-Tools/archive/sdk-$(SPIRV_TOOLS_VERSION).$(SPIRV_TOOLS_SUFFIX)
SPIRV_TOOLS_SOURCE	:= $(SRCDIR)/$(SPIRV_TOOLS).$(SPIRV_TOOLS_SUFFIX)
SPIRV_TOOLS_DIR		:= $(BUILDDIR)/$(SPIRV_TOOLS)
SPIRV_TOOLS_BUILD_DIR	:= $(SPIRV_TOOLS_DIR)-build
SPIRV_TOOLS_LICENSE	:= Apache-2.0
SPIRV_TOOLS_LICENSE_FILES := file://LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57

SPIRV_TOOLS_SPIRV_HEADERS_MD5		= $(SPIRV_HEADERS_MD5)
SPIRV_TOOLS_SPIRV_HEADERS_URL		= $(SPIRV_HEADERS_URL)
SPIRV_TOOLS_SPIRV_HEADERS_SOURCE	= $(SPIRV_HEADERS_SOURCE)
SPIRV_TOOLS_SPIRV_HEADERS_DIR		= $(SPIRV_TOOLS_DIR)/external/spirv-headers

SPIRV_TOOLS_SOURCES	:= \
	$(SPIRV_TOOLS_SOURCE) \
	$(SPIRV_TOOLS_SPIRV_HEADERS_SOURCE)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/spirv-tools.extract:
	@$(call targetinfo)
	@$(call clean, $(SPIRV_TOOLS_DIR))
	@$(call extract, SPIRV_TOOLS)
	@$(call extract, SPIRV_TOOLS_SPIRV_HEADERS)
	@$(call patchin, SPIRV_TOOLS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SPIRV_TOOLS_CONF_TOOL	:= cmake
SPIRV_TOOLS_CONF_OPT	:= \
	$(CROSS_CMAKE_USR) \
	-DCMAKE_BUILD_TYPE=Release \
	-DENABLE_RTTI=OFF \
	-DSKIP_SPIRV_TOOLS_INSTALL=OFF \
	-DSPIRV_ALLOW_TIMERS=ON \
	-DSPIRV_BUILD_COMPRESSION=OFF \
	-DSPIRV_BUILD_FUZZER=OFF \
	-DSPIRV_BUILD_LIBFUZZER_TARGETS=OFF \
	-DSPIRV_CHECK_CONTEXT=ON \
	-DSPIRV_COLOR_TERMINAL=ON \
	-DSPIRV_LIB_FUZZING_ENGINE_LINK_OPTIONS= \
	-DSPIRV_LOG_DEBUG=OFF \
	-DSPIRV_SKIP_EXECUTABLES=ON \
	-DSPIRV_SKIP_TESTS=ON \
	-DSPIRV_TOOLS_BUILD_STATIC=ON \
	-DSPIRV_TOOLS_INSTALL_EMACS_HELPERS=OFF \
	-DSPIRV_WARN_EVERYTHING=OFF \
	-DSPIRV_WERROR=OFF

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/spirv-tools.targetinstall:
	@$(call targetinfo)

	@$(call install_init, spirv-tools)
	@$(call install_fixup, spirv-tools, PRIORITY, optional)
	@$(call install_fixup, spirv-tools, SECTION, base)
	@$(call install_fixup, spirv-tools, AUTHOR, "Philipp Zabel <p.zabel@pengutronix.de>")
	@$(call install_fixup, spirv-tools, DESCRIPTION, SPIR-V Tools)

ifdef PTXCONF_SPIRV_TOOLS_LIB
	@$(call install_lib, spirv-tools, 0, 0, 0644, libSPIRV-Tools-shared)
endif

	@$(call install_finish, spirv-tools)

	@$(call touch)

# vim: syntax=make
