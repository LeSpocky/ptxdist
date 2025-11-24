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
NVTOP_VERSION	:= 3.2.0
NVTOP_MD5	:= a4c0fcd4a4737ca682c2bf19da7c0bdb
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
	-DASCEND_SUPPORT=off \
	-DTPU_SUPPORT=OFF \
	-DV3D_SUPPORT=$(call ptx/onoff, PTXCONF_NVTOP_V3D) \
	-DBUILD_TESTING=OFF \
	-DSANITIZE_ADDRESS=OFF \
	-DSANITIZE_LINK_STATIC=OFF \
	-DSANITIZE_MEMORY=OFF \
	-DSANITIZE_THREAD=OFF \
	-DSANITIZE_UNDEFINED=OFF \
	-DUSE_LIBUDEV_OVER_LIBSYSTEMD=OFF

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
