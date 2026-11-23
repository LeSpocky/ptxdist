# -*-makefile-*-
#
# Copyright (C) 2013 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBAO) += libao

#
# Paths and names
#
LIBAO_VERSION	:= 1.2.2
LIBAO_SHA256	:= df8a6d0e238feeccb26a783e778716fb41a801536fe7b6fce068e313c0e2bf4d
LIBAO		:= libao-$(LIBAO_VERSION)
LIBAO_SUFFIX	:= tar.gz
LIBAO_URL	:= https://gitlab.xiph.org/xiph/libao/-/archive/$(LIBAO_VERSION)/$(LIBAO).$(LIBAO_SUFFIX)
LIBAO_SOURCE	:= $(SRCDIR)/$(LIBAO).$(LIBAO_SUFFIX)
LIBAO_DIR	:= $(BUILDDIR)/$(LIBAO)
LIBAO_LICENSE	:= GPL-2.0-or-later
LIBAO_LICENSE_FILES := \
	file://COPYING;md5=94d55d512a9ba36caa9b7df079bae19f \
	file://src/audio_out.c;startline=12;endline=24;md5=50e9878d21e803d4997b818a86ab6945

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBAO_CONF_TOOL := autoconf
LIBAO_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--disable-roar-default-slp \
	--disable-wmm \
	--disable-esd \
	--disable-esdtest \
	--enable-alsa \
	--enable-alsa-mmap \
	--disable-broken-oss \
	--disable-arts \
	--disable-nas \
	--disable-pulse \
	--without-x

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libao.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libao)
	@$(call install_fixup, libao,PRIORITY,optional)
	@$(call install_fixup, libao,SECTION,base)
	@$(call install_fixup, libao,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, libao,DESCRIPTION,missing)

	@$(call install_lib, libao, 0, 0, 0644, libao)
	@$(call install_lib, libao, 0, 0, 0644, ao/plugins-4/libalsa)

	@$(call install_finish, libao)

	@$(call touch)

# vim: syntax=make
