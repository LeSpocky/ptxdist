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
HOST_PACKAGES-$(PTXCONF_HOST_CLANG) += host-clang

#
# Paths and names
#
HOST_CLANG_VERSION		:= 19.1.7
HOST_CLANG_MD5			:= 8a29181acd27b9c03b0039b75f5fcaa0
HOST_CLANG			:= clang-$(HOST_CLANG_VERSION)
HOST_CLANG_SUFFIX		:= src.tar.xz
HOST_CLANG_URL			:= https://github.com/llvm/llvm-project/releases/download/llvmorg-$(HOST_CLANG_VERSION)/$(HOST_CLANG).$(HOST_CLANG_SUFFIX)
HOST_CLANG_SOURCE		:= $(SRCDIR)/$(HOST_CLANG).$(HOST_CLANG_SUFFIX)
HOST_CLANG_DIR			:= $(HOST_BUILDDIR)/$(HOST_CLANG)
HOST_CLANG_SUBDIR		:= $(HOST_CLANG).src
HOST_CLANG_STRIP_LEVEL		:= 0
HOST_CLANG_LICENSE		:= Apache-2.0 WITH LLVM-exception AND NCSA
HOST_CLANG_LICENSE_FILES	:= file://$(HOST_CLANG_SUBDIR)/LICENSE.TXT;md5=ff42885ed2ab98f1ecb8c1fc41205343

HOST_CLANG_CMAKE_MD5		:= 52b5249a06305e19c3bdae2e972c99c3
HOST_CLANG_CMAKE_URL		:= https://github.com/llvm/llvm-project/releases/download/llvmorg-$(HOST_CLANG_VERSION)/cmake-$(HOST_CLANG_VERSION).$(HOST_CLANG_SUFFIX)
HOST_CLANG_CMAKE_SOURCE		:= $(SRCDIR)/cmake-$(HOST_CLANG_VERSION).$(HOST_CLANG_SUFFIX)
HOST_CLANG_CMAKE_DIR		:= $(HOST_BUILDDIR)/$(HOST_CLANG)/cmake

HOST_CLANG_PARTS		+= HOST_CLANG_CMAKE

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# cmake
#
HOST_CLANG_CONF_TOOL	:= cmake
HOST_CLANG_CONF_OPT	:= \
	$(HOST_CMAKE_OPT) \
	-DCMAKE_BUILD_TYPE=Release \
	-G Ninja \
	-DBUILD_CLANG_FORMAT_VS_PLUGIN=OFF \
	-DCLANG_BOLT=OFF \
	-DCLANG_BUILD_EXAMPLES=OFF \
	-DCLANG_BUILD_TOOLS=ON \
	-DCLANG_DEFAULT_CXX_STDLIB= \
	-DCLANG_DEFAULT_LINKER= \
	-DCLANG_DEFAULT_OBJCOPY=objcopy \
	-DCLANG_DEFAULT_OPENMP_RUNTIME=libomp \
	-DCLANG_DEFAULT_PIE_ON_LINUX=ON \
	-DCLANG_DEFAULT_RTLIB= \
	-DCLANG_DEFAULT_UNWINDLIB= \
	-DCLANG_ENABLE_ARCMT=ON \
	-DCLANG_ENABLE_BOOTSTRAP=OFF \
	-DCLANG_ENABLE_LIBXML2=OFF \
	-DCLANG_ENABLE_PROTO_FUZZER=OFF \
	-DCLANG_ENABLE_STATIC_ANALYZER=ON \
	-DCLANG_FORCE_MATCHING_LIBCLANG_SOVERSION=ON \
	-DCLANG_INCLUDE_DOCS=OFF \
	-DCLANG_INCLUDE_TESTS=OFF \
	-DCLANG_INSTALL_SCANBUILD=OFF \
	-DCLANG_INSTALL_SCANVIEW=OFF \
	-DCLANG_LINK_CLANG_DYLIB=ON \
	-DCLANG_PLUGIN_SUPPORT=ON \
	-DCLANG_PYTHON_BINDINGS_VERSIONS= \
	-DCLANG_REPOSITORY_STRING= \
	-DCLANG_SPAWN_CC1=OFF \
	-DCLANG_SYSTEMZ_DEFAULT_ARCH=z10 \
	-DCLANG_TOOL_DICTIONARY_BUILD=ON \
	-DCLANG_TOOL_HANDLE_CXX_BUILD=ON \
	-DCLANG_TOOL_HANDLE_LLVM_BUILD=ON \
	-DCLANG_VENDOR= \
	-DCLANG_VENDOR_UTI=org.llvm.clang \
	-DLLVM_DIR=$(PTXDIST_SYSROOT_HOST)/usr/lib/cmake/llvm \
	-DLLVM_INCLUDE_TESTS=OFF

# vim: syntax=make
