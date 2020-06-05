# -*-makefile-*-
#
# Copyright (C) 2008 by Sascha Hauer
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBFSL_VPU) += libfsl-vpu

#
# Paths and names
#
LIBFSL_VPU_VERSION	:= 0.1.0
LIBFSL_VPU_MD5		:= c98dd0c638d66d0648b5d2e1a964dd6b
LIBFSL_VPU		:= libfsl-vpu-$(LIBFSL_VPU_VERSION)
LIBFSL_VPU_SUFFIX	:= tar.bz2
LIBFSL_VPU_URL		:= http://www.pengutronix.de/software/ptxdist/temporary-src/$(LIBFSL_VPU).$(LIBFSL_VPU_SUFFIX)
LIBFSL_VPU_SOURCE	:= $(SRCDIR)/$(LIBFSL_VPU).$(LIBFSL_VPU_SUFFIX)
LIBFSL_VPU_DIR		:= $(BUILDDIR)/$(LIBFSL_VPU)
LIBFSL_VPU_LICENSE	:= LGPL-2.1-or-later
LIBFSL_VPU_LICENSE_FILES	:= file://src/vpu_lib.c;md5=58db5f82e0a28dfe42bf9885eb4733a3;startline=7;endline=14

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBFSL_VPU_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-debug

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libfsl-vpu.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libfsl-vpu)
	@$(call install_fixup, libfsl-vpu,PRIORITY,optional)
	@$(call install_fixup, libfsl-vpu,SECTION,base)
	@$(call install_fixup, libfsl-vpu,AUTHOR,"Sascha Hauer <s.hauer@pengutronix.de>")
	@$(call install_fixup, libfsl-vpu,DESCRIPTION,missing)

	@$(call install_lib, libfsl-vpu, 0, 0, 0644, libfsl-vpu-0.1.0)

	@$(call install_finish, libfsl-vpu)

	@$(call touch)

# vim: syntax=make
