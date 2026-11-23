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
PACKAGES-$(PTXCONF_CEREAL) += cereal

#
# Paths and names
#
CEREAL_VERSION		:= 1.3.2
CEREAL_SHA256		:= 16a7ad9b31ba5880dac55d62b5d6f243c3ebc8d46a3514149e56b5e7ea81f85f
CEREAL			:= cereal-$(CEREAL_VERSION)
CEREAL_SUFFIX		:= tar.gz
CEREAL_URL		:= https://github.com/USCiLab/cereal/archive/refs/tags/v$(CEREAL_VERSION).$(CEREAL_SUFFIX)
CEREAL_SOURCE		:= $(SRCDIR)/$(CEREAL).$(CEREAL_SUFFIX)
CEREAL_DIR		:= $(BUILDDIR)/$(CEREAL)
CEREAL_LICENSE		:= BSD-3-Clause
CEREAL_LICENSE_FILES	:= \
	file://LICENSE;md5=4921372a1fb38469e667c38b17a1c4b3

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# cmake
#
CEREAL_CONF_TOOL	:= cmake
CEREAL_CONF_OPT	:=  \
	$(CROSS_CMAKE_USR) \
	-DCLANG_USE_LIBCPP=OFF \
	-DJUST_INSTALL_CEREAL=ON \
	-DSKIP_PERFORMANCE_COMPARISON=ON \
	-DSKIP_PORTABILITY_TEST=ON \
	-DTHREAD_SAFE=OFF \
	-DWITH_WERROR=OFF

# vim: syntax=make
