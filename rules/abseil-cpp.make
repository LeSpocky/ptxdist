# -*-makefile-*-
#
# Copyright (C) 2023 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ABSEIL_CPP) += abseil-cpp

#
# Paths and names
#
ABSEIL_CPP_VERSION		:= 20250814.1
ABSEIL_CPP_MD5			:= d4d3c25f78e28d61ad83e54cd1116933
ABSEIL_CPP			:= abseil-cpp-$(ABSEIL_CPP_VERSION)
ABSEIL_CPP_SUFFIX		:= tar.gz
ABSEIL_CPP_URL			:= https://github.com/abseil/abseil-cpp/archive/refs/tags/$(ABSEIL_CPP_VERSION).$(ABSEIL_CPP_SUFFIX)
ABSEIL_CPP_SOURCE		:= $(SRCDIR)/$(ABSEIL_CPP).$(ABSEIL_CPP_SUFFIX)
ABSEIL_CPP_DIR			:= $(BUILDDIR)/$(ABSEIL_CPP)
ABSEIL_CPP_LICENSE		:= Apache-2.0
ABSEIL_CPP_LICENSE_FILES	:= \
	file://LICENSE;md5=df52c6edb7adc22e533b2bacc3bd3915

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# cmake
#
ABSEIL_CPP_CONF_TOOL	:= cmake
ABSEIL_CPP_CONF_OPT	:=  \
	$(CROSS_CMAKE_USR) \
	-G Ninja \
	-DABSL_BUILD_MONOLITHIC_SHARED_LIBS=OFF \
	-DABSL_BUILD_TESTING=OFF \
	-DABSL_BUILD_TEST_HELPERS=OFF \
	-DABSL_ENABLE_INSTALL=ON \
	-DABSL_PROPAGATE_CXX_STD=OFF \
	-DABSL_USE_SYSTEM_INCLUDES=OFF \
	-DBUILD_TESTING=OFF

# vim: syntax=make
