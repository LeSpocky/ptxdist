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
NLOHMANN_JSON_VERSION	:= 3.11.3
NLOHMANN_JSON_MD5	:= d603041cbc6051edbaa02ebb82cf0aa9
NLOHMANN_JSON		:= nlohmann-json-$(NLOHMANN_JSON_VERSION)
NLOHMANN_JSON_SUFFIX	:= tar.gz
NLOHMANN_JSON_URL	:= https://github.com/nlohmann/json/archive/refs/tags/v$(NLOHMANN_JSON_VERSION).$(NLOHMANN_JSON_SUFFIX)
NLOHMANN_JSON_SOURCE	:= $(SRCDIR)/$(NLOHMANN_JSON).$(NLOHMANN_JSON_SUFFIX)
NLOHMANN_JSON_DIR	:= $(BUILDDIR)/$(NLOHMANN_JSON)
NLOHMANN_JSON_LICENSE	:= MIT
NLOHMANN_JSON_LICENSE_FILES := file://LICENSE.MIT;md5=f969127d7b7ed0a8a63c2bbeae002588

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
