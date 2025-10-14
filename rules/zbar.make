# -*-makefile-*-
#
# Copyright (C) 2021 by Stefan Ursella <stefan.ursella@wolfvision.net>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ZBAR) += zbar

#
# Paths and names
#
ZBAR_VERSION	:= 0.23.93
ZBAR_MD5	:= e8cc283fcfc53177b95e8980e6a8f23c
ZBAR		:= zbar-$(ZBAR_VERSION)
ZBAR_SUFFIX	:= tar.bz2
ZBAR_URL	:= https://linuxtv.org/downloads/zbar/$(ZBAR).$(ZBAR_SUFFIX)
ZBAR_SOURCE	:= $(SRCDIR)/$(ZBAR).$(ZBAR_SUFFIX)
ZBAR_DIR	:= $(BUILDDIR)/$(ZBAR)
ZBAR_LICENSE	:= LGPL-2.0-or-later
ZBAR_LICENSE_FILES := \
	file://LICENSE.md;md5=5e9ee833a2118adc7d8b5ea38e5b1cef

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
ZBAR_CONF_TOOL	:= autoconf
ZBAR_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-static \
	--disable-rpath \
	--disable-nls \
	--enable-pthread \
	--disable-doc \
	--disable-video \
	--disable-introspection \
	--enable-assert \
	--without-directshow \
	--without-x \
	--without-xshm \
	--without-xv \
	--without-dbus \
	--without-jpeg \
	--without-imagemagick \
	--without-graphicsmagick \
	--without-npapi \
	--without-gtk \
	--without-gir \
	--without-python \
	--without-qt \
	--without-qt6 \
	--without-java

$(STATEDIR)/zbar.targetinstall:
	@$(call targetinfo)

	@$(call install_init, zbar)
	@$(call install_fixup, zbar,PRIORITY,optional)
	@$(call install_fixup, zbar,SECTION,base)
	@$(call install_fixup, zbar,AUTHOR,"Stefan Ursella <stefan.ursella@wolfvision.net>")
	@$(call install_fixup, zbar,DESCRIPTION,missing)

	@$(call install_lib, zbar, 0, 0, 0644, libzbar)

	@$(call install_finish, zbar)

	@$(call touch)

# vim: syntax=make
