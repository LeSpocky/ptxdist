# -*-makefile-*-
#
# Copyright (C) 2025 by Fabian Pfitzner <f.pfitzner@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_OPENH264) += openh264

#
# Paths and names
#
OPENH264_VERSION	:= 2.6.0
OPENH264_MD5		:= 0b01f0279eca1c7bb65395ea350fa85c
OPENH264		:= OpenH264-$(OPENH264_VERSION)
OPENH264_SUFFIX		:= tar.gz
OPENH264_URL		:= https://github.com/cisco/openh264/archive/refs/tags/v$(OPENH264_VERSION).$(OPENH264_SUFFIX)
OPENH264_SOURCE		:= $(SRCDIR)/$(OPENH264).$(OPENH264_SUFFIX)
OPENH264_DIR		:= $(BUILDDIR)/$(OPENH264)
OPENH264_LICENSE	:= BSD 2-Clause
OPENH264_LICENSE_FILES	:= file://LICENSE;md5=bb6d3771da6a07d33fd50d4d9aa73bcf

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

OPENH264_CONF_TOOL	:= meson
OPENH264_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Dtests=disabled

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/openh264.targetinstall:
	@$(call targetinfo)

	@$(call install_init, openh264)
	@$(call install_fixup, openh264,PRIORITY,optional)
	@$(call install_fixup, openh264,SECTION,base)
	@$(call install_fixup, openh264,AUTHOR,"Fabian Pfitzner <f.pfitzner@pengutronix.de>")
	@$(call install_fixup, openh264,DESCRIPTION,missing)

	@$(call install_lib, openh264, 0, 0, 0644, libopenh264)

	@$(call install_finish, openh264)

	@$(call touch)

# vim: syntax=make
