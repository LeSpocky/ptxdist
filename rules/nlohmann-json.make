# -*-makefile-*-
#
# Copyright (C) 2021 by Alexander Dahl <ada@thorsis.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_NLOHMANN_JSON) += nlohmann-json

#
# Paths and names
#
NLOHMANN_JSON_VERSION	:= 3.12.0
NLOHMANN_JSON_SHA256	:= 4b92eb0c06d10683f7447ce9406cb97cd4b453be18d7279320f7b2f025c10187
NLOHMANN_JSON		:= nlohmann-json-$(NLOHMANN_JSON_VERSION)
NLOHMANN_JSON_SUFFIX	:= tar.gz
NLOHMANN_JSON_URL	:= https://github.com/nlohmann/json/archive/refs/tags/v$(NLOHMANN_JSON_VERSION).$(NLOHMANN_JSON_SUFFIX)
NLOHMANN_JSON_SOURCE	:= $(SRCDIR)/$(NLOHMANN_JSON).$(NLOHMANN_JSON_SUFFIX)
NLOHMANN_JSON_DIR	:= $(BUILDDIR)/$(NLOHMANN_JSON)
NLOHMANN_JSON_LICENSE	:= MIT
NLOHMANN_JSON_LICENSE_FILES := file://LICENSE.MIT;md5=3b489645de9825cca5beeb9a7e18b6eb

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

NLOHMANN_JSON_CONF_TOOL	:= cmake
NLOHMANN_JSON_CONF_OPT	:= \
	$(CROSS_CMAKE_USR) \
	-DJSON_BuildTests:BOOL=$(call ptx/onoff, PTXCONF_NLOHMANN_JSON_BUILD_TESTS) \
	-DJSON_CI:BOOL=OFF \
	-DJSON_Diagnostics:BOOL=OFF \
	-DJSON_ImplicitConversions:BOOL=ON \
	-DJSON_Install:BOOL=ON \
	-DJSON_MultipleHeaders:BOOL=OFF \
	-DJSON_SystemInclude:BOOL=OFF

# vim: ft=make noet tw=72 ts=8 sw=8
