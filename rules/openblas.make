# -*-makefile-*-
#
# Copyright (C) 2023 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_OPENBLAS) += openblas

#
# Paths and names
#
OPENBLAS_VERSION	:= 0.3.24
OPENBLAS_MD5		:= 23599a30e4ce887590957d94896789c8
OPENBLAS		:= openblas-$(OPENBLAS_VERSION)
OPENBLAS_SUFFIX		:= tar.gz
OPENBLAS_URL		:= https://github.com/OpenMathLib/OpenBLAS/archive/refs/tags/v$(OPENBLAS_VERSION).$(OPENBLAS_SUFFIX)
OPENBLAS_SOURCE		:= $(SRCDIR)/$(OPENBLAS).$(OPENBLAS_SUFFIX)
OPENBLAS_DIR		:= $(BUILDDIR)/$(OPENBLAS)
OPENBLAS_LICENSE	:= BSD-2-Clause AND BSD-3-Clause
OPENBLAS_LICENSE_FILES	:= \
	file://benchmark/linpack.c;startline=1;endline=37;md5=6e154d722b840bdd9d105c4a84e07d9d \
	file://LICENSE;md5=5adf4792c949a00013ce25d476a2abc0


# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ifdef PTXCONF_ARCH_ARM
OPENBLAS_TARGET := ARMV5
ifdef PTXCONF_ARCH_ARM_V7
OPENBLAS_TARGET := ARMV7
endif
ifdef PTXCONF_ARCH_ARM_V6
OPENBLAS_TARGET := ARMV6
endif
endif
ifdef PTXCONF_ARCH_ARM64
OPENBLAS_TARGET := ARMV8
endif
ifdef PTXCONF_ARCH_RISCV
OPENBLAS_TARGET := RISCV64_GENERIC
endif
ifdef PTXCONF_ARCH_X86
ifdef PTXCONF_ARCH_X86_64
# not optimized but at least it compiles
OPENBLAS_TARGET := PRESCOTT
OPENBLAS_CFLAGS := -DGENERIC
else
OPENBLAS_TARGET := ATOM
endif
endif

OPENBLAS_CONF_TOOL	:= cmake
OPENBLAS_CONF_OPT	:= \
	$(CROSS_CMAKE_USR) \
	-G Ninja \
	-DBUILD_LAPACK_DEPRECATED=ON \
	-DBUILD_RELAPACK=OFF \
	-DBUILD_STATIC_LIBS=OFF \
	-DBUILD_TESTING=OFF \
	-DBUILD_WITHOUT_CBLAS=OFF \
	-DBUILD_WITHOUT_LAPACK=OFF \
	-DCPP_THREAD_SAFETY_GEMV=OFF \
	-DCPP_THREAD_SAFETY_TEST=OFF \
	-DC_LAPACK=$(call ptx/onoff,PTXCONF_OPENBLAS_C_LAPACK) \
	-DDYNAMIC_ARCH=OFF \
	-DDYNAMIC_OLDER=OFF \
	-DNO_AFFINITY=ON \
	-DNO_WARMUP=ON \
	-DSYMBOLPREFIX= \
	-DSYMBOLSUFFIX= \
	-DUSE_LOCKING=OFF \
	-DUSE_PERL=OFF \
	\
	-DBUILD_SHARED_LIBS=ON \
	-DTARGET=$(OPENBLAS_TARGET)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/openblas.targetinstall:
	@$(call targetinfo)

	@$(call install_init, openblas)
	@$(call install_fixup, openblas,PRIORITY,optional)
	@$(call install_fixup, openblas,SECTION,base)
	@$(call install_fixup, openblas,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, openblas,DESCRIPTION,missing)

	@$(call install_lib, openblas, 0, 0, 0644, libopenblas)

	@$(call install_finish, openblas)

	@$(call touch)

# vim: syntax=make
