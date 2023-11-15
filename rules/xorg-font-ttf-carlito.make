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
PACKAGES-$(PTXCONF_XORG_FONT_TTF_CARLITO) += xorg-font-ttf-carlito

#
# Paths and names
#
XORG_FONT_TTF_CARLITO_VERSION	:= 2023-03-09-g3a810cab78eb
XORG_FONT_TTF_CARLITO_MD5	:= 84f54c77587771f93ffd4917636c65d7
XORG_FONT_TTF_CARLITO		:= crosextrafonts-carlito-$(XORG_FONT_TTF_CARLITO_VERSION)
XORG_FONT_TTF_CARLITO_SUFFIX	:= tar.gz
XORG_FONT_TTF_CARLITO_URL	:= https://github.com/googlefonts/carlito/archive/$(XORG_FONT_TTF_CARLITO).$(XORG_FONT_TTF_CARLITO_SUFFIX)
XORG_FONT_TTF_CARLITO_SOURCE	:= $(SRCDIR)/$(XORG_FONT_TTF_CARLITO).$(XORG_FONT_TTF_CARLITO_SUFFIX)
XORG_FONT_TTF_CARLITO_DIR	:= $(BUILDDIR)/$(XORG_FONT_TTF_CARLITO)
XORG_FONT_TTF_CARLITO_LICENSE	:= OFL-1.1
XORG_FONT_TTF_CARLITO_LICENSE_FILES := \
	file://OFL.txt;md5=267b84c986def0f4a0ae41adfa791261

XORG_FONT_TTF_CARLITO_CONF_TOOL	:= NO
XORG_FONT_TTF_CARLITO_FONTDIR	:= $(XORG_FONTDIR)/truetype/carlito

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-carlito.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-carlito.install:
	@$(call targetinfo)
	@$(call world/install-fonts,XORG_FONT_TTF_CARLITO,*.ttf)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-carlito.targetinstall:
	@$(call targetinfo)
	@$(call install_init,  xorg-font-ttf-carlito)
	@$(call install_fixup, xorg-font-ttf-carlito,PRIORITY,optional)
	@$(call install_fixup, xorg-font-ttf-carlito,SECTION,base)
	@$(call install_fixup, xorg-font-ttf-carlito,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, xorg-font-ttf-carlito,DESCRIPTION,missing)

	@$(call install_tree, xorg-font-ttf-carlito, 0, 0, -, /usr)

	@$(call install_finish, xorg-font-ttf-carlito)
	@$(call touch)

# vim: syntax=make
