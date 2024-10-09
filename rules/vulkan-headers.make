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
PACKAGES-$(PTXCONF_VULKAN_HEADERS) += vulkan-headers

#
# Paths and names
#

VULKAN_HEADERS_VERSION	:= 1.3.296.0
VULKAN_HEADERS_MD5	:= c1e5eaee17f6dfde2e5b843d1e9380d4
VULKAN_HEADERS		:= vulkan-headers-$(VULKAN_HEADERS_VERSION)
VULKAN_HEADERS_SUFFIX	:= tar.gz
VULKAN_HEADERS_URL	:= https://github.com/KhronosGroup/Vulkan-Headers/archive/vulkan-sdk-$(VULKAN_HEADERS_VERSION).$(VULKAN_HEADERS_SUFFIX)
VULKAN_HEADERS_SOURCE	:= $(SRCDIR)/vulkan-headers-$(VULKAN_HEADERS_VERSION).$(VULKAN_HEADERS_SUFFIX)
VULKAN_HEADERS_DIR	:= $(BUILDDIR)/$(VULKAN_HEADERS)
VULKAN_HEADERS_LICENSE	:= Apache-2.0 AND MIT
VULKAN_HEADERS_LICENSE_FILES := \
	file://LICENSE.md;md5=1bc355d8c4196f774c8b87ed1a8dd625

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

VULKAN_HEADERS_CONF_TOOL	:= cmake
VULKAN_HEADERS_CONF_OPT		:= \
	$(CROSS_CMAKE_USR) \
	-DVULKAN_HEADERS_ENABLE_INSTALL=ON \
	-DVULKAN_HEADERS_ENABLE_MODULE=OFF \
	-DVULKAN_HEADERS_ENABLE_TESTS=OFF

# vim: syntax=make
