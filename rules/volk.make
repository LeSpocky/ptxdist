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
PACKAGES-$(PTXCONF_VOLK) += volk

#
# Paths and names
#
VOLK_VERSION		:= 1.3.296.0
VOLK_MD5		:= 73a3eb04d20fedd01299dee0f4168f5c
VOLK			:= volk-$(VOLK_VERSION)
VOLK_SUFFIX		:= tar.gz
VOLK_URL		:= https://github.com/zeux/volk/archive/refs/tags/vulkan-sdk-$(VOLK_VERSION).$(VOLK_SUFFIX)
VOLK_SOURCE		:= $(SRCDIR)/$(VOLK).$(VOLK_SUFFIX)
VOLK_DIR		:= $(BUILDDIR)/$(VOLK)
VOLK_LICENSE		:= MIT
VOLK_LICENSE_FILES	:= file://LICENSE.md;md5=12e6af3a0e2a5e5dbf7796aa82b64626

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

VOLK_CONF_TOOL	:= cmake

VOLK_CONF_OPT	:= \
	$(CROSS_CMAKE_USR) \
	-G Ninja \
	-DVOLK_HEADERS_ONLY=OFF \
	-DVOLK_INSTALL=ON \
	-DVOLK_PULL_IN_VULKAN=ON \
	-DVOLK_STATIC_DEFINES=OFF

# vim: syntax=make
