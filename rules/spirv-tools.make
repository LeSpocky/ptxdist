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
SPIRV_TOOLS_VERSION	:= 2020.3
SPIRV_TOOLS_MD5		:= 1b7d45e6a060d3a2e3dad73531cb0768
SPIRV_TOOLS		:= spirv-tools-$(SPIRV_TOOLS_VERSION)
SPIRV_TOOLS_SUFFIX	:= tar.gz
SPIRV_TOOLS_URL		:= https://github.com/KhronosGroup/SPIRV-Tools/archive/v$(SPIRV_TOOLS_VERSION).$(SPIRV_TOOLS_SUFFIX)
SPIRV_TOOLS_SOURCE	:= $(SRCDIR)/$(SPIRV_TOOLS).$(SPIRV_TOOLS_SUFFIX)
SPIRV_TOOLS_DIR		:= $(BUILDDIR)/$(SPIRV_TOOLS)
SPIRV_TOOLS_LICENSE	:= Apache-2.0
SPIRV_TOOLS_LICENSE_FILES := file://LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57

SPIRV_HEADERS_VERSION	:= 2020-05-21-gac638f181542
SPIRV_HEADERS_MD5	:= 4dde857e9ecfe44025478876286f0915
SPIRV_HEADERS_SUFFIX	:= tar.gz
SPIRV_HEADERS_URL	:= https://github.com/KhronosGroup/SPIRV-Headers/archive/$(SPIRV_HEADERS_VERSION).$(SPIRV_HEADERS_SUFFIX)
SPIRV_HEADERS_SOURCE	:= $(SRCDIR)/spirv-headers-$(SPIRV_HEADERS_VERSION).$(SPIRV_HEADERS_SUFFIX)
$(SPIRV_HEADERS_SOURCE) := SPIRV_HEADERS
SPIRV_HEADERS_DIR	:= $(SPIRV_TOOLS_DIR)/external/spirv-headers

SPIRV_TOOLS_SOURCES	:= $(SPIRV_TOOLS_SOURCE) $(SPIRV_HEADERS_SOURCE)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/spirv-tools.extract:
	@$(call targetinfo)
	@$(call clean, $(SPIRV_TOOLS_DIR))
	@$(call extract, SPIRV_TOOLS)
	@$(call extract, SPIRV_HEADERS)
	@$(call patchin, SPIRV_TOOLS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SPIRV_TOOLS_CONF_TOOL	:= cmake
SPIRV_TOOLS_CONF_OPT	:= \
	$(CROSS_CMAKE_USR) \
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_INSTALL_LIBDIR=/usr/lib \
	-DSPIRV_ALLOW_TIMERS=ON \
	-DSKIP_SPIRV_TOOLS_INSTALL=OFF \
	-DSPIRV_WERROR=OFF \
	-DSPIRV_WARN_EVERYTHING=OFF \
	-DSPIRV_COLOR_TERMINAL=ON \
	-DSPIRV_LOG_DEBUG=OFF \
	-DSPIRV_SKIP_EXECUTABLES=ON \
	-DSPIRV_SKIP_TESTS=ON

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/spirv-tools.install:
	@$(call targetinfo)
	@install -vD -m 644 $(SPIRV_TOOLS_DIR)-build/source/libSPIRV-Tools.a $(SPIRV_TOOLS_PKGDIR)/usr/lib/libSPIRV-Tools.a
	@install -vD -m 644 $(SPIRV_TOOLS_DIR)-build/source/opt/libSPIRV-Tools-opt.a $(SPIRV_TOOLS_PKGDIR)/usr/lib/libSPIRV-Tools-opt.a
	@install -vD -m 644 $(SPIRV_TOOLS_DIR)-build/source/libSPIRV-Tools-shared.so $(SPIRV_TOOLS_PKGDIR)/usr/lib/libSPIRV-Tools-shared.so
	@mkdir -p $(SPIRV_TOOLS_PKGDIR)/usr/include
	@cp -r $(SPIRV_HEADERS_DIR)/include/spirv $(SPIRV_TOOLS_PKGDIR)/usr/include
	@cp -r $(SPIRV_TOOLS_DIR)/include/spirv-tools $(SPIRV_TOOLS_PKGDIR)/usr/include
	$(call touch)

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
