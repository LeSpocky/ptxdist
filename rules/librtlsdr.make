# -*-makefile-*-
#
# Copyright (C) 2021 by Christian Melki <christian.melki@t2data.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBRTLSDR) += librtlsdr

#
# Paths and names
#
LIBRTLSDR_VERSION	:= 0.9.0
LIBRTLSDR_MD5		:= 18169e5e6a9980bb102c6d61fc36e12e
LIBRTLSDR		:= librtlsdr-$(LIBRTLSDR_VERSION)
LIBRTLSDR_SUFFIX	:= tar.gz
LIBRTLSDR_URL		:= https://github.com/librtlsdr/librtlsdr/archive/refs/tags/v$(LIBRTLSDR_VERSION).$(LIBRTLSDR_SUFFIX)
LIBRTLSDR_SOURCE	:= $(SRCDIR)/$(LIBRTLSDR).$(LIBRTLSDR_SUFFIX)
LIBRTLSDR_DIR		:= $(BUILDDIR)/$(LIBRTLSDR)
LIBRTLSDR_LICENSE	:= GPL-2.0-only
LIBRTLSDR_LICENSE_FILES	:= \
	file://COPYING;md5=751419260aa954499f7abaabaa882bbe

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBRTLSDR_CONF_TOOL := cmake
LIBRTLSDR_CONF_OPT := \
	$(CROSS_CMAKE_USR) \
	-DLIB_INSTALL_DIR=/usr/lib \
	-DENABLE_SHARED=ON \
	-DINSTALL_UDEV_RULES=ON

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/librtlsdr.targetinstall:
	@$(call targetinfo)
	@$(call install_init, librtlsdr)
	@$(call install_fixup, librtlsdr,PRIORITY,optional)
	@$(call install_fixup, librtlsdr,SECTION,base)
	@$(call install_fixup, librtlsdr,AUTHOR,"Christian Melki <christian.melki@t2data.com>")
	@$(call install_fixup, librtlsdr,DESCRIPTION,missing)
	@$(call install_lib, librtlsdr, 0, 0, 0644, librtlsdr)

ifdef PTXCONF_LIBRTLSDR_TOOLS
	@$(call install_glob, librtlsdr, 0, 0, -, /usr/bin, *rtl_*,)
endif

ifdef PTXCONF_LIBRTLSDR_UDEV
	@$(call install_copy, librtlsdr, 0, 0, 0644, \
		$(LIBRTLSDR_PKGDIR)/etc/udev/rules.d/rtl-sdr.rules, \
		/usr/lib/udev/rules.d/81-rtl-sdr.rules)
endif

	@$(call install_finish, librtlsdr)
	@$(call touch)

# vim: syntax=make
