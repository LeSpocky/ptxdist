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
FREETYPE_VERSION	:= 2.14.1
FREETYPE_MD5		:= 78c7d7450fb7d0999ccd029f84094340
FREETYPE		:= freetype-$(FREETYPE_VERSION)
FREETYPE_SUFFIX		:= tar.xz
FREETYPE_SOURCE		:= $(SRCDIR)/$(FREETYPE).$(FREETYPE_SUFFIX)
FREETYPE_DIR		:= $(BUILDDIR)/$(FREETYPE)
FREETYPE_LICENSE	:= BSD-2-Clause AND FTL AND GPL-2.0-or-later AND MIT
FREETYPE_LICENSE_FILES	:= \
	file://LICENSE.TXT;md5=eeb073d5fb86d23c52bb9b84aa256307 \
	file://docs/GPLv2.TXT;md5=8ef380476f642c20ebf40fecb0add2ec \
	file://docs/FTL.TXT;md5=72d844cd2f3bcaf6a85244b508032be7 \
	file://src/bdf/README;startline=98;endline=140;md5=fef9416f085f0834b3ba93a5dc5a622c \
	file://src/pcf/README;startline=69;endline=88;md5=e0f11f550450e58753f2d54ddaf17d34 \
	file://src/autofit/ft-hb.c;startline=7;endline=14;md5=e8099c3115f942031df07e75609f89cf

FREETYPE_URL := \
	https://download.savannah.gnu.org/releases/freetype/$(FREETYPE).$(FREETYPE_SUFFIX) \
	https://download.savannah.gnu.org/releases/freetype/freetype-old/$(FREETYPE).$(FREETYPE_SUFFIX) \
	$(call ptx/mirror, SF, freetype/freetype2/$(FREETYPE_VERSION)/$(FREETYPE).$(FREETYPE_SUFFIX))

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# freetype's top level configure is handcrafted

FREETYPE_CONF_TOOL	:= autoconf
FREETYPE_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-static \
	--enable-freetype-config \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--enable-mmap \
	--with-zlib \
	--without-bzip2 \
	--$(call ptx/wwo,PTXCONF_FREETYPE_LIBPNG)-png \
	--without-harfbuzz \
	--without-brotli \
	--without-librsvg \
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
