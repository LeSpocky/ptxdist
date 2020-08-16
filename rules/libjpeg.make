# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
#               2007, 2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
# Copyright (C) 2017 by Philipp Zabel <p.zabel@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBJPEG) += libjpeg

#
# Paths and names
#
LIBJPEG_VERSION	:= 2.0.5
LIBJPEG_MD5	:= 3a7dc293918775fc933f81e2bce36464
LIBJPEG_SUFFIX	:= tar.gz
LIBJPEG		:= libjpeg-turbo-$(LIBJPEG_VERSION)
LIBJPEG_TARBALL	:= $(LIBJPEG).$(LIBJPEG_SUFFIX)
LIBJPEG_URL	:= $(call ptx/mirror, SF, libjpeg-turbo/$(LIBJPEG_VERSION)/$(LIBJPEG_TARBALL))
LIBJPEG_SOURCE	:= $(SRCDIR)/$(LIBJPEG_TARBALL)
LIBJPEG_DIR	:= $(BUILDDIR)/$(LIBJPEG)
LIBJPEG_LICENSE	:= IJG, BSD-3-Clause, Zlib
LIBJPEG_LICENSE_FILES := \
	file://LICENSE.md;md5=26d6491346496a57f75f00a78199122e \
	file://README.ijg;startline=112;endline=174;md5=3a823783b9d7587c8a5ef2447e833e19 \
	file://simd/nasm/jsimdext.inc;startline=12;endline=27;md5=839b9ed7df5168976efc071bee29a76e

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------


LIBJPEG_SIMD :=
ifdef PTXCONF_ARCH_X86
LIBJPEG_SIMD := y
endif
ifdef PTXCONF_ARCH_ARM_NEON
LIBJPEG_SIMD := y
endif

LIBJPEG_CONF_TOOL := cmake
LIBJPEG_CONF_OPT := \
	$(CROSS_CMAKE_USR) \
	-DENABLE_SHARED=ON \
	-DENABLE_STATIC=OFF \
	-DREQUIRE_SIMD=OFF \
	-DWITH_12BIT=OFF \
	-DWITH_ARITH_DEC=ON \
	-DWITH_ARITH_ENC=ON \
	-DWITH_JAVA=OFF \
	-DWITH_JPEG7=ON \
	-DWITH_JPEG8=ON \
	-DWITH_MEM_SRCDST=ON \
	-DWITH_SIMD=$(call ptx/onoff,LIBJPEG_SIMD) \
	-DWITHOUT_TURBOJPEG=ON \
	-DFORCE_INLINE=ON

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libjpeg.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libjpeg)
	@$(call install_fixup, libjpeg,PRIORITY,optional)
	@$(call install_fixup, libjpeg,SECTION,base)
	@$(call install_fixup, libjpeg,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libjpeg,DESCRIPTION,missing)

	@$(call install_lib, libjpeg, 0, 0, 0644, libjpeg)
ifdef PTXCONF_LIBJPEG_BIN
	@$(call install_copy, libjpeg, 0, 0, 0755, -, /usr/bin/cjpeg)
	@$(call install_copy, libjpeg, 0, 0, 0755, -, /usr/bin/djpeg)
endif

	@$(call install_finish, libjpeg)

	@$(call touch)

# vim: syntax=make
