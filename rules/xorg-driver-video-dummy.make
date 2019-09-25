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
PACKAGES-$(PTXCONF_XORG_DRIVER_VIDEO_DUMMY) += xorg-driver-video-dummy

#
# Paths and names
#
XORG_DRIVER_VIDEO_DUMMY_VERSION	:= 0.3.8
XORG_DRIVER_VIDEO_DUMMY_MD5	:= dfd8b9d02a5f12decd474b4c52775977
XORG_DRIVER_VIDEO_DUMMY		:= xf86-video-dummy-$(XORG_DRIVER_VIDEO_DUMMY_VERSION)
XORG_DRIVER_VIDEO_DUMMY_SUFFIX	:= tar.bz2
XORG_DRIVER_VIDEO_DUMMY_URL	:= $(call ptx/mirror, XORG, individual/driver/$(XORG_DRIVER_VIDEO_DUMMY).$(XORG_DRIVER_VIDEO_DUMMY_SUFFIX))
XORG_DRIVER_VIDEO_DUMMY_SOURCE	:= $(SRCDIR)/$(XORG_DRIVER_VIDEO_DUMMY).$(XORG_DRIVER_VIDEO_DUMMY_SUFFIX)
XORG_DRIVER_VIDEO_DUMMY_DIR	:= $(BUILDDIR)/$(XORG_DRIVER_VIDEO_DUMMY)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_DRIVER_VIDEO_DUMMY_CONF_TOOL := autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-driver-video-dummy.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-driver-video-dummy)
	@$(call install_fixup, xorg-driver-video-dummy,PRIORITY,optional)
	@$(call install_fixup, xorg-driver-video-dummy,SECTION,base)
	@$(call install_fixup, xorg-driver-video-dummy,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-driver-video-dummy,DESCRIPTION,missing)

	@$(call install_lib, xorg-driver-video-dummy, 0, 0, 0644, \
		xorg/modules/drivers/dummy_drv)

	@$(call install_finish, xorg-driver-video-dummy)

	@$(call touch)

# vim: syntax=make
