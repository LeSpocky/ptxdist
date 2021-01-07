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
GLSLANG_VERSION		:= 2020-12-03-gdd69df7f3dac
GLSLANG_MD5		:= 7c2135e6a961c34345750ce16672283a
GLSLANG			:= glslang-$(GLSLANG_VERSION)
GLSLANG_SUFFIX		:= tar.gz
GLSLANG_URL		:= https://github.com/KhronosGroup/glslang/archive/$(GLSLANG_VERSION).$(GLSLANG_SUFFIX)
GLSLANG_SOURCE		:= $(SRCDIR)/$(GLSLANG).$(GLSLANG_SUFFIX)
GLSLANG_DIR		:= $(BUILDDIR)/$(GLSLANG)
GLSLANG_LICENSE		:= BSD-3-clause AND BSD-2-clause AND MIT AND Apple-MIT-License AND Apache-2.0 AND (GPL-3.0-or-later WITH Bison-exception-2.2)
GLSLANG_LICENSE_FILES := file://LICENSE.txt;md5=c5ce49c0456e9b413b98a4368c378229

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GLSLANG_CONF_TOOL	:= cmake
GLSLANG_CONF_OPT	:= \
	$(CROSS_CMAKE_USR) \
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_INSTALL_LIBDIR=/usr/lib \
	-DBUILD_SHARED_LIBS=ON \
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

ifdef GLSLANG_TOOLS
	@$(call install_copy, glslang, 0, 0, 0755, -, /usr/bin/glslangValidator)
	@$(call install_copy, glslang, 0, 0, 0755, -, /usr/bin/spirv-remap)
endif

ifdef GLSLANG_LIBS
	@$(call install_lib, glslang, 0, 0, 0644, libglslang-default-resource-limits)
	@$(call install_lib, glslang, 0, 0, 0644, libglslang)
	@$(call install_lib, glslang, 0, 0, 0644, libHLSL)
	@$(call install_lib, glslang, 0, 0, 0644, libSPIRV)
	@$(call install_lib, glslang, 0, 0, 0644, libSPVRemapper)
endif

	@$(call install_finish, glslang)

	@$(call touch)

# vim: syntax=make
