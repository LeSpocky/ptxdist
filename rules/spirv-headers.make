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
SPIRV_HEADERS_VERSION	:= 1.3.211.0
SPIRV_HEADERS_MD5	:= b12a523f2d692606949b68a67a1db923
SPIRV_HEADERS		:= spirv-headers-$(SPIRV_HEADERS_VERSION)
SPIRV_HEADERS_SUFFIX	:= tar.gz
SPIRV_HEADERS_URL	:= https://github.com/KhronosGroup/SPIRV-Headers/archive/sdk-$(SPIRV_HEADERS_VERSION).$(SPIRV_HEADERS_SUFFIX)
SPIRV_HEADERS_SOURCE	:= $(SRCDIR)/spirv-headers-$(SPIRV_HEADERS_VERSION).$(SPIRV_HEADERS_SUFFIX)
SPIRV_HEADERS_DIR	:= $(BUILDDIR)/$(SPIRV_HEADERS)
SPIRV_HEADERS_LICENSE	:= custom
SPIRV_HEADERS_LICENSE_FILES := file://LICENSE;md5=c938b85bceb8fb26c1a807f28a52ae2d

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SPIRV_HEADERS_CONF_TOOL	:= cmake
SPIRV_HEADERS_CONF_OPT	:= \
	$(CROSS_CMAKE_USR)

# vim: syntax=make
