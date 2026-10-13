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
VOLK_VERSION		:= 1.4.363.0
VOLK_SHA256		:= 1547d8d74395d4048fb3f4a6313da56db626e89b55db238d0d7e8944c8a645f3
VOLK			:= volk-$(VOLK_VERSION)
VOLK_SUFFIX		:= tar.gz
VOLK_URL		:= https://github.com/zeux/volk/archive/refs/tags/vulkan-sdk-$(VOLK_VERSION).$(VOLK_SUFFIX)
VOLK_SOURCE		:= $(SRCDIR)/$(VOLK).$(VOLK_SUFFIX)
VOLK_DIR		:= $(BUILDDIR)/$(VOLK)
VOLK_LICENSE		:= MIT
VOLK_LICENSE_FILES	:= file://LICENSE.md;md5=cfcbdd69e15396e371f639c69acf40bf

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

VOLK_CONF_TOOL	:= cmake

VOLK_CONF_OPT	:= \
	$(CROSS_CMAKE_USR) \
	-G Ninja \
	-DVOLK_HEADERS_ONLY=OFF \
	-DVOLK_INSTALL=ON \
	-DVOLK_NAMESPACE=OFF \
	-DVOLK_PULL_IN_VULKAN=ON \
	-DVOLK_STATIC_DEFINES=

# vim: syntax=make
