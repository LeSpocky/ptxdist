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
PACKAGES-$(PTXCONF_GLSLANG) += glslang

#
# Paths and names
#
GLSLANG_VERSION		:= 1.4.328.0
GLSLANG_MD5		:= 844c0aaaacbfae2a5bd3c71f498ed7c2
GLSLANG			:= glslang-$(GLSLANG_VERSION)
GLSLANG_SUFFIX		:= tar.gz
GLSLANG_URL		:= https://github.com/KhronosGroup/glslang/archive/vulkan-sdk-$(GLSLANG_VERSION).$(GLSLANG_SUFFIX)
GLSLANG_SOURCE		:= $(SRCDIR)/$(GLSLANG).$(GLSLANG_SUFFIX)
GLSLANG_DIR		:= $(BUILDDIR)/$(GLSLANG)
GLSLANG_LICENSE		:= BSD-3-clause AND BSD-2-clause AND MIT AND Apple-MIT-License AND Apache-2.0 AND (GPL-3.0-or-later WITH Bison-exception-2.2) AND custom
GLSLANG_LICENSE_FILES := file://LICENSE.txt;md5=50ff9d0fcde2d5b953ebe431c48e34e3

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GLSLANG_CONF_TOOL	:= cmake
GLSLANG_CONF_OPT	:= \
	$(CROSS_CMAKE_USR) \
	-DCMAKE_BUILD_TYPE=Release \
	-DALLOW_EXTERNAL_SPIRV_TOOLS=ON \
	-DBUILD_EXTERNAL=OFF \
	-DBUILD_SHARED_LIBS=ON \
	-DBUILD_WERROR=OFF \
	-DENABLE_EXCEPTIONS=OFF \
	-DENABLE_GLSLANG_BINARIES=ON \
	-DENABLE_GLSLANG_JS=OFF \
	-DENABLE_HLSL=OFF \
	-DENABLE_OPT=ON \
	-DENABLE_PCH=ON \
	-DENABLE_RTTI=OFF \
	-DENABLE_SPIRV=ON \
	-DGLSLANG_ENABLE_INSTALL=ON \
	-DGLSLANG_TESTS=OFF

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/glslang.targetinstall:
	@$(call targetinfo)

	@$(call install_init, glslang)
	@$(call install_fixup, glslang, PRIORITY, optional)
	@$(call install_fixup, glslang, SECTION, base)
	@$(call install_fixup, glslang, AUTHOR, "Philipp Zabel <p.zabel@pengutronix.de>")
	@$(call install_fixup, glslang, DESCRIPTION, Khronos-reference SPIR-V generator)

ifdef PTXCONF_GLSLANG_TOOLS
	@$(call install_copy, glslang, 0, 0, 0755, -, /usr/bin/glslangValidator)
endif

ifdef PTXCONF_GLSLANG_LIBS
	@$(call install_lib, glslang, 0, 0, 0644, libglslang-default-resource-limits)
	@$(call install_lib, glslang, 0, 0, 0644, libglslang)
	@$(call install_lib, glslang, 0, 0, 0644, libSPIRV)
endif

	@$(call install_finish, glslang)

	@$(call touch)

# vim: syntax=make
