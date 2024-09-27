# -*-makefile-*-
#
# Copyright (C) 2018 by Thomas Haemmerle <thomas.haemmerle@wolfvision.net>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBUSBGX) += libusbgx

#
# Paths and names
#
LIBUSBGX_VERSION	:= 0.3.0
LIBUSBGX_MD5		:= f2ca9c639e6fc6ee9dbecb545fa61637
LIBUSBGX		:= libusbgx-v$(LIBUSBGX_VERSION)
LIBUSBGX_SUFFIX		:= tar.gz
LIBUSBGX_URL		:= https://github.com/linux-usb-gadgets/libusbgx/archive/refs/tags/libusbgx-v$(LIBUSBGX_VERSION).$(LIBUSBGX_SUFFIX)
LIBUSBGX_SOURCE		:= $(SRCDIR)/$(LIBUSBGX).$(LIBUSBGX_SUFFIX)
LIBUSBGX_DIR		:= $(BUILDDIR)/$(LIBUSBGX)
LIBUSBGX_LICENSE	:= GPL-2.0-or-later AND LGPL-2.1-or-later
LIBUSBGX_LICENSE_FILES	:= \
	file://examples/gadget-export.c;startline=6;endline=14;md5=89ff91d940b4bc09b6de0300b34a888f \
	file://COPYING;md5=b234ee4d69f5fce4486a80fdaf4a4263 \
	file://src/usbg.c;startline=10;endline=18;md5=75c08ee73fa8cdd35281fdcbe8874ff5 \
	file://COPYING.LGPL;md5=4fbd65380cdd255951079008b364516c

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# meson
#
LIBUSBGX_CONF_TOOL	:= meson
LIBUSBGX_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Dexamples=true \
	-Dtests=disabled \
	-Dgadget-schemes=$(call ptx/endis, PTXCONF_LIBUSBGX_SCHEMES)d \
	-Ddoxygen=disabled

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libusbgx.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libusbgx)
	@$(call install_fixup, libusbgx, PRIORITY, optional)
	@$(call install_fixup, libusbgx, SECTION, base)
	@$(call install_fixup, libusbgx, AUTHOR, "Thomas Haemmerle <thomas.haemmerle@wolfvision.net>")
	@$(call install_fixup, libusbgx, DESCRIPTION, missing)

	@$(call install_lib, libusbgx, 0, 0, 0644, libusbgx)

ifdef PTXCONF_SHOW_GADGETS
	@$(call install_copy, libusbgx, 0, 0, 0755, -, /usr/bin/show-gadgets)
endif

ifdef PTXCONF_SHOW_UDCS
	@$(call install_copy, libusbgx, 0, 0, 0755, -, /usr/bin/show-udcs)
endif

ifdef PTXCONF_GADGET_VID_PID_REMOVE
	@$(call install_copy, libusbgx, 0, 0, 0755, -, /usr/bin/gadget-vid-pid-remove)
endif

ifdef PTXCONF_GADGET_IMPORT
	@$(call install_copy, libusbgx, 0, 0, 0755, -, /usr/bin/gadget-import)
endif

ifdef PTXCONF_GADGET_EXPORT
	@$(call install_copy, libusbgx, 0, 0, 0755, -, /usr/bin/gadget-export)
endif

ifdef PTXCONF_GADGET_ACM_ECM
	@$(call install_copy, libusbgx, 0, 0, 0755, -, /usr/bin/gadget-acm-ecm)
endif

ifdef PTXCONF_GADGET_UVC
	@$(call install_copy, libusbgx, 0, 0, 0755, -, /usr/bin/gadget-uvc)
endif

ifdef PTXCONF_GADGET_FFS
	@$(call install_copy, libusbgx, 0, 0, 0755, -, /usr/bin/gadget-ffs)
endif

ifdef PTXCONF_GADGET_MS
	@$(call install_copy, libusbgx, 0, 0, 0755, -, /usr/bin/gadget-ms)
endif

ifdef PTXCONF_GADGET_MIDI
	@$(call install_copy, libusbgx, 0, 0, 0755, -, /usr/bin/gadget-midi)
endif

ifdef PTXCONF_GADGET_HID
	@$(call install_copy, libusbgx, 0, 0, 0755, -, /usr/bin/gadget-hid)
endif

ifdef PTXCONF_GADGET_UAC2
	@$(call install_copy, libusbgx, 0, 0, 0755, -, /usr/bin/gadget-uac2)
endif

ifdef PTXCONF_GADGET_RNDIS_OS_DESC
	@$(call install_copy, libusbgx, 0, 0, 0755, -, /usr/bin/gadget-rndis-os-desc)
endif

	@$(call install_finish, libusbgx)

	@$(call touch)

# vim: syntax=make
