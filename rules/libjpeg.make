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
LIBJPEG_VERSION	:= 3.1.3
LIBJPEG_MD5	:= 6a03c55732045630e051f20ba7ece465
LIBJPEG_SUFFIX	:= tar.gz
LIBJPEG		:= libjpeg-turbo-$(LIBJPEG_VERSION)
LIBJPEG_URL	:= https://github.com/libjpeg-turbo/libjpeg-turbo/archive/refs/tags/$(LIBJPEG_VERSION).$(LIBJPEG_SUFFIX)
LIBJPEG_SOURCE	:= $(SRCDIR)/$(LIBJPEG).$(LIBJPEG_SUFFIX)
LIBJPEG_DIR	:= $(BUILDDIR)/$(LIBJPEG)
LIBJPEG_LICENSE	:= IJG AND BSD-3-Clause
LIBJPEG_LICENSE_FILES := \
	file://LICENSE.md;md5=52fddabc7e8e79233150ebda95c3fc1f \
	file://README.ijg;startline=113;endline=164;md5=89d5b942e03050d117f34e50b49c2c61 \
	file://simd/nasm/jsimdext.inc;startline=13;endline=28;md5=100ad877b6a14ec137afd49a6e109624

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
ifdef PTXCONF_ARCH_PPC_ALTIVEC
LIBJPEG_SIMD := y
endif

LIBJPEG_CONF_TOOL := cmake
LIBJPEG_CONF_OPT := \
	$(CROSS_CMAKE_USR) \
	-DENABLE_SHARED=ON \
	-DENABLE_STATIC=OFF \
	-DFORCE_INLINE=ON \
	-DREQUIRE_SIMD=OFF \
	-DWITH_ARITH_DEC=ON \
	-DWITH_ARITH_ENC=ON \
	-DWITH_FUZZ=OFF \
	-DWITH_JAVA=OFF \
	-DWITH_JPEG7=ON \
	-DWITH_JPEG8=ON \
	-DWITH_SIMD=$(call ptx/onoff,LIBJPEG_SIMD) \
	-DWITH_TESTS=OFF \
	-DWITH_TOOLS=ON \
	-DWITH_TURBOJPEG=$(call ptx/onoff,PTXCONF_LIBJPEG_TURBO)

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
ifdef PTXCONF_LIBJPEG_TURBO
	@$(call install_lib, libjpeg, 0, 0, 0644, libturbojpeg)
endif
ifdef PTXCONF_LIBJPEG_BIN
	@$(call install_copy, libjpeg, 0, 0, 0755, -, /usr/bin/cjpeg)
	@$(call install_copy, libjpeg, 0, 0, 0755, -, /usr/bin/djpeg)
endif

	@$(call install_finish, libjpeg)

	@$(call touch)

# vim: syntax=make
