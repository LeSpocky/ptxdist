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
PACKAGES-$(PTXCONF_XORG_FONT_TTF_VLGOTHIC) += xorg-font-ttf-vlgothic

#
# Paths and names
#
XORG_FONT_TTF_VLGOTHIC_VERSION	:= 20230918
XORG_FONT_TTF_VLGOTHIC_MD5	:= 739a9f9995e398bc5cb9ce5697a8691c
XORG_FONT_TTF_VLGOTHIC		:= VLGothic-$(XORG_FONT_TTF_VLGOTHIC_VERSION)
XORG_FONT_TTF_VLGOTHIC_SUFFIX	:= tar.xz
XORG_FONT_TTF_VLGOTHIC_URL	:= https://vlgothic.dicey.org/releases/$(XORG_FONT_TTF_VLGOTHIC).$(XORG_FONT_TTF_VLGOTHIC_SUFFIX)
XORG_FONT_TTF_VLGOTHIC_SOURCE	:= $(SRCDIR)/$(XORG_FONT_TTF_VLGOTHIC).$(XORG_FONT_TTF_VLGOTHIC_SUFFIX)
XORG_FONT_TTF_VLGOTHIC_DIR	:= $(BUILDDIR)/$(XORG_FONT_TTF_VLGOTHIC)
XORG_FONT_TTF_VLGOTHIC_LICENSE	:= public_domain AND mplus AND BSD-3-Clause
XORG_FONT_TTF_VLGOTHIC_LICENSE_FILES := \
	file://LICENSE;md5=963a56e726d3de416451f272c2f25758 \
	file://LICENSE_E.mplus;md5=1c4767416f20215f1e61b970f2117db9 \
	file://LICENSE.en;md5=cc06b20e7a20bdf6c989624405378303 \
	file://LICENSE_J.mplus;md5=0ec236dad673c87025379b1dc91ad7bd \
	file://README.sazanami;encoding=euc-jp;md5=97d739900be6e852830f55aa3c07d4a0

XORG_FONT_TTF_VLGOTHIC_CONF_TOOL	:= NO
XORG_FONT_TTF_VLGOTHIC_FONTDIR		:= $(XORG_FONTDIR)/truetype/vlgothic

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-vlgothic.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-vlgothic.install:
	@$(call targetinfo)
	@$(call world/install-fonts,XORG_FONT_TTF_VLGOTHIC,*.ttf)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-vlgothic.targetinstall:
	@$(call targetinfo)
	@$(call install_init, xorg-font-ttf-vlgothic)
	@$(call install_fixup, xorg-font-ttf-vlgothic,PRIORITY,optional)
	@$(call install_fixup, xorg-font-ttf-vlgothic,SECTION,base)
	@$(call install_fixup, xorg-font-ttf-vlgothic,AUTHOR,"Florian Bäuerle <florian.baeuerle@allegion.com>")
	@$(call install_fixup, xorg-font-ttf-vlgothic,DESCRIPTION,missing)

	@$(call install_tree, xorg-font-ttf-vlgothic, 0, 0, -, /usr)

	@$(call install_finish, xorg-font-ttf-vlgothic)
	@$(call touch)

# vim: syntax=make
