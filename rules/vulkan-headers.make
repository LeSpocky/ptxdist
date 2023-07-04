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

VULKAN_HEADERS_VERSION	:= 1.3.250.1
VULKAN_HEADERS_MD5	:= d325a08e8a82881029bdcde447452a75
VULKAN_HEADERS		:= vulkan-headers-$(VULKAN_HEADERS_VERSION)
VULKAN_HEADERS_SUFFIX	:= tar.gz
VULKAN_HEADERS_URL	:= https://github.com/KhronosGroup/Vulkan-Headers/archive/sdk-$(VULKAN_HEADERS_VERSION).$(VULKAN_HEADERS_SUFFIX)
VULKAN_HEADERS_SOURCE	:= $(SRCDIR)/vulkan-headers-$(VULKAN_HEADERS_VERSION).$(VULKAN_HEADERS_SUFFIX)
VULKAN_HEADERS_DIR	:= $(BUILDDIR)/$(VULKAN_HEADERS)
VULKAN_HEADERS_LICENSE	:= Apache-2.0
VULKAN_HEADERS_LICENSE_FILES := \
	file://LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57


# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

VULKAN_HEADERS_CONF_TOOL	:= cmake
VULKAN_HEADERS_CONF_OPT		:= \
	$(CROSS_CMAKE_USR) \
	-DBUILD_TESTS=OFF

# vim: syntax=make
