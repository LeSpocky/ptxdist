# -*-makefile-*-
#
# Copyright (C) 2015 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_FFMPEG) += ffmpeg

#
# Paths and names
#
FFMPEG_VERSION	:= 7.1
FFMPEG_MD5	:= 623aa63a72139a82ccb99cd6ee477b94
FFMPEG		:= ffmpeg-$(FFMPEG_VERSION)
FFMPEG_SUFFIX	:= tar.xz
FFMPEG_URL	:= https://www.ffmpeg.org/releases/$(FFMPEG).$(FFMPEG_SUFFIX)
FFMPEG_SOURCE	:= $(SRCDIR)/$(FFMPEG).$(FFMPEG_SUFFIX)
FFMPEG_DIR	:= $(BUILDDIR)/$(FFMPEG)
# Note: any GPL only code is disabled below with --disable-gpl
FFMPEG_LICENSE	:= LGPL-2.1-or-later AND BSD-3-Clause
FFMPEG_LICENSE_FILES := \
	file://LICENSE.md;md5=d62f7dc46e5dd02bf89ab1aac8c51bba \
	file://COPYING.LGPLv2.1;md5=bd7a443320af8c812e4c18d1b79df004 \
	file://libavcodec/arm/vp8dsp_armv6.S;startline=4;endline=52;md5=24eb31d8cad17de39e517e8d946cdee0 \
	file://libavcodec/mips/ac3dsp_mips.c;startline=2;endline=27;md5=5f25aa1db1ecf13c29efc63800bf6ae8 \

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ifdef PTXCONF_FFMPEG
FFMPEG_CPU := $(strip $(shell ptxd_cross_cc_v | sed -n "s/COLLECT_GCC_OPTIONS=.*'-march=\([^']*\)'.*/\1/p" | tail -n1))
ifeq ($(FFMPEG_CPU),)
FFMPEG_CPU := $(strip $(shell ptxd_cross_cc_v | sed -n "s/COLLECT_GCC_OPTIONS=.*'-mcpu=\([^']*\)'.*/\1/p" | tail -n1))
endif
ifeq ($(FFMPEG_CPU),)
FFMPEG_CPU := generic
endif
endif

