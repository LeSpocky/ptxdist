# -*-makefile-*-
#
# Copyright (C) 2016 by Guillermo Rodriguez <guille.rodriguez@gmail.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_IMAGEMAGICK) += imagemagick

#
# Paths and names
#
IMAGEMAGICK_VERSION	:= 7.1.1-12
IMAGEMAGICK_MD5		:= 7d04ecc28b035922697630c92cdfbfb8
IMAGEMAGICK		:= ImageMagick-$(IMAGEMAGICK_VERSION)
IMAGEMAGICK_SUFFIX	:= tar.xz
IMAGEMAGICK_URL		:= https://imagemagick.org/archive/releases/$(IMAGEMAGICK).$(IMAGEMAGICK_SUFFIX)
IMAGEMAGICK_SOURCE	:= $(SRCDIR)/$(IMAGEMAGICK).$(IMAGEMAGICK_SUFFIX)
IMAGEMAGICK_DIR		:= $(BUILDDIR)/$(IMAGEMAGICK)
IMAGEMAGICK_LICENSE	:= Apache-2.0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# Supported values for quantum depth are 8, 16, and 32.
# Most display adapters and image formats don't support more than 8 bits
# per pixel quantum (i.e. per each of the R, G, B, and alpha components),
# and higher values have an impact in runtime performance.
#
IMAGEMAGICK_QUANTUM_DEPTH := 8

#
# See: http://www.imagemagick.org/script/advanced-unix-installation.php
#
# Notes:
# - Threading is disabled as it brings in a dependency with libgomp.so
#   (OpenMP) which fails at runtime; disabling openmp itself doesn't seem
#   to be enough.
# - HDRI is disabled. It is not supported by most image formats, and has
#   a severe impact in runtime performance.
# - The configure script will try to detect external "helper" programs
#   available in the host and store their paths in delegates.xml. These
#   are not applicable on the target, but also not needed for any of the
#   supported configure options. Just ignore the generated delegates.xml
#   file.
#
IMAGEMAGICK_CONF_TOOL := autoconf
IMAGEMAGICK_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--disable-openmp \
	--disable-opencl \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--enable-shared \
	--disable-static \
	--enable-installed \
	--enable-cipher \
	--disable-zero-configuration \
	--disable-hdri \
	--disable-docs \
	--without-dmalloc \
	--without-threads \
	--without-modules \
	--with-utilities \
	--with-quantum-depth=$(IMAGEMAGICK_QUANTUM_DEPTH) \
	--without-magick-plus-plus \
	--without-perl \
	--without-jemalloc \
	--without-tcmalloc \
	--without-umem \
	--without-bzlib \
	--without-x \
	--without-zip \
	--$(call ptx/wwo, PTXCONF_IMAGEMAGICK_USE_ZLIB)-zlib \
	--without-zstd \
	--without-autotrace \
	--without-dps \
	--without-fftw \
	--without-flif \
	--without-fpx \
	--without-djvu \
	--without-fontconfig \
	--without-freetype \
	--without-raqm \
	--without-gdi32 \
	--without-gslib \
	--without-gvc \
	--without-dmr \
	--without-heic \
	--without-jbig \
	--$(call ptx/wwo, PTXCONF_IMAGEMAGICK_USE_LIBJPEG)-jpeg \
	--without-jxl \
	--without-lcms \
	--without-openjp2 \
	--without-lqr \
	--without-lzma \
	--without-openexr \
	--without-pango \
	--$(call ptx/wwo, PTXCONF_IMAGEMAGICK_USE_LIBPNG)-png \
	--without-raw \
	--without-rsvg \
	--without-tiff \
	--$(call ptx/wwo, PTXCONF_IMAGEMAGICK_USE_LIBWEBP)-webp \
	--without-wmf \
	--without-xml

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/imagemagick.targetinstall:
	@$(call targetinfo)

	@$(call install_init, imagemagick)
	@$(call install_fixup, imagemagick, PRIORITY, optional)
	@$(call install_fixup, imagemagick, SECTION, base)
	@$(call install_fixup, imagemagick, AUTHOR, "Guillermo Rodriguez <guille.rodriguez@gmail.com>")
	@$(call install_fixup, imagemagick, DESCRIPTION, missing)

	@$(call install_copy, imagemagick, 0, 0, 0755, -, /usr/bin/magick)
	@$(call install_lib, imagemagick, 0, 0, 0644, libMagickCore-7.Q$(IMAGEMAGICK_QUANTUM_DEPTH))
	@$(call install_lib, imagemagick, 0, 0, 0644, libMagickWand-7.Q$(IMAGEMAGICK_QUANTUM_DEPTH))

	@$(call install_link, imagemagick, magick, /usr/bin/compare)
	@$(call install_link, imagemagick, magick, /usr/bin/composite)
	@$(call install_link, imagemagick, magick, /usr/bin/conjure)
	@$(call install_link, imagemagick, magick, /usr/bin/convert)
	@$(call install_link, imagemagick, magick, /usr/bin/identify)
	@$(call install_link, imagemagick, magick, /usr/bin/magick-script)
	@$(call install_link, imagemagick, magick, /usr/bin/mogrify)
	@$(call install_link, imagemagick, magick, /usr/bin/montage)
	@$(call install_link, imagemagick, magick, /usr/bin/stream)

	@$(call install_alternative, imagemagick, 0, 0, 0644, /etc/ImageMagick-7/colors.xml)
	@$(call install_alternative, imagemagick, 0, 0, 0644, /etc/ImageMagick-7/delegates.xml)
	@$(call install_alternative, imagemagick, 0, 0, 0644, /etc/ImageMagick-7/log.xml)
	@$(call install_alternative, imagemagick, 0, 0, 0644, /etc/ImageMagick-7/mime.xml)
	@$(call install_alternative, imagemagick, 0, 0, 0644, /etc/ImageMagick-7/policy.xml)
	@$(call install_alternative, imagemagick, 0, 0, 0644, /etc/ImageMagick-7/quantization-table.xml)
	@$(call install_alternative, imagemagick, 0, 0, 0644, /etc/ImageMagick-7/thresholds.xml)
	@$(call install_alternative, imagemagick, 0, 0, 0644, /etc/ImageMagick-7/type-apple.xml)
	@$(call install_alternative, imagemagick, 0, 0, 0644, /etc/ImageMagick-7/type-dejavu.xml)
	@$(call install_alternative, imagemagick, 0, 0, 0644, /etc/ImageMagick-7/type-ghostscript.xml)
	@$(call install_alternative, imagemagick, 0, 0, 0644, /etc/ImageMagick-7/type-urw-base35.xml)
	@$(call install_alternative, imagemagick, 0, 0, 0644, /etc/ImageMagick-7/type-windows.xml)
	@$(call install_alternative, imagemagick, 0, 0, 0644, /etc/ImageMagick-7/type.xml)

	@$(call install_finish, imagemagick)

	@$(call touch)

# vim: syntax=make
