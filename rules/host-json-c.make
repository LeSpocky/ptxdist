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
	-DBUILD_APPS:BOOL=OFF \
	-DBUILD_SHARED_LIBS:BOOL=ON \
	-DBUILD_STATIC_LIBS:BOOL=OFF \
	-DBUILD_TESTING:BOOL=OFF \
	-DDISABLE_BSYMBOLIC:BOOL=ON \
	-DDISABLE_EXTRA_LIBS:BOOL=ON \
	-DDISABLE_JSON_PATCH=OFF \
	-DDISABLE_JSON_POINTER=OFF \
	-DDISABLE_THREAD_LOCAL_STORAGE=OFF \
	-DDISABLE_WERROR:BOOL=ON \
	-DENABLE_RDRAND:BOOL=OFF \
	-DENABLE_THREADING:BOOL=OFF \
	-DNEWLOCALE_NEEDS_FREELOCALE=OFF \
	-DOVERRIDE_GET_RANDOM_SEED=OFF

# vim: syntax=make
