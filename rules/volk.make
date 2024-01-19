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
VOLK_VERSION		:= 1.3.275.0
VOLK_MD5		:= a202eda3e1dca32065ce22d70403afd2
VOLK			:= volk-$(VOLK_VERSION)
VOLK_SUFFIX		:= tar.gz
VOLK_URL		:= https://github.com/zeux/volk/archive/refs/tags/vulkan-sdk-$(VOLK_VERSION).$(VOLK_SUFFIX)
VOLK_SOURCE		:= $(SRCDIR)/$(VOLK).$(VOLK_SUFFIX)
VOLK_DIR		:= $(BUILDDIR)/$(VOLK)
VOLK_LICENSE		:= MIT
VOLK_LICENSE_FILES	:= file://LICENSE.md;md5=b2dd098d35668a801190a9d9d47461b0

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
