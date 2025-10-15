# -*-makefile-*-
#
# Copyright (C) 2009 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBUSB_COMPAT) += libusb-compat

#
# Paths and names
#
LIBUSB_COMPAT_VERSION	:= 0.1.8
LIBUSB_COMPAT_MD5	:= c228d0b101855769d7929e77898fd38b
LIBUSB_COMPAT		:= libusb-compat-$(LIBUSB_COMPAT_VERSION)
LIBUSB_COMPAT_SUFFIX	:= tar.bz2
LIBUSB_COMPAT_URL	:= $(call ptx/mirror, SF, libusb/$(LIBUSB_COMPAT).$(LIBUSB_COMPAT_SUFFIX))
LIBUSB_COMPAT_SOURCE	:= $(SRCDIR)/$(LIBUSB_COMPAT).$(LIBUSB_COMPAT_SUFFIX)
LIBUSB_COMPAT_DIR	:= $(BUILDDIR)/$(LIBUSB_COMPAT)
LIBUSB_COMPAT_LICENSE	:= LGPL-2.1-or-later
LIBUSB_COMPAT_LICENSE_FILES := \
	file://COPYING;md5=fbc093901857fcd118f065f900982c24 \
	file://libusb/core.c;startline=4;endline=20;md5=f4c647b16934814e5bc486a958690226

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBUSB_COMPAT_CONF_TOOL	:= autoconf
LIBUSB_COMPAT_CONF_OPT	:= $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libusb-compat.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libusb-compat)
	@$(call install_fixup, libusb-compat,PRIORITY,optional)
	@$(call install_fixup, libusb-compat,SECTION,base)
	@$(call install_fixup, libusb-compat,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libusb-compat,DESCRIPTION,missing)

	@$(call install_lib, libusb-compat, 0, 0, 0644, libusb-0.1)

	@$(call install_finish, libusb-compat)

	@$(call touch)

# vim: syntax=make
