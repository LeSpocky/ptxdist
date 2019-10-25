# -*-makefile-*-
#
# Copyright (C) 2003-2006 by Robert Schwebel <r.schwebel@pengutronix.de>
#               2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_FREETYPE) += freetype

#
# Paths and names
#
FREETYPE_VERSION	:= 2.10.1
FREETYPE_MD5		:= bd42e75127f8431923679480efb5ba8f
FREETYPE		:= freetype-$(FREETYPE_VERSION)
FREETYPE_SUFFIX		:= tar.xz
FREETYPE_SOURCE		:= $(SRCDIR)/$(FREETYPE).$(FREETYPE_SUFFIX)
FREETYPE_DIR		:= $(BUILDDIR)/$(FREETYPE)
FREETYPE_LICENSE	:= BSD-2-Clause AND FTL AND GPL-2.0-or-later
FREETYPE_LICENSE_FILES	:= \
	file://docs/LICENSE.TXT;md5=4af6221506f202774ef74f64932878a1 \
	file://docs/GPLv2.TXT;md5=8ef380476f642c20ebf40fecb0add2ec \
	file://docs/FTL.TXT;md5=9f37b4e6afa3fef9dba8932b16bd3f97 \
	file://src/bdf/README;startline=98;endline=140;md5=d0c2c2e2e102c393a12869bc34515be2 \
	file://src/pcf/README;startline=69;endline=88;md5=e0f11f550450e58753f2d54ddaf17d34

FREETYPE_URL := \
	http://download.savannah.gnu.org/releases/freetype/$(FREETYPE).$(FREETYPE_SUFFIX) \
	http://download.savannah.gnu.org/releases/freetype/freetype-old/$(FREETYPE).$(FREETYPE_SUFFIX)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
FREETYPE_CONF_TOOL	:= autoconf
FREETYPE_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-static \
	--disable-biarch-config \
	--enable-freetype-config \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--enable-mmap \
	--with-zlib \
	--without-bzip2 \
	--without-png \
	--without-harfbuzz \
	--without-old-mac-fonts \
	--without-fsspec \
	--without-fsref \
	--without-quickdraw-toolbox \
	--without-quickdraw-carbon \
	--without-ats


# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/freetype.targetinstall:
	@$(call targetinfo)

	@$(call install_init, freetype)
	@$(call install_fixup, freetype,PRIORITY,optional)
	@$(call install_fixup, freetype,SECTION,base)
	@$(call install_fixup, freetype,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, freetype,DESCRIPTION,missing)

	@$(call install_lib, freetype, 0, 0, 0644, libfreetype)

	@$(call install_finish, freetype)

	@$(call touch)

# vim: syntax=make
