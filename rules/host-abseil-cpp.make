# -*-makefile-*-
#
# Copyright (C) 2025 by Sven Püschel <s.pueschel@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_ABSEIL_CPP) += host-abseil-cpp

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_ABSEIL_CPP_CONF_TOOL	:= cmake
HOST_ABSEIL_CPP_CONF_OPT	 = \
	$(HOST_CMAKE_OPT) \
	-G Ninja \
	-DABSL_BUILD_MONOLITHIC_SHARED_LIBS=OFF \
	-DABSL_BUILD_TESTING=OFF \
	-DABSL_BUILD_TEST_HELPERS=OFF \
	-DABSL_ENABLE_INSTALL=ON \
	-DABSL_PROPAGATE_CXX_STD=OFF \
	-DABSL_USE_SYSTEM_INCLUDES=OFF \
	-DBUILD_TESTING=OFF

# vim: syntax=make
