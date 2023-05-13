# -*-makefile-*-
#
# Copyright (C) 2021 by Matthias Fend <matthias.fend@emfend.at>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBTIFF) += libtiff

#
# Paths and names
#
LIBTIFF_VERSION		:= 4.3.0
LIBTIFF_MD5		:= 0a2e4744d1426a8fc8211c0cdbc3a1b3
LIBTIFF			:= tiff-$(LIBTIFF_VERSION)
LIBTIFF_SUFFIX		:= tar.gz
LIBTIFF_URL		:= http://download.osgeo.org/libtiff/$(LIBTIFF).$(LIBTIFF_SUFFIX)
LIBTIFF_SOURCE		:= $(SRCDIR)/$(LIBTIFF).$(LIBTIFF_SUFFIX)
LIBTIFF_DIR		:= $(BUILDDIR)/$(LIBTIFF)
LIBTIFF_LICENSE		:= libtiff
LIBTIFF_LICENSE_FILES	:= file://COPYRIGHT;md5=34da3db46fab7501992f9615d7e158cf

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBTIFF_CONF_TOOL	:= autoconf

LIBTIFF_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--enable-option-checking \
	--disable-silent-rules \
	--disable-maintainer-mode \
	--enable-dependency-tracking \
	--disable-ld-version-script \
	--enable-libtool-lock \
	--disable-rpath \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--enable-ccitt \
	--enable-packbits \
	--enable-lzw \
	--enable-thunder \
	--enable-next \
	--enable-logluv \
	--enable-mdi \
	--$(call ptx/endis, PTXCONF_LIBTIFF_ZLIB)-zlib \
	--disable-libdeflate \
	--$(call ptx/endis, PTXCONF_LIBTIFF_ZLIB)-pixarlog \
	--$(call ptx/endis, PTXCONF_LIBTIFF_JPEG)-jpeg \
	--$(call ptx/endis, PTXCONF_LIBTIFF_JPEG)-old-jpeg \
	--disable-jbig \
	--disable-lerc \
	--disable-lzma \
	--disable-zstd \
	--$(call ptx/endis, PTXCONF_LIBTIFF_WEBP)-webp \
	--disable-jpeg12 \
	--disable-cxx \
	--disable-win32-io \
	--enable-strip-chopping \
	--disable-defer-strile-load \
	--disable-chunky-strip-read \
	--enable-extrasample-as-alpha \
	--enable-check-ycbcr-subsampling

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libtiff.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libtiff)
	@$(call install_fixup, libtiff, PRIORITY, optional)
	@$(call install_fixup, libtiff, SECTION, base)
	@$(call install_fixup, libtiff, AUTHOR, "Matthias Fend <matthias.fend@emfend.at>")
	@$(call install_fixup, libtiff, DESCRIPTION, missing)

	@$(call install_lib, libtiff, 0, 0, 0644, libtiff)

ifdef PTXCONF_LIBTIFF_TOOLS
	@$(call install_copy, libtiff, 0, 0, 0755, -, /usr/bin/fax2ps)
	@$(call install_copy, libtiff, 0, 0, 0755, -, /usr/bin/fax2tiff)
	@$(call install_copy, libtiff, 0, 0, 0755, -, /usr/bin/pal2rgb)
	@$(call install_copy, libtiff, 0, 0, 0755, -, /usr/bin/ppm2tiff)
	@$(call install_copy, libtiff, 0, 0, 0755, -, /usr/bin/raw2tiff)
	@$(call install_copy, libtiff, 0, 0, 0755, -, /usr/bin/tiff2bw)
	@$(call install_copy, libtiff, 0, 0, 0755, -, /usr/bin/tiff2pdf)
	@$(call install_copy, libtiff, 0, 0, 0755, -, /usr/bin/tiff2ps)
	@$(call install_copy, libtiff, 0, 0, 0755, -, /usr/bin/tiff2rgba)
	@$(call install_copy, libtiff, 0, 0, 0755, -, /usr/bin/tiffcmp)
	@$(call install_copy, libtiff, 0, 0, 0755, -, /usr/bin/tiffcp)
	@$(call install_copy, libtiff, 0, 0, 0755, -, /usr/bin/tiffcrop)
	@$(call install_copy, libtiff, 0, 0, 0755, -, /usr/bin/tiffdither)
	@$(call install_copy, libtiff, 0, 0, 0755, -, /usr/bin/tiffdump)
	@$(call install_copy, libtiff, 0, 0, 0755, -, /usr/bin/tiffinfo)
	@$(call install_copy, libtiff, 0, 0, 0755, -, /usr/bin/tiffmedian)
	@$(call install_copy, libtiff, 0, 0, 0755, -, /usr/bin/tiffset)
	@$(call install_copy, libtiff, 0, 0, 0755, -, /usr/bin/tiffsplit)
endif

	@$(call install_finish, libtiff)

	@$(call touch)

# vim: syntax=make
