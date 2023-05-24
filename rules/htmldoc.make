# -*-makefile-*-
#
# Copyright (C) 2023 by Roland Hieber <rhi@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_HTMLDOC) += htmldoc

#
# Paths and names
#
HTMLDOC_VERSION		:= 1.9.16
HTMLDOC_MD5		:= 9d82dd05321ca44594d9d1841868b2d5
HTMLDOC			:= htmldoc-$(HTMLDOC_VERSION)
HTMLDOC_SUFFIX		:= tar.gz
HTMLDOC_URL		:= https://github.com/michaelrsweet/htmldoc/releases/download/v$(HTMLDOC_VERSION)/$(HTMLDOC)-source.$(HTMLDOC_SUFFIX)
HTMLDOC_SOURCE		:= $(SRCDIR)/$(HTMLDOC).$(HTMLDOC_SUFFIX)
HTMLDOC_DIR		:= $(BUILDDIR)/$(HTMLDOC)
HTMLDOC_LICENSE		:= GPL-2.0-only
HTMLDOC_LICENSE_FILES	:= \
	file://README.md;startline=123;endline=124;md5=a2aaa1a54649f92a3f27ab9953505863 \
	file://COPYING;md5=b234ee4d69f5fce4486a80fdaf4a4263

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HTMLDOC_CONF_TOOL	:= autoconf
HTMLDOC_CONF_OPT	:=  \
	$(CROSS_AUTOCONF_USR) \
	--disable-debug \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-ssl \
	--disable-gnutls \
	--disable-cdsassl \
	--disable-maintainer \
	--disable-sanitizer \
	--without-gui

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/htmldoc.targetinstall:
	@$(call targetinfo)

	@$(call install_init, htmldoc)
	@$(call install_fixup, htmldoc,PRIORITY,optional)
	@$(call install_fixup, htmldoc,SECTION,base)
	@$(call install_fixup, htmldoc,AUTHOR,"Roland Hieber <rhi@pengutronix.de>")
	@$(call install_fixup, htmldoc,DESCRIPTION,missing)

	@$(call install_copy, htmldoc, 0, 0, 0755, -, /usr/bin/htmldoc)
	@$(call install_tree, htmldoc, 0, 0, -, /usr/share/htmldoc/fonts)
	@$(call install_tree, htmldoc, 0, 0, -, /usr/share/htmldoc/data)

	@$(call install_finish, htmldoc)

	@$(call touch)

# vim: syntax=make
