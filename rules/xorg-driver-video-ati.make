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
PACKAGES-$(PTXCONF_XORG_DRIVER_VIDEO_ATI) += xorg-driver-video-ati

#
# Paths and names
#
XORG_DRIVER_VIDEO_ATI_VERSION	:= 19.0.1
XORG_DRIVER_VIDEO_ATI_MD5	:= 47eccf71823206ade9629cba69de7ef6
XORG_DRIVER_VIDEO_ATI		:= xf86-video-ati-$(XORG_DRIVER_VIDEO_ATI_VERSION)
XORG_DRIVER_VIDEO_ATI_SUFFIX	:= tar.bz2
XORG_DRIVER_VIDEO_ATI_URL	:= $(call ptx/mirror, XORG, individual/driver/$(XORG_DRIVER_VIDEO_ATI).$(XORG_DRIVER_VIDEO_ATI_SUFFIX))
XORG_DRIVER_VIDEO_ATI_SOURCE	:= $(SRCDIR)/$(XORG_DRIVER_VIDEO_ATI).$(XORG_DRIVER_VIDEO_ATI_SUFFIX)
XORG_DRIVER_VIDEO_ATI_DIR	:= $(BUILDDIR)/$(XORG_DRIVER_VIDEO_ATI)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_DRIVER_VIDEO_ATI_CONF_TOOL	:= autoconf
XORG_DRIVER_VIDEO_ATI_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--enable-udev \
	--disable-glamor

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-driver-video-ati.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-driver-video-ati)
	@$(call install_fixup, xorg-driver-video-ati,PRIORITY,optional)
	@$(call install_fixup, xorg-driver-video-ati,SECTION,base)
	@$(call install_fixup, xorg-driver-video-ati,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-driver-video-ati,DESCRIPTION,missing)

	@$(call install_lib, xorg-driver-video-ati, 0, 0, 0644, \
		xorg/modules/drivers/ati_drv)
	@$(call install_lib, xorg-driver-video-ati, 0, 0, 0644, \
		xorg/modules/drivers/radeon_drv)

	@$(call install_finish, xorg-driver-video-ati)

	@$(call touch)

# vim: syntax=make
