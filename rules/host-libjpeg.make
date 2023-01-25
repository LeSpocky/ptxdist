# -*-makefile-*-
#
# Copyright (C) 2018 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_LIBJPEG) += host-libjpeg

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# cmake
#
HOST_LIBJPEG_CONF_TOOL	:= cmake
HOST_LIBJPEG_CONF_OPT := \
	$(HOST_CMAKE_OPT) \
	-DCMAKE_INSTALL_LIBDIR=/usr/lib \
	-DENABLE_SHARED=ON \
	-DENABLE_STATIC=OFF \
	-DFORCE_INLINE=ON \
	-DREQUIRE_SIMD=OFF \
	-DWITH_12BIT=OFF \
	-DWITH_ARITH_DEC=ON \
	-DWITH_ARITH_ENC=ON \
	-DWITH_FUZZ=OFF \
	-DWITH_JAVA=OFF \
	-DWITH_JPEG7=ON \
	-DWITH_JPEG8=ON \
	-DWITH_MEM_SRCDST=ON \
	-DWITH_SIMD=OFF \
	-DWITH_TURBOJPEG=ON \

# vim: syntax=make
