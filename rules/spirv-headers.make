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
SPIRV_HEADERS_VERSION	:= 1.3.296.0
SPIRV_HEADERS_MD5	:= adee3d432b63f345c8ee6d625d0c8e6c
SPIRV_HEADERS		:= spirv-headers-$(SPIRV_HEADERS_VERSION)
SPIRV_HEADERS_SUFFIX	:= tar.gz
SPIRV_HEADERS_URL	:= https://github.com/KhronosGroup/SPIRV-Headers/archive/vulkan-sdk-$(SPIRV_HEADERS_VERSION).$(SPIRV_HEADERS_SUFFIX)
SPIRV_HEADERS_SOURCE	:= $(SRCDIR)/spirv-headers-$(SPIRV_HEADERS_VERSION).$(SPIRV_HEADERS_SUFFIX)
SPIRV_HEADERS_DIR	:= $(BUILDDIR)/$(SPIRV_HEADERS)
SPIRV_HEADERS_LICENSE	:= custom AND MIT
SPIRV_HEADERS_LICENSE_FILES := file://LICENSE;md5=d14ee3b13f42e9c9674acc5925c3d741

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SPIRV_HEADERS_CONF_TOOL	:= cmake
SPIRV_HEADERS_CONF_OPT	:= \
	$(CROSS_CMAKE_USR) \
	-DSPIRV_HEADERS_ENABLE_INSTALL=ON \
	-DSPIRV_HEADERS_ENABLE_TESTS=OFF

# vim: syntax=make
