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
# No tags: use a fake descriptive commit-ish to include the date
UVC_GADGET_VERSION	:= 2019-05-02-g105134f9
UVC_GADGET_MD5		:= cd61b910844f1d95534a8773bf63f248
UVC_GADGET		:= uvc-gadget-$(UVC_GADGET_VERSION)
UVC_GADGET_SUFFIX	:= tar.xz
UVC_GADGET_URL 		:= git://git.ideasonboard.org/uvc-gadget.git;tag=$(UVC_GADGET_VERSION)
UVC_GADGET_SOURCE	:= $(SRCDIR)/$(UVC_GADGET).$(UVC_GADGET_SUFFIX)
UVC_GADGET_DIR		:= $(BUILDDIR)/$(UVC_GADGET)
UVC_GADGET_LICENSE	:= GPL-2.0-or-later AND LGPL-2.1-or-later AND MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

UVC_GADGET_CONF_TOOL	:= cmake
UVC_GADGET_CONF_OPT	:= \
	$(CROSS_CMAKE_USR)

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

	@$(call install_copy, uvc-gadget, 0, 0, 0755, -, /usr/bin/uvc-gadget)

	@$(call install_finish, uvc-gadget)

	@$(call touch)

# vim: syntax=make
