# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_FONT_ALIAS) += xorg-font-alias

#
# Paths and names
#
XORG_FONT_ALIAS_VERSION	:= 1.0.5
XORG_FONT_ALIAS_MD5	:= 79f4c023e27d1db1dfd90d041ce89835
XORG_FONT_ALIAS		:= font-alias-$(XORG_FONT_ALIAS_VERSION)
XORG_FONT_ALIAS_SUFFIX	:= tar.xz
XORG_FONT_ALIAS_URL	:= $(call ptx/mirror, XORG, individual/font/$(XORG_FONT_ALIAS).$(XORG_FONT_ALIAS_SUFFIX))
XORG_FONT_ALIAS_SOURCE	:= $(SRCDIR)/$(XORG_FONT_ALIAS).$(XORG_FONT_ALIAS_SUFFIX)
XORG_FONT_ALIAS_DIR	:= $(BUILDDIR)/$(XORG_FONT_ALIAS)
XORG_FONT_ALIAS_LICENSE	:= Vakulenko
XORG_FONT_ALIAS_LICENSE_FILES := \
	file://COPYING;md5=bf0158b89be493d523d69d9f29265038

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_FONT_ALIAS_CONF_TOOL := autoconf
XORG_FONT_ALIAS_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--with-fontrootdir=$(XORG_FONTDIR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-alias.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  xorg-font-alias)
	@$(call install_fixup, xorg-font-alias,PRIORITY,optional)
	@$(call install_fixup, xorg-font-alias,SECTION,base)
	@$(call install_fixup, xorg-font-alias,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-font-alias,DESCRIPTION,missing)

	@$(call install_copy, xorg-font-alias, 0, 0, 0644, - ,\
		$(XORG_FONTDIR)/100dpi/fonts.alias, n)
	@$(call install_copy, xorg-font-alias, 0, 0, 0644, -, \
		$(XORG_FONTDIR)/75dpi/fonts.alias, n)
	@$(call install_copy, xorg-font-alias, 0, 0, 0644, -, \
		$(XORG_FONTDIR)/cyrillic/fonts.alias, n)
	@$(call install_copy, xorg-font-alias, 0, 0, 0644, -, \
		$(XORG_FONTDIR)/misc/fonts.alias, n)

	@$(call install_finish, xorg-font-alias)

	@$(call touch)

# vim: syntax=make
