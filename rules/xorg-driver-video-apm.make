# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_DRIVER_VIDEO_APM) += xorg-driver-video-apm

#
# Paths and names
#
XORG_DRIVER_VIDEO_APM_VERSION	:= 1.3.0
XORG_DRIVER_VIDEO_APM_MD5	:= 6f59f323c6d3fe7217a8728f17c137a6
XORG_DRIVER_VIDEO_APM		:= xf86-video-apm-$(XORG_DRIVER_VIDEO_APM_VERSION)
XORG_DRIVER_VIDEO_APM_SUFFIX	:= tar.bz2
XORG_DRIVER_VIDEO_APM_URL	:= $(call ptx/mirror, XORG, individual/driver/$(XORG_DRIVER_VIDEO_APM).$(XORG_DRIVER_VIDEO_APM_SUFFIX))
XORG_DRIVER_VIDEO_APM_SOURCE	:= $(SRCDIR)/$(XORG_DRIVER_VIDEO_APM).$(XORG_DRIVER_VIDEO_APM_SUFFIX)
XORG_DRIVER_VIDEO_APM_DIR	:= $(BUILDDIR)/$(XORG_DRIVER_VIDEO_APM)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_DRIVER_VIDEO_APM_CONF_TOOL := autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-driver-video-apm.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-driver-video-apm)
	@$(call install_fixup, xorg-driver-video-apm,PRIORITY,optional)
	@$(call install_fixup, xorg-driver-video-apm,SECTION,base)
	@$(call install_fixup, xorg-driver-video-apm,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-driver-video-apm,DESCRIPTION,missing)

	@$(call install_lib, xorg-driver-video-apm, 0, 0, 0644, \
		xorg/modules/drivers/apm_drv)

	@$(call install_finish, xorg-driver-video-apm)

	@$(call touch)

# vim: syntax=make
