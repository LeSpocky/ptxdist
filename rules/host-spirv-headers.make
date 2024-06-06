# -*-makefile-*-
#
# Copyright (C) 2024 by Philipp Zabel <p.zabel@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_SPIRV_HEADERS) += host-spirv-headers

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_SPIRV_HEADERS_CONF_TOOL	:= cmake
HOST_SPIRV_HEADERS_CONF_OPT	:= \
	$(HOST_CMAKE_OPT) \
	-DSPIRV_HEADERS_ENABLE_INSTALL=ON \
	-DSPIRV_HEADERS_ENABLE_TESTS=OFF

# vim: syntax=make
