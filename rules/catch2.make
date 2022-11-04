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
PACKAGES-$(PTXCONF_CATCH2) += catch2

#
# Paths and names
#
CATCH2_VERSION	:= 2.13.10
CATCH2_MD5	:= 7a4dd2fd14fb9f46198eb670ac7834b7
CATCH2		:= Catch2-$(CATCH2_VERSION)
CATCH2_SUFFIX	:= tar.gz
CATCH2_URL	:= https://github.com/catchorg/Catch2/archive/v$(CATCH2_VERSION).$(CATCH2_SUFFIX)
CATCH2_SOURCE	:= $(SRCDIR)/$(CATCH2).$(CATCH2_SUFFIX)
CATCH2_DIR	:= $(BUILDDIR)/$(CATCH2)
CATCH2_LICENSE	:= BSL-1.0
CATCH2_LICENSE_FILES := file://LICENSE.txt;md5=e4224ccaecb14d942c71d31bef20d78c

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

CATCH2_CONF_TOOL	:= cmake
CATCH2_CONF_OPT		:= \
	$(CROSS_CMAKE_USR) \
	-DCATCH_USE_VALGRIND:BOOL=OFF \
	-DCATCH_BUILD_TESTING:BOOL=$(call ptx/onoff, PTXCONF_CATCH2_BUILD_TESTING) \
	-DCATCH_BUILD_EXAMPLES:BOOL=OFF \
	-DCATCH_BUILD_EXTRA_TESTS:BOOL=OFF \
	-DCATCH_ENABLE_COVERAGE:BOOL=OFF \
	-DCATCH_ENABLE_WERROR:BOOL=OFF \
	-DCATCH_INSTALL_DOCS:BOOL=OFF \
	-DCATCH_INSTALL_HELPERS:BOOL=ON

# vim: ft=make noet tw=72 ts=8 sw=8