#
# autoconf
#
FFMPEG_CONF_TOOL	:= autoconf
FFMPEG_CONF_OPT		:= \
	--prefix=/usr \
	--disable-rpath \
	--disable-gpl \
	--disable-version3 \
	--disable-nonfree \
	--disable-static \
	--enable-shared \
	--disable-small \
	--enable-runtime-cpudetect \
	--disable-gray \
	--enable-swscale-alpha \
	\
	--disable-autodetect \
	--disable-programs \
	--disable-ffmpeg \
	--disable-ffplay \
	--disable-ffprobe \
	--disable-doc \
	--disable-htmlpages \
	--disable-manpages \
	--disable-podpages \
	--disable-txtpages \
	\
	--disable-avdevice \
	--enable-avcodec \
	--enable-avformat \
	--enable-swresample \
	--disable-swscale \
	--disable-postproc \
	--enable-avfilter \
	\
	--enable-pthreads \
	--disable-network \
	--enable-dwt \
	--enable-error-resilience \
	--enable-lsp \
	--enable-faan \
	--enable-iamf \
	--enable-pixelutils \
	\
	--enable-encoders \
	--enable-decoders \
	--disable-hwaccels \
	--enable-muxers \
	--enable-demuxers \
	--enable-parsers \
	--enable-bsfs \
	--disable-protocols \
	--disable-indevs \
	--disable-outdevs \
	--disable-devices \
	--disable-filters \
	\
	--disable-alsa \
	--disable-appkit \
	--disable-avfoundation \
	--disable-avisynth \
	--disable-bzlib \
	--disable-coreimage \
	--disable-chromaprint \
	--disable-frei0r \
	--disable-gcrypt \
	--disable-gmp \
	--disable-gnutls \
	--disable-iconv \
	--disable-jni \
	--disable-ladspa \
	--disable-lcms2 \
	--disable-libaom \
	--disable-libaribb24 \
	--disable-libaribcaption \
	--disable-libass \
	--disable-libbluray \
	--disable-libbs2b \
	--disable-libcaca \
	--disable-libcelt \
	--disable-libcdio \
	--disable-libcodec2 \
	--disable-libdav1d \
	--disable-libdavs2 \
	--disable-libdc1394 \
	--disable-libdvdnav \
	--disable-libdvdread \
	--disable-libfdk-aac \
	--disable-libflite \
	--disable-libfontconfig \
	--disable-libfreetype \
	--disable-libfribidi \
	--disable-libharfbuzz \
	--disable-libglslang \
	--disable-libgme \
	--disable-libgsm \
	--disable-libiec61883 \
	--disable-libilbc \
	--disable-libjack \
	--disable-libjxl \
	--disable-libklvanc \
	--disable-libkvazaar \
	--disable-liblc3 \
	--disable-liblcevc-dec \
	--disable-liblensfun \
	--disable-libmodplug \
	--disable-libmp3lame \
	--disable-libopencore-amrnb \
	--disable-libopencore-amrwb \
	--disable-libopencv \
	--disable-libopenh264 \
	--disable-libopenjpeg \
	--disable-libopenmpt \
	--disable-libopenvino \
	--disable-libopus \
	--disable-libplacebo \
	--disable-libpulse \
	--disable-libqrencode \
	--disable-libquirc \
	--disable-librabbitmq \
	--disable-librav1e \
	--disable-librist \
	--disable-librsvg \
	--disable-librubberband \
	--disable-librtmp \
	--disable-libshaderc \
	--disable-libshine \
	--disable-libsmbclient \
	--disable-libsnappy \
	--disable-libsoxr \
	--disable-libspeex \
	--disable-libsrt \
	--disable-libssh \
	--disable-libsvtav1 \
	--disable-libtensorflow \
	--disable-libtesseract \
	--disable-libtheora \
	--disable-libtls \
	--disable-libtorch \
	--disable-libtwolame \
	--disable-libuavs3d \
	--disable-libv4l2 \
	--disable-libvidstab \
	--disable-libvmaf \
	--disable-libvo-amrwbenc \
	--disable-libvorbis \
	--disable-libvpx \
	--disable-libvvenc \
	--disable-libwebp \
	--disable-libx264 \
	--disable-libx265 \
	--disable-libxeve \
	--disable-libxevd \
	--disable-libxavs \
	--disable-libxavs2 \
	--disable-libxcb \
	--disable-libxcb-shm \
	--disable-libxcb-xfixes \
	--disable-libxcb-shape \
	--disable-libxvid \
	--disable-libxml2 \
	--disable-libzimg \
	--disable-libzmq \
	--disable-libzvbi \
	--disable-lv2 \
	--disable-lzma \
	--disable-decklink \
	--disable-mbedtls \
	--disable-mediacodec \
	--disable-mediafoundation \
	--disable-metal \
	--disable-libmysofa \
	--disable-openal \
	--disable-opencl \
	--disable-opengl \
	--disable-openssl \
	--disable-pocketsphinx \
	--disable-sndio \
	--disable-schannel \
	--disable-sdl2 \
	--disable-securetransport \
	--disable-vapoursynth \
	--disable-xlib \
	--disable-zlib \
	--disable-amf \
	--disable-audiotoolbox \
	--disable-cuda-nvcc \
	--disable-cuda-llvm \
	--disable-cuvid \
	--disable-d3d11va \
	--disable-d3d12va \
	--disable-dxva2 \
	--disable-ffnvcodec \
	--disable-libdrm \
	--disable-libmfx \
	--disable-libvpl \
	--disable-libnpp \
	--disable-mmal \
	--disable-nvdec \
	--disable-nvenc \
	--disable-omx \
	--disable-omx-rpi \
	--disable-rkmpp \
	--disable-v4l2_m2m \
	--disable-vaapi \
	--disable-vdpau \
	--disable-videotoolbox \
	--disable-vulkan \
	\
	--arch=$(PTXCONF_ARCH_STRING) \
	--cpu=$(FFMPEG_CPU) \
	--cross-prefix=$(PTXCONF_COMPILER_PREFIX) \
	--enable-cross-compile \
	--target-os=linux \
	--target-exec=false \
	--doxygen=false \
	--enable-pic \
	\
	--enable-optimizations \
	--disable-stripping

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ffmpeg.targetinstall:
	@$(call targetinfo)

	@$(call install_init, ffmpeg)
	@$(call install_fixup, ffmpeg,PRIORITY,optional)
	@$(call install_fixup, ffmpeg,SECTION,base)
	@$(call install_fixup, ffmpeg,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, ffmpeg,DESCRIPTION,missing)

	@$(call install_lib, ffmpeg, 0, 0, 0644, libavcodec)
	@$(call install_lib, ffmpeg, 0, 0, 0644, libavfilter)
	@$(call install_lib, ffmpeg, 0, 0, 0644, libavformat)
	@$(call install_lib, ffmpeg, 0, 0, 0644, libavutil)
	@$(call install_lib, ffmpeg, 0, 0, 0644, libswresample)

	@$(call install_finish, ffmpeg)

	@$(call touch)

# vim: syntax=make
