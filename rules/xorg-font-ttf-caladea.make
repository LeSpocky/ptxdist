# -*-makefile-*-
#
# Copyright (C) 2015 by Michael Olbrich <m.olbrich@pengutronix.de>
#           (C) 2018 by Florian Bäuerle <florian.baeuerle@allegion.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_FONT_TTF_CALADEA) += xorg-font-ttf-caladea

#
# Paths and names
#
XORG_FONT_TTF_CALADEA_VERSION	:= 2020-02-11-g336a529cfad3
XORG_FONT_TTF_CALADEA_MD5	:= 6cec7803159f59d9723463463e49e660
XORG_FONT_TTF_CALADEA		:= crosextrafonts-$(XORG_FONT_TTF_CALADEA_VERSION)
XORG_FONT_TTF_CALADEA_SUFFIX	:= tar.gz
XORG_FONT_TTF_CALADEA_URL	:= https://github.com/huertatipografica/Caladea/archive/$(XORG_FONT_TTF_CALADEA_VERSION).$(XORG_FONT_TTF_CALADEA_SUFFIX)
XORG_FONT_TTF_CALADEA_SOURCE	:= $(SRCDIR)/$(XORG_FONT_TTF_CALADEA).$(XORG_FONT_TTF_CALADEA_SUFFIX)
XORG_FONT_TTF_CALADEA_DIR	:= $(BUILDDIR)/$(XORG_FONT_TTF_CALADEA)
XORG_FONT_TTF_CALADEA_LICENSE	:= OFL-1.1
XORG_FONT_TTF_CALADEA_LICENSE_FILES := \
	file://OFL.txt;md5=ea7e02ef358611c66c1b152bd1c981c4

XORG_FONT_TTF_CALADEA_CONF_TOOL	:= NO
XORG_FONT_TTF_CALADEA_FONTDIR	:= $(XORG_FONTDIR)/truetype/caladea

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-caladea.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-caladea.install:
	@$(call targetinfo)
	@$(call world/install-fonts,XORG_FONT_TTF_CALADEA,*.ttf)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-caladea.targetinstall:
	@$(call targetinfo)
	@$(call install_init,  xorg-font-ttf-caladea)
	@$(call install_fixup, xorg-font-ttf-caladea,PRIORITY,optional)
	@$(call install_fixup, xorg-font-ttf-caladea,SECTION,base)
	@$(call install_fixup, xorg-font-ttf-caladea,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, xorg-font-ttf-caladea,DESCRIPTION,missing)

	@$(call install_tree, xorg-font-ttf-caladea, 0, 0, -, /usr)

	@$(call install_finish, xorg-font-ttf-caladea)
	@$(call touch)

# vim: syntax=make
