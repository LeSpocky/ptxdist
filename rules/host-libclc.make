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
HOST_PACKAGES-$(PTXCONF_HOST_LIBCLC) += host-libclc

#
# Paths and names
#
HOST_LIBCLC_VERSION		:= 17.0.6
HOST_LIBCLC_MD5			:= 59b0966a95be6064dfe0b5d34f4f8615
HOST_LIBCLC			:= libclc-$(HOST_LIBCLC_VERSION)
HOST_LIBCLC_SUFFIX		:= tar.xz
HOST_LIBCLC_URL			:= https://github.com/llvm/llvm-project/releases/download/llvmorg-$(HOST_LIBCLC_VERSION)/$(HOST_LIBCLC).src.$(HOST_LIBCLC_SUFFIX)
HOST_LIBCLC_SOURCE		:= $(SRCDIR)/$(HOST_LIBCLC).$(HOST_LIBCLC_SUFFIX)
HOST_LIBCLC_DIR			:= $(HOST_BUILDDIR)/$(HOST_LIBCLC)
HOST_LIBCLC_LICENSE		:= Apache-2.0 WITH LLVM-exception
HOST_LIBCLC_LICENSE_FILES	:= \
	file://LICENSE.TXT;md5=7cc795f6cbb2d801d84336b83c8017db

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# cmake
#
HOST_LIBCLC_CONF_TOOL	:= cmake
HOST_LIBCLC_CONF_OPT	:= \
	$(HOST_CMAKE_OPT) \
	-DLLVM_TOOLS_BINARY_DIR=$(PTXDIST_SYSROOT_HOST)/usr/bin \
	-DLIBCLC_TARGETS_TO_BUILD="spirv-mesa3d-" \
	\
	-DCMAKE_CLC_COMPILER_FORCED=TRUE \
	-DCMAKE_LLAsm_COMPILER_FORCED=TRUE

# vim: syntax=make
