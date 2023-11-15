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
FONTCONFIG_VERSION	:= 2.14.2
FONTCONFIG_MD5		:= c5536d897c5d52422a00ecee742ccf47
FONTCONFIG		:= fontconfig-$(FONTCONFIG_VERSION)
FONTCONFIG_SUFFIX	:= tar.gz
FONTCONFIG_URL		:= http://fontconfig.org/release/$(FONTCONFIG).$(FONTCONFIG_SUFFIX)
FONTCONFIG_SOURCE	:= $(SRCDIR)/$(FONTCONFIG).$(FONTCONFIG_SUFFIX)
FONTCONFIG_DIR		:= $(BUILDDIR)/$(FONTCONFIG)
FONTCONFIG_LICENSE	:= HPND-sell-variant AND MIT AND custom AND MIT-Modern-Variant AND Unicode-TOU and public_domain
FONTCONFIG_LICENSE_FILES	:= \
	file://COPYING;md5=00252fd272bf2e722925613ad74cb6c7 \
	file://src/ftglue.c;startline=1;endline=8;md5=789386c3d7c853bbce055520a11aaeb9 \
	file://src/fcatomic.h;startline=4;endline=24;md5=89c79dedb0fb324bfa2fae6b7bf7f673 \
	file://fc-case/CaseFolding.txt;startline=3;endline=6;md5=22a71642d1bac5fcefffd1f9f35cdf27

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

FONTCONFIG_CONF_ENV	:=  \
	$(CROSS_ENV) \
	ac_cv_prog_HASDOCBOOK=no

#
# autoconf
#
FONTCONFIG_CONF_TOOL	:= autoconf
FONTCONFIG_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-nls \
	--disable-rpath \
	--$(call ptx/endis, PTXCONF_ICONV)-iconv \
	--disable-libxml2 \
	--disable-docbook \
	--disable-docs \
	--disable-cache-build \
	--with-arch=$(PTXCONF_ARCH_STRING) \
	--with-default-hinting=slight \
	--with-default-fonts=$(XORG_FONTDIR) \
	--with-cache-dir=/var/cache/fontconfig

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
