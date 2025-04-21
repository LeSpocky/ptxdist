# -*-makefile-*-
#
# Copyright (C) 2019 by Michael Tretter <m.tretter@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_UVC_GADGET) += uvc-gadget

#
# Paths and names
#
UVC_GADGET_VERSION	:= 0.3.0
UVC_GADGET_MD5		:= 087c77cbeabf72933ea61021e228aa35
UVC_GADGET		:= uvc-gadget-v$(UVC_GADGET_VERSION)
UVC_GADGET_SUFFIX	:= tar.xz
UVC_GADGET_URL		:= \
	git://git.ideasonboard.org/uvc-gadget.git;tag=v$(UVC_GADGET_VERSION) \
	https://gitlab.freedesktop.org/camera/uvc-gadget.git;tag=v$(UVC_GADGET_VERSION)
UVC_GADGET_SOURCE	:= $(SRCDIR)/$(UVC_GADGET).$(UVC_GADGET_SUFFIX)
UVC_GADGET_DIR		:= $(BUILDDIR)/$(UVC_GADGET)
UVC_GADGET_LICENSE	:= GPL-2.0-or-later AND LGPL-2.1-or-later AND MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

UVC_GADGET_CONF_TOOL	:= meson
UVC_GADGET_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Dwerror=false

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/uvc-gadget.targetinstall:
	@$(call targetinfo)

	@$(call install_init, uvc-gadget)
	@$(call install_fixup, uvc-gadget,PRIORITY,optional)
	@$(call install_fixup, uvc-gadget,SECTION,base)
	@$(call install_fixup, uvc-gadget,AUTHOR,"Michael Tretter <m.tretter@pengutronix.de>")
	@$(call install_fixup, uvc-gadget,DESCRIPTION,missing)

	@$(call install_lib, uvc-gadget, 0, 0, 0755, libuvcgadget)
	@$(call install_copy, uvc-gadget, 0, 0, 0755, -, /usr/bin/uvc-gadget)

	@$(call install_finish, uvc-gadget)

	@$(call touch)

# vim: syntax=make
