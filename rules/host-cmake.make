# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
#               2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_CMAKE) += host-cmake

#
# Paths and names
#
HOST_CMAKE_VERSION	:= 3.31.3
HOST_CMAKE_MD5		:= 7e70631e38a615be8f988663e8a07fb8
HOST_CMAKE		:= cmake-$(HOST_CMAKE_VERSION)
HOST_CMAKE_SUFFIX	:= tar.gz
HOST_CMAKE_URL		:= https://cmake.org/files/v$(basename $(HOST_CMAKE_VERSION))/$(HOST_CMAKE).$(HOST_CMAKE_SUFFIX)
HOST_CMAKE_SOURCE	:= $(SRCDIR)/$(HOST_CMAKE).$(HOST_CMAKE_SUFFIX)
HOST_CMAKE_DIR		:= $(HOST_BUILDDIR)/$(HOST_CMAKE)
HOST_CMAKE_LICENSE	:= 0BSD AND BSD-2-clause AND BSD-3-Clause AND Apache-2.0 AND bzip2-1.0.6 AND (MIT OR public_domain) AND MIT AND curl
HOST_CMAKE_LICENSE_FILES := \
	file://Copyright.txt;md5=718f05155941b33862726348d3cd46ce \
	file://Source/kwsys/Copyright.txt;md5=64ed5ec90b0f9868cf0b08ea5b954dfe \
	file://Utilities/KWIML/Copyright.txt;md5=bdc657917a0eec5751b3d5eafd4b413c \
	file://Utilities/cmbzip2/LICENSE;md5=1e5cffe65fc786f83a11a4b225495c0b \
	file://Utilities/cmcurl/COPYING;md5=eed2e5088e1ac619c9a1c747da291d75 \
	file://Utilities/cmexpat/COPYING;md5=7b3b078238d0901d3b339289117cb7fb \
	file://Utilities/cmjsoncpp/LICENSE;md5=5d73c165a0f9e86a1342f32d19ec5926 \
	file://Utilities/cmlibarchive/COPYING;md5=d499814247adaee08d88080841cb5665 \
	file://Utilities/cmlibrhash/COPYING;md5=a8c2a557a5c53b1c12cddbee98c099af \
	file://Utilities/cmlibuv/LICENSE;md5=ad93ca1fffe931537fcf64f6fcce084d \
	file://Utilities/cmnghttp2/COPYING;md5=764abdf30b2eadd37ce47dcbce0ea1ec \
	file://Utilities/cmzlib/Copyright.txt;md5=2450bdbf9b528e25d3c4dab22d3595fe \
	file://Utilities/cmzstd/LICENSE;md5=0822a32f7acdbe013606746641746ee8

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_CMAKE_CONF_ENV	:= \
	$(HOST_ENV) \
	MAKEFLAGS="$(PARALLELMFLAGS)"

HOST_CMAKE_BUILD_OOT	:= YES
HOST_CMAKE_CONF_TOOL	:= autoconf
HOST_CMAKE_CONF_OPT	:= \
	--prefix=/usr \
	-- \
	-DBUILD_TESTING=NO \
	-DCMAKE_USE_OPENSSL=NO


$(STATEDIR)/host-cmake.install.post: \
	$(PTXDIST_CMAKE_TOOLCHAIN_TARGET) \
	$(PTXDIST_CMAKE_TOOLCHAIN_HOST) \
	$(PTXDIST_CMAKE_TOOLCHAIN_CROSS)

# vim: syntax=make
