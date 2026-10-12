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
ZBAR_VERSION	:= 0.23.95
ZBAR_SHA256	:= 7b0907a3114503e0a8fbd1c6bfdb61592e6ded79f68716d7ca673ddeb6a87e99
ZBAR		:= zbar-$(ZBAR_VERSION)
ZBAR_SUFFIX	:= tar.gz
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
# meson
#
ZBAR_CONF_TOOL	:= meson
ZBAR_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Dbuild_tests=false \
	-Dcodes=ean,databar,code128,code93,code39,codabar,i25,qrcode,sqcode \
	-Ddbus=disabled \
	-Ddirectshow=false \
	-Ddoc=false \
	-Dgir=false \
	-Dgraphicsmagick=disabled \
	-Dgtk=no \
	-Dimagemagick=disabled \
	-Djava=disabled \
	-Djpeg=disabled \
	-Dlibrary_type=shared \
	-Dnls=disabled \
	-Dnpapi=disabled \
	-Dpthread=true \
	-Dpython=no \
	-Dqt=false \
	-Dqt6=false \
	-Dstatic_executables=false \
	-Dvideo=false \
	-Dx11=disabled \
	-Dxshm=disabled \
	-Dxv=disabled

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
