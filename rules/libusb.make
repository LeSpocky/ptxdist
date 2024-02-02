# -*-makefile-*-
#
# Copyright (C) 2009 by Juergen Beisert
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBUSB) += libusb

#
# Paths and names
#
LIBUSB_VERSION	:= 1.0.27
LIBUSB_MD5	:= 1fb61afe370e94f902a67e03eb39c51f
LIBUSB		:= libusb-$(LIBUSB_VERSION)
LIBUSB_SUFFIX	:= tar.bz2
LIBUSB_URL	:= $(call ptx/mirror, SF, libusb/$(LIBUSB).$(LIBUSB_SUFFIX))
LIBUSB_SOURCE	:= $(SRCDIR)/$(LIBUSB).$(LIBUSB_SUFFIX)
LIBUSB_DIR	:= $(BUILDDIR)/$(LIBUSB)
LIBUSB_LICENSE	:= LGPL-2.1-or-later
LIBUSB_LICENSE_FILES := \
	file://libusb/core.c;startline=2;endline=21;md5=e2bc3b2209f8457532820f1fc033ebec \
	file://COPYING;md5=fbc093901857fcd118f065f900982c24

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBUSB_CONF_TOOL := autoconf
LIBUSB_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--enable-shared \
	--disable-static \
	--disable-udev \
	--enable-eventfd \
	--enable-timerfd \
	--$(call ptx/endis, PTXCONF_LIBUSB_LOG)-log \
	--$(call ptx/endis, PTXCONF_LIBUSB_DEBUG_LOG)-debug-log \
	--$(call ptx/endis, PTXCONF_LIBUSB_SYSTEM_LOG)-system-log \
	--disable-examples-build \
	--disable-tests-build

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libusb.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libusb)
	@$(call install_fixup, libusb,PRIORITY,optional)
	@$(call install_fixup, libusb,SECTION,base)
	@$(call install_fixup, libusb,AUTHOR,"Juergen Beisert <j.beisert@pengutronix.de>")
	@$(call install_fixup, libusb,DESCRIPTION,missing)

	@$(call install_lib, libusb, 0, 0, 0644, libusb-1.0)

	@$(call install_finish, libusb)

	@$(call touch)

# vim: syntax=make
