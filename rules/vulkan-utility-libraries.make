# -*-makefile-*-
#
# Copyright (C) 2023 by Philipp Zabel <p.zabel@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_VULKAN_UTILITY_LIBRARIES) += vulkan-utility-libraries

#
# Paths and names
#
VULKAN_UTILITY_LIBRARIES_VERSION	:= 1.4.335.0
VULKAN_UTILITY_LIBRARIES_MD5		:= 715588e1b7ef099a33d69529ebff57ae
VULKAN_UTILITY_LIBRARIES		:= vulkan-utility-libraries-$(VULKAN_UTILITY_LIBRARIES_VERSION)
VULKAN_UTILITY_LIBRARIES_SUFFIX		:= tar.gz
VULKAN_UTILITY_LIBRARIES_URL		:= https://github.com/KhronosGroup/Vulkan-Utility-Libraries/archive/vulkan-sdk-$(VULKAN_UTILITY_LIBRARIES_VERSION).$(VULKAN_UTILITY_LIBRARIES_SUFFIX)
VULKAN_UTILITY_LIBRARIES_SOURCE		:= $(SRCDIR)/$(VULKAN_UTILITY_LIBRARIES).$(VULKAN_UTILITY_LIBRARIES_SUFFIX)
VULKAN_UTILITY_LIBRARIES_DIR		:= $(BUILDDIR)/$(VULKAN_UTILITY_LIBRARIES)
VULKAN_UTILITY_LIBRARIES_LICENSE	:= Apache-2.0 AND MIT
VULKAN_UTILITY_LIBRARIES_LICENSE_FILES	:= file://LICENSE.md;md5=4ca2d6799091aaa98a8520f1b793939b

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

VULKAN_UTILITY_LIBRARIES_CONF_TOOL	:= cmake
VULKAN_UTILITY_LIBRARIES_CONF_OPT	:= \
	$(CROSS_CMAKE_USR) \
	-DCMAKE_BUILD_TYPE=Release \
	-DBUILD_TESTS=OFF \
	-DUPDATE_DEPS=OFF \
	-DVUL_CODEGEN=OFF \
	-DVUL_ENABLE_ASAN=OFF \
	-DVUL_ENABLE_INSTALL=ON \
	-DVUL_ENABLE_UBSAN=OFF \
	-DVUL_MOCK_ANDROID=OFF \
	-DVUL_WERROR=OFF

# vim: syntax=make
