# -*-makefile-*-
#
# Copyright (C) 2006,2010 by Erwin Rol <erwin@erwinrol.com>
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ARCH_X86)-$(PTXCONF_XORG_DRIVER_VIDEO_INTEL) += xorg-driver-video-intel

#
# Paths and names
#
XORG_DRIVER_VIDEO_INTEL_VERSION	:= 2.99.917-892-gc6cb1b199598
XORG_DRIVER_VIDEO_INTEL_MD5	:= 671973850a065968455910e904704fec
XORG_DRIVER_VIDEO_INTEL		:= xf86-video-intel-$(XORG_DRIVER_VIDEO_INTEL_VERSION)
XORG_DRIVER_VIDEO_INTEL_SUFFIX	:= tar.bz2
XORG_DRIVER_VIDEO_INTEL_URL	:= https://gitlab.freedesktop.org/xorg/driver/xf86-video-intel/-/archive/$(XORG_DRIVER_VIDEO_INTEL_VERSION)/$(XORG_DRIVER_VIDEO_INTEL).$(XORG_DRIVER_VIDEO_INTEL_SUFFIX)
XORG_DRIVER_VIDEO_INTEL_SOURCE	:= $(SRCDIR)/$(XORG_DRIVER_VIDEO_INTEL).$(XORG_DRIVER_VIDEO_INTEL_SUFFIX)
XORG_DRIVER_VIDEO_INTEL_DIR	:= $(BUILDDIR)/$(XORG_DRIVER_VIDEO_INTEL)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_DRIVER_VIDEO_INTEL_CONF_TOOL	:= autoconf
XORG_DRIVER_VIDEO_INTEL_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-backlight \
	--disable-backlight-helper \
	--disable-gen4asm \
	--enable-udev \
	--disable-tools \
	--$(call ptx/endis, PTXCONF_XORG_DRIVER_VIDEO_INTEL_DRI)-dri \
	--$(call ptx/endis, PTXCONF_XORG_DRIVER_VIDEO_INTEL_DRI)-dri1 \
	--$(call ptx/endis, PTXCONF_XORG_DRIVER_VIDEO_INTEL_DRI)-dri2 \
	--$(call ptx/endis, PTXCONF_XORG_DRIVER_VIDEO_INTEL_DRI)-dri3 \
	--$(call ptx/endis, PTXCONF_XORG_DRIVER_VIDEO_INTEL_XVMC)-xvmc \
	--enable-kms \
	--disable-ums \
	--enable-kms-only \
	--disable-ums-only \
	--disable-sna \
	--enable-uxa \
	--disable-xaa \
	--disable-dga \
	--disable-tear-free \
	--disable-create2 \
	--disable-async-swap \
	--disable-debug \
	--disable-valgrind

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-driver-video-intel.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-driver-video-intel)
	@$(call install_fixup, xorg-driver-video-intel,PRIORITY,optional)
	@$(call install_fixup, xorg-driver-video-intel,SECTION,base)
	@$(call install_fixup, xorg-driver-video-intel,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, xorg-driver-video-intel,DESCRIPTION,missing)

	@$(call install_lib, xorg-driver-video-intel, 0, 0, 0644, \
		xorg/modules/drivers/intel_drv)

ifdef PTXCONF_XORG_DRIVER_VIDEO_INTEL_XVMC
	@$(call install_lib, xorg-driver-video-intel, 0, 0, 0644, libIntelXvMC)
endif
	@$(call install_finish, xorg-driver-video-intel)

	@$(call touch)

# vim: syntax=make
