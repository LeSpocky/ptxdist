# -*-makefile-*-
#
# Copyright (C) 2018 by Robert Schwebel <r.schwebel@pengutronix.de>
# Copyright (C) 2019 by Bjoern Esser <b.esser@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_OPEN62541) += host-open62541

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_OPEN62541_LOGLEVEL		:= 300

HOST_OPEN62541_CONF_TOOL	:= cmake
HOST_OPEN62541_CONF_OPT		 = \
	$(CROSS_CMAKE_USR) \
	-DBUILD_SHARED_LIBS=OFF \
	-DOPEN62541_VERSION="v$(HOST_OPEN62541_VERSION)" \
	-DUA_ARCHITECTURE=posix \
	-DUA_BUILD_EXAMPLES=OFF \
	-DUA_BUILD_TOOLS=ON \
	-DUA_BUILD_UNIT_TESTS=OFF \
	-DUA_ENABLE_AMALGAMATION=OFF \
	-DUA_ENABLE_COVERAGE=OFF \
	-DUA_ENABLE_DISCOVERY=OFF \
	-DUA_ENABLE_DISCOVERY_MULTICAST=OFF \
	-DUA_ENABLE_ENCRYPTION=OFF \
	-DUA_ENABLE_EXPERIMENTAL_HISTORIZING=OFF \
	-DUA_ENABLE_HISTORIZING=OFF \
	-DUA_ENABLE_METHODCALLS=OFF \
	-DUA_ENABLE_MICRO_EMB_DEV_PROFILE=OFF \
	-DUA_ENABLE_NODEMANAGEMENT=OFF \
	-DUA_ENABLE_QUERY=OFF \
	-DUA_ENABLE_STATIC_ANALYZER=OFF \
	-DUA_ENABLE_SUBSCRIPTIONS=OFF \
	-DUA_ENABLE_SUBSCRIPTIONS_EVENTS=OFF \
	-DUA_LOGLEVEL=$(HOST_OPEN62541_LOGLEVEL) \
	-DUA_NAMESPACE_ZERO=FULL \
	-DUA_NODESET_DIR="$(PTXDIST_SYSROOT_HOST)/usr/share/ua-nodeset"

# vim: syntax=make
