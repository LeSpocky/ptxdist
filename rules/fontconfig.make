# -*-makefile-*-
#
# Copyright (C) 2006 by Robert Schwebel
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_FONTCONFIG) += fontconfig

#
# Paths and names
#
FONTCONFIG_VERSION	:= 2.17.1
FONTCONFIG_MD5		:= 1a1f5336105e5b80f36dce7dabe04d1a
FONTCONFIG		:= fontconfig-$(FONTCONFIG_VERSION)
FONTCONFIG_SUFFIX	:= tar.gz
FONTCONFIG_URL		:= https://gitlab.freedesktop.org/fontconfig/fontconfig/-/archive/$(FONTCONFIG_VERSION)/$(FONTCONFIG).$(FONTCONFIG_SUFFIX)
FONTCONFIG_SOURCE	:= $(SRCDIR)/$(FONTCONFIG).$(FONTCONFIG_SUFFIX)
FONTCONFIG_DIR		:= $(BUILDDIR)/$(FONTCONFIG)
FONTCONFIG_LICENSE	:= HPND-sell-variant AND MIT AND custom AND MIT-Modern-Variant AND Unicode-TOU and public_domain
FONTCONFIG_LICENSE_FILES	:= \
	file://COPYING;md5=00252fd272bf2e722925613ad74cb6c7 \
	file://src/ftglue.c;startline=1;endline=8;md5=789386c3d7c853bbce055520a11aaeb9 \
	file://src/fcatomic.h;startline=4;endline=24;md5=89c79dedb0fb324bfa2fae6b7bf7f673 \
	file://fc-case/CaseFolding.txt;startline=3;endline=6;md5=335eb5842569668c6fe6ea50d00157ef

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

FONTCONFIG_CONF_TOOL	:= meson
FONTCONFIG_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Dbaseconfig-dir=default \
	-Dbitmap-conf=no-except-emoji \
	-Dcache-build=disabled \
	-Dcache-dir=/var/cache/fontconfig \
	-Ddefault-hinting=slight \
	-Ddefault-fonts-dirs=[\'$(XORG_FONTDIR)\'] \
	-Ddefault-sub-pixel-rendering=none \
	-Ddoc=disabled \
	-Dfontations=disabled \
	-Diconv=$(call ptx/endis, PTXCONF_ICONV)d \
	-Dnls=disabled \
	-Dtests=disabled \
	-Dtools=enabled \
	-Dxml-backend=expat

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/fontconfig.targetinstall:
	@$(call targetinfo)

	@$(call install_init, fontconfig)
	@$(call install_fixup, fontconfig,PRIORITY,optional)
	@$(call install_fixup, fontconfig,SECTION,base)
	@$(call install_fixup, fontconfig,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, fontconfig,DESCRIPTION,missing)

	@$(call install_lib, fontconfig, 0, 0, 0644, libfontconfig)

	@$(call install_alternative, fontconfig, 0, 0, 0644, \
		/etc/fonts/fonts.conf)
	@$(call install_tree, fontconfig, 0, 0, -, /etc/fonts/conf.d)
	@$(call install_tree, fontconfig, 0, 0, -, /usr/share/fontconfig/conf.avail)

ifdef PTXCONF_FONTCONFIG_UTILS
	@$(call install_copy, fontconfig, 0, 0, 0755, -, \
		/usr/bin/fc-cache)

	@$(call install_copy, fontconfig, 0, 0, 0755, -, \
		/usr/bin/fc-list)

	@$(call install_copy, fontconfig, 0, 0, 0755, -, \
		/usr/bin/fc-match)

	@$(call install_alternative, fontconfig, 0, 0, 0755, /etc/rc.once.d/fc-cache)
endif

	@$(call install_finish, fontconfig)

	@$(call touch)

# vim: syntax=make
