# -*-makefile-*-
#
# Copyright (C) 2020 by Philipp Zabel <p.zabel@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GLM) += glm

#
# Paths and names
#
GLM_VERSION	:= 1.0.1
GLM_MD5		:= f824ac50e16310a95279032f82cbd341
GLM		:= glm-$(GLM_VERSION)
GLM_SUFFIX	:= tar.gz
GLM_URL		:= https://github.com/g-truc/glm/archive/refs/tags/$(GLM_VERSION).$(GLM_SUFFIX)
GLM_SOURCE	:= $(SRCDIR)/$(GLM).$(GLM_SUFFIX)
GLM_DIR		:= $(BUILDDIR)/$(GLM)
GLM_LICENSE	:= MIT
GLM_LICENSE_FILES := file://copying.txt;md5=462e4b97f73ef12f8171c3c546ce4e8d

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GLM_CONF_TOOL	:= cmake

GLM_CONF_OPT := \
	$(CROSS_CMAKE_USR) \
	-DGLM_BUILD_INSTALL=ON \
	-DGLM_BUILD_LIBRARY=ON \
	-DGLM_BUILD_TESTS=OFF \
	-DGLM_DISABLE_AUTO_DETECTION=ON \
	-DGLM_ENABLE_CXX_11=OFF \
	-DGLM_ENABLE_CXX_14=OFF \
	-DGLM_ENABLE_CXX_17=OFF \
	-DGLM_ENABLE_CXX_20=ON \
	-DGLM_ENABLE_CXX_98=OFF \
	-DGLM_ENABLE_FAST_MATH=OFF \
	-DGLM_ENABLE_LANG_EXTENSIONS=OFF \
	-DGLM_ENABLE_SIMD_AVX=OFF \
	-DGLM_ENABLE_SIMD_AVX2=$(call ptx/onoff,PTXCONF_ARCH_X86_64) \
	-DGLM_ENABLE_SIMD_NEON=$(call ptx/onoff,PTXCONF_ARCH_ARM_NEON) \
	-DGLM_ENABLE_SIMD_SSE2=OFF \
	-DGLM_ENABLE_SIMD_SSE3=OFF \
	-DGLM_ENABLE_SIMD_SSE4_1=OFF \
	-DGLM_ENABLE_SIMD_SSE4_2=OFF \
	-DGLM_ENABLE_SIMD_SSSE3=OFF \
	-DGLM_FORCE_PURE=OFF

# vim: syntax=make
