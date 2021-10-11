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
PACKAGES-$(PTXCONF_DFU_UTIL) += dfu-util

#
# Paths and names
#
DFU_UTIL_VERSION	:= 0.11
DFU_UTIL_MD5		:= 31c983543a1fe8f03260ca4d56ad4f43
DFU_UTIL		:= dfu-util-$(DFU_UTIL_VERSION)
DFU_UTIL_SUFFIX		:= tar.gz
DFU_UTIL_URL		:= http://dfu-util.sourceforge.net/releases/$(DFU_UTIL).$(DFU_UTIL_SUFFIX)
DFU_UTIL_SOURCE		:= $(SRCDIR)/$(DFU_UTIL).$(DFU_UTIL_SUFFIX)
DFU_UTIL_DIR		:= $(BUILDDIR)/$(DFU_UTIL)
DFU_UTIL_LICENSE	:= GPL-2.0-or-later
DFU_UTIL_LICENSE_FILES	:= file://COPYING;md5=94d55d512a9ba36caa9b7df079bae19f
# The file 'dfuse-pack.py' has different license, but is not copied to target

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

DFU_UTIL_CONF_ENV	:= \
	$(CROSS_ENV) \
	ac_cv_lib_usb_libusb_init=no

#
# autoconf
#
DFU_UTIL_CONF_TOOL	:= autoconf
DFU_UTIL_CONF_OPT	:= \
    $(CROSS_AUTOCONF_USR) \
    $(GLOBAL_LARGE_FILE_OPTION)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/dfu-util.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  dfu-util)
	@$(call install_fixup, dfu-util,PRIORITY,optional)
	@$(call install_fixup, dfu-util,SECTION,base)
	@$(call install_fixup, dfu-util,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, dfu-util,DESCRIPTION,missing)

	@$(call install_copy, dfu-util, 0, 0, 0755, -, /usr/bin/dfu-util)

	@$(call install_finish, dfu-util)

	@$(call touch)

# vim: syntax=make
