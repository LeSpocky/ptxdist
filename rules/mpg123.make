# -*-makefile-*-
#
# Copyright (C) 2010 by Juergen Kilb
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MPG123) += mpg123

#
# Paths and names
#
MPG123_VERSION	:= 1.33.7
MPG123_SHA256	:= 31d0e35a4ca567ec9b5ebda6c3062bb4435d6d3eacd6ef0d95cadd7854dc03ee
MPG123		:= mpg123-$(MPG123_VERSION)
MPG123_SUFFIX	:= tar.bz2
MPG123_URL	:= http://www.mpg123.org/download/$(MPG123).$(MPG123_SUFFIX)
MPG123_SOURCE	:= $(SRCDIR)/$(MPG123).$(MPG123_SUFFIX)
MPG123_DIR	:= $(BUILDDIR)/$(MPG123)
MPG123_LICENSE	:= LGPL-2.1-only
MPG123_LICENSE_FILES := \
	file://COPYING;md5=e7b9c15fcfb986abb4cc5e8400a24169 \
	file://src/libmpg123/libmpg123.c;startline=1;endline=7;md5=fc8ca3e5afc09f7af03f66aefda74456

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

MPG123_CPU-y				:= generic_fpu
MPG123_CPU-$(PTXCONF_ARCH_ARM)		:= $(call ptx/ifdef,PTXCONF_HAS_HARDFLOAT,generic_fpu,arm_nofpu)
MPG123_CPU-$(PTXCONF_ARCH_ARM_NEON)	:= arm_fpu
MPG123_CPU-$(PTXCONF_ARCH_ARM64)	:= aarch64
MPG123_CPU-$(PTXCONF_ARCH_X86)		:= x86
MPG123_CPU-$(PTXCONF_ARCH_X86_I386)	:= i386_fpu
MPG123_CPU-$(PTXCONF_ARCH_X86_I486)	:= i486
MPG123_CPU-$(PTXCONF_ARCH_X86_64)	:= x86-64
MPG123_CPU-$(PTXCONF_ARCH_PPC_ALTIVEC)	:= altivec

#
# autoconf
#
MPG123_CONF_TOOL	:= autoconf
MPG123_CONF_OPT		:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-modules \
	--enable-components \
	--enable-programs \
	--enable-libmpg123 \
	--enable-libout123 \
	--enable-libout123-modules \
	--enable-libsyn123 \
	--disable-debug \
	--disable-xdebug \
	--disable-nagging \
	--enable-gapless \
	--enable-fifo \
	--enable-id3v2 \
	--enable-string \
	--enable-icy \
	--enable-ntom \
	--enable-downsample \
	--enable-feeder \
	--enable-moreinfo \
	--enable-messages \
	--disable-runtime-tables \
	--enable-new-huffman \
	--$(call ptx/endis, PTXCONF_MPG123_INT_QUALITY)-int-quality \
	--enable-16bit \
	--enable-8bit \
	--enable-32bit \
	--enable-real \
	--disable-equalizer \
	--disable-yasm \
	--enable-ieeefloat \
	--enable-cases \
	--enable-buffer \
	--disable-newoldwritesample \
	--enable-layer1 \
	--enable-layer2 \
	--enable-layer3 \
	--disable-portable \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--enable-feature_report \
	--$(call ptx/endis, PTXCONF_GLOBAL_IPV6)-ipv6 \
	--enable-network \
	--with-cpu=$(MPG123_CPU-y) \
	--with-audio=alsa \
	--with-default-audio=alsa \
	--with-optimization=2 \
	--with-seektable=1000 \
	--with-network=exec

# needed when compiling without IPv6
MPG123_CPPFLAGS := -D_GNU_SOURCE

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/mpg123.targetinstall:
	@$(call targetinfo)

	@$(call install_init, mpg123)
	@$(call install_fixup, mpg123,PRIORITY,optional)
	@$(call install_fixup, mpg123,SECTION,base)
	@$(call install_fixup, mpg123,AUTHOR,"Juergen Kilb <J.Kilb@phytec.de>")
	@$(call install_fixup, mpg123,DESCRIPTION,missing)

	@$(call install_copy, mpg123, 0, 0, 0755, -, /usr/bin/mpg123)
	@$(call install_lib, mpg123, 0, 0, 0644, libmpg123)
	@$(call install_lib, mpg123, 0, 0, 0644, libout123)
	@$(call install_lib, mpg123, 0, 0, 0644, libsyn123)

	@$(call install_finish, mpg123)

	@$(call touch)

# vim: syntax=make
