# -*-makefile-*-
#
# Copyright (C) 2007 by Sascha Hauer
#               2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_USBUTILS) += usbutils

#
# Paths and names
#
USBUTILS_VERSION	:= 018
USBUTILS_MD5		:= 0a351e2241c50a1f026a455dccf24d73
USBUTILS		:= usbutils-$(USBUTILS_VERSION)
USBUTILS_SUFFIX		:= tar.xz
USBUTILS_URL		:= $(call ptx/mirror, KERNEL, utils/usb/usbutils/$(USBUTILS).$(USBUTILS_SUFFIX))
USBUTILS_SOURCE		:= $(SRCDIR)/$(USBUTILS).$(USBUTILS_SUFFIX)
USBUTILS_DIR		:= $(BUILDDIR)/$(USBUTILS)
USBUTILS_LICENSE	:= GPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# meson
#
USBUTILS_CONF_TOOL	:= meson
USBUTILS_CONF_OPT	:= \
	$(CROSS_MESON_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/usbutils.targetinstall:
	@$(call targetinfo)

	@$(call install_init, usbutils)
	@$(call install_fixup, usbutils,PRIORITY,optional)
	@$(call install_fixup, usbutils,SECTION,base)
	@$(call install_fixup, usbutils,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, usbutils,DESCRIPTION,missing)

ifdef PTXCONF_USBUTILS_LSUSB
	@$(call install_copy, usbutils, 0, 0, 0755, -, /usr/bin/lsusb)
endif
ifdef PTXCONF_USBUTILS_USBHIDDUMP
	@$(call install_copy, usbutils, 0, 0, 0755, -, /usr/bin/usbhid-dump)
endif
ifdef PTXCONF_USBUTILS_USBDEVICES
	@$(call install_copy, usbutils, 0, 0, 0755, -, /usr/bin/usb-devices)
endif

	@$(call install_finish, usbutils)

	@$(call touch)

# vim: syntax=make
