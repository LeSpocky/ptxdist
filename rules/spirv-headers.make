# -*-makefile-*-
#
# Copyright (C) 2022 by Philipp Zabel <p.zabel@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SPIRV_HEADERS) += spirv-headers

#
# Paths and names
#
SPIRV_HEADERS_VERSION	:= 1.4.341.0
SPIRV_HEADERS_SHA256	:= cab0a654c4917e16367483296b44cdb1d614e3120c721beafcd37e3a8580486c
SPIRV_HEADERS		:= spirv-headers-$(SPIRV_HEADERS_VERSION)
SPIRV_HEADERS_SUFFIX	:= tar.gz
SPIRV_HEADERS_URL	:= https://github.com/KhronosGroup/SPIRV-Headers/archive/vulkan-sdk-$(SPIRV_HEADERS_VERSION).$(SPIRV_HEADERS_SUFFIX)
SPIRV_HEADERS_SOURCE	:= $(SRCDIR)/spirv-headers-$(SPIRV_HEADERS_VERSION).$(SPIRV_HEADERS_SUFFIX)
SPIRV_HEADERS_DIR	:= $(BUILDDIR)/$(SPIRV_HEADERS)
SPIRV_HEADERS_LICENSE	:= custom AND MIT
SPIRV_HEADERS_LICENSE_FILES := file://LICENSE;md5=a0dcaa512cc2dee95fe0fd791ee83a18

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SPIRV_HEADERS_CONF_TOOL	:= cmake
SPIRV_HEADERS_CONF_OPT	:= \
	$(CROSS_CMAKE_USR) \
	-DSPIRV_HEADERS_ENABLE_INSTALL=ON \
	-DSPIRV_HEADERS_ENABLE_TESTS=OFF

# vim: syntax=make
