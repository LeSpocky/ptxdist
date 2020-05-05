# -*-makefile-*-
#
# Copyright (C) 2019 by Bastian Krause <bst@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_JSON_C) += host-json-c

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_JSON_C_CONF_TOOL	:= cmake
HOST_JSON_C_CONF_OPT	:= \
	$(HOST_CMAKE_OPT) \
	-DBUILD_DOCUMENTATION:BOOL=OFF \
	-DBUILD_SHARED_LIBS:BOOL=ON \
	-DBUILD_TESTING:BOOL=OFF \
	-DDISABLE_BSYMBOLIC:BOOL=ON \
	-DDISABLE_WERROR:BOOL=ON \
	-DENABLE_RDRAND:BOOL=OFF \
	-DENABLE_THREADING:BOOL=OFF

# vim: syntax=make
