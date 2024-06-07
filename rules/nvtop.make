# -*-makefile-*-
#
# Copyright (C) 2023 by Philipp Zabel <p.zabel@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_NVTOP) += nvtop

#
# Paths and names
#
NVTOP_VERSION	:= 3.1.0
NVTOP_MD5	:= bdf8217412aa12f54448f14bb49bb164
NVTOP		:= nvtop-$(NVTOP_VERSION)
NVTOP_SUFFIX	:= tar.gz
NVTOP_URL	:= https://github.com/Syllo/nvtop/archive/refs/tags/$(NVTOP_VERSION).$(NVTOP_SUFFIX)
NVTOP_SOURCE	:= $(SRCDIR)/$(NVTOP).$(NVTOP_SUFFIX)
NVTOP_DIR	:= $(BUILDDIR)/$(NVTOP)
NVTOP_LICENSE	:= GPL-3.0-or-later
NVTOP_LICENSE_FILES := \
	file://COPYING;md5=d32239bcb673463ab874e80d47fae504

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# cmake
#
NVTOP_CONF_TOOL	:= cmake
NVTOP_CONF_OPT	:= \
	$(CROSS_CMAKE_USR) \
	-DNVIDIA_SUPPORT=$(call ptx/onoff, PTXCONF_NVTOP_NVIDIA) \
	-DAMDGPU_SUPPORT=$(call ptx/onoff, PTXCONF_NVTOP_AMDGPU) \
	-DINTEL_SUPPORT=$(call ptx/onoff, PTXCONF_NVTOP_INTEL) \
	-DMSM_SUPPORT=$(call ptx/onoff, PTXCONF_NVTOP_MSM) \
	-DAPPLE_SUPPORT=off \
	-DPANFROST_SUPPORT=$(call ptx/onoff, PTXCONF_NVTOP_PANFROST) \
	-DPANTHOR_SUPPORT=$(call ptx/onoff, PTXCONF_NVTOP_PANTHOR) \
	-DASCEND_SUPPORT=off

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/nvtop.targetinstall:
	@$(call targetinfo)

	@$(call install_init, nvtop)
	@$(call install_fixup, nvtop, PRIORITY, optional)
	@$(call install_fixup, nvtop, SECTION, base)
	@$(call install_fixup, nvtop, AUTHOR, "Philipp Zabel <p.zabel@pengutronix.de>")
	@$(call install_fixup, nvtop, DESCRIPTION, missing)

	@$(call install_copy, nvtop, 0, 0, 0755, -, /usr/bin/nvtop)

	@$(call install_finish, nvtop)

	@$(call touch)

# vim: syntax=make
