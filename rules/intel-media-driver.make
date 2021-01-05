# -*-makefile-*-
#
# Copyright (C) 2019 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ARCH_X86)-$(PTXCONF_INTEL_MEDIA_DRIVER) += intel-media-driver

#
# Paths and names
#
INTEL_MEDIA_DRIVER_VERSION	:= 20.4.5
INTEL_MEDIA_DRIVER_MD5		:= a4bae0e0be6ce203dd761aebf45f5d9a
INTEL_MEDIA_DRIVER		:= intel-media-$(INTEL_MEDIA_DRIVER_VERSION)
INTEL_MEDIA_DRIVER_SUFFIX	:= tar.gz
INTEL_MEDIA_DRIVER_URL		:= https://github.com/intel/media-driver/archive/$(INTEL_MEDIA_DRIVER).$(INTEL_MEDIA_DRIVER_SUFFIX)
INTEL_MEDIA_DRIVER_SOURCE	:= $(SRCDIR)/$(INTEL_MEDIA_DRIVER).$(INTEL_MEDIA_DRIVER_SUFFIX)
INTEL_MEDIA_DRIVER_DIR		:= $(BUILDDIR)/$(INTEL_MEDIA_DRIVER)
INTEL_MEDIA_DRIVER_LICENSE	:= MIT AND BSD-3-Clause

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# cmake
#
INTEL_MEDIA_DRIVER_CONF_TOOL	:= cmake
INTEL_MEDIA_DRIVER_CONF_OPT	:= \
	$(CROSS_CMAKE_USR) \
	-G Ninja \
	-DBUILD_CMRTLIB=OFF \
	-DENABLE_KERNELS=ON \
	-DENABLE_NONFREE_KERNELS=ON \
	-DENABLE_PRODUCTION_KMD=OFF \
	-DINSTALL_DRIVER_SYSCONF=OFF \
	-DMEDIA_BUILD_FATAL_WARNINGS=OFF \
	-DMEDIA_RUN_TEST_SUITE=OFF \
	\
	-DBYPASS_MEDIA_ULT=yes \
	-DCMAKE_DISABLE_FIND_PACKAGE_X11=$(call ptx/ifdef,PTXCONF_INTEL_MEDIA_DRIVER_X11,OFF,ON)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/intel-media-driver.targetinstall:
	@$(call targetinfo)

	@$(call install_init, intel-media-driver)
	@$(call install_fixup, intel-media-driver,PRIORITY,optional)
	@$(call install_fixup, intel-media-driver,SECTION,base)
	@$(call install_fixup, intel-media-driver,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, intel-media-driver,DESCRIPTION,missing)

	@$(call install_lib, intel-media-driver, 0, 0, 0644, dri/iHD_drv_video)

	@$(call install_finish, intel-media-driver)

	@$(call touch)

# vim: syntax=make
