# -*-makefile-*-
#
# Copyright (C) 2018 by Thomas Haemmerle <thomas.haemmerle@wolfvision.net>
#
# See CREDITS for details about who has contributed to this project.
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
LIBUSBGX_VERSION	:= 0.2.0
LIBUSBGX_MD5		:= a8ea2234c6355ac8ad2ca86c453297bd
LIBUSBGX		:= libusbgx-$(LIBUSBGX_VERSION)
LIBUSBGX_SUFFIX		:= zip
LIBUSBGX_URL		:= \
	https://github.com/libusbgx/libusbgx/archive/libusbgx-v$(LIBUSBGX_VERSION).zip
LIBUSBGX_SOURCE	:= \
	$(SRCDIR)/$(LIBUSBGX).$(LIBUSBGX_SUFFIX)
LIBUSBGX_DIR		:= $(BUILDDIR)/$(LIBUSBGX)
LIBUSBGX_LICENSE	:= GPLv2

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBUSBGX_CONF_ENV	:= $(CROSS_ENV)

#
# autoconf
#
LIBUSBGX_CONF_TOOL	:= autoconf
LIBUSBGX_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--without-libconfig \
	--enable-examples \
	--disable-gadget-schemes

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
	@$(call install_copy, libusbgx, 0, 0, 0755, -, /usr/bin/show-gadgets)
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
