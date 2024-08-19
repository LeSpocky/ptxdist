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
FREETYPE_VERSION	:= 2.13.3
FREETYPE_MD5		:= f3b4432c4212064c00500e1ad63fbc64
FREETYPE		:= freetype-$(FREETYPE_VERSION)
FREETYPE_SUFFIX		:= tar.xz
FREETYPE_SOURCE		:= $(SRCDIR)/$(FREETYPE).$(FREETYPE_SUFFIX)
FREETYPE_DIR		:= $(BUILDDIR)/$(FREETYPE)
FREETYPE_LICENSE	:= BSD-2-Clause AND FTL AND GPL-2.0-or-later AND MIT
FREETYPE_LICENSE_FILES	:= \
	file://LICENSE.TXT;md5=843b6efc16f6b1652ec97f89d5a516c0 \
	file://docs/GPLv2.TXT;md5=8ef380476f642c20ebf40fecb0add2ec \
	file://docs/FTL.TXT;md5=9f37b4e6afa3fef9dba8932b16bd3f97 \
	file://src/bdf/README;startline=98;endline=140;md5=fef9416f085f0834b3ba93a5dc5a622c \
	file://src/pcf/README;startline=69;endline=88;md5=e0f11f550450e58753f2d54ddaf17d34 \
	file://src/autofit/ft-hb.c;md5=6ed8fca99f01f7f6bd863b4449fec9f6

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
