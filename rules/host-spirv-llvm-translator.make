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
HOST_PACKAGES-$(PTXCONF_HOST_SPIRV_LLVM_TRANSLATOR) += host-spirv-llvm-translator

#
# Paths and names
#
HOST_SPIRV_LLVM_TRANSLATOR_VERSION		:= 17.0.6
HOST_SPIRV_LLVM_TRANSLATOR_MD5			:= ad5aa05713f2202c6ceb3960baa092a2
HOST_SPIRV_LLVM_TRANSLATOR			:= spirv-llvm-translator-$(HOST_SPIRV_LLVM_TRANSLATOR_VERSION)
HOST_SPIRV_LLVM_TRANSLATOR_SUFFIX		:= tar.gz
HOST_SPIRV_LLVM_TRANSLATOR_URL			:= https://github.com/KhronosGroup/SPIRV-LLVM-Translator/archive/refs/tags/v$(HOST_SPIRV_LLVM_TRANSLATOR_VERSION).$(HOST_SPIRV_LLVM_TRANSLATOR_SUFFIX)
HOST_SPIRV_LLVM_TRANSLATOR_SOURCE		:= $(SRCDIR)/$(HOST_SPIRV_LLVM_TRANSLATOR).$(HOST_SPIRV_LLVM_TRANSLATOR_SUFFIX)
HOST_SPIRV_LLVM_TRANSLATOR_DIR			:= $(HOST_BUILDDIR)/$(HOST_SPIRV_LLVM_TRANSLATOR)
HOST_SPIRV_LLVM_TRANSLATOR_LICENSE		:= NCSA
HOST_SPIRV_LLVM_TRANSLATOR_LICENSE_FILES	:= file://LICENSE.TXT;md5=47e311aa9caedd1b3abf098bd7814d1d

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_SPIRV_LLVM_TRANSLATOR_CONF_TOOL	:= cmake
HOST_SPIRV_LLVM_TRANSLATOR_CONF_OPT	:= \
	$(HOST_CMAKE_OPT) \
	-DCCACHE_ALLOWED=OFF \
	-DLLVM_DIR=$(PTXDIST_SYSROOT_HOST)/usr/lib/cmake/llvm \
	-DLLVM_EXTERNAL_SPIRV_HEADERS_SOURCE_DIR=$(PTXDIST_SYSROOT_HOST)/usr/include/spirv/unified1 \
	-DLLVM_SPIRV_INCLUDE_TESTS=OFF

# vim: syntax=make
