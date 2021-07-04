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
HOST_CMAKE_VERSION	:= 3.20.5
HOST_CMAKE_MD5		:= 137311bbe83d9a32469f99ac2792a2bc
HOST_CMAKE		:= cmake-$(HOST_CMAKE_VERSION)
HOST_CMAKE_SUFFIX	:= tar.gz
HOST_CMAKE_URL		:= https://cmake.org/files/v$(basename $(HOST_CMAKE_VERSION))/$(HOST_CMAKE).$(HOST_CMAKE_SUFFIX)
HOST_CMAKE_SOURCE	:= $(SRCDIR)/$(HOST_CMAKE).$(HOST_CMAKE_SUFFIX)
HOST_CMAKE_DIR		:= $(HOST_BUILDDIR)/$(HOST_CMAKE)
HOST_CMAKE_LICENSE	:= 0BSD AND BSD-2-clause AND BSD-3-Clause AND Apache-2.0 AND bzip2-1.0.6 AND (MIT OR public_domain) AND MIT AND curl
HOST_CMAKE_LICENSE_FILES := \
	file://Copyright.txt;md5=31023e1d3f51ca90a58f55bcee8e2339 \
	file://Source/kwsys/Copyright.txt;md5=64ed5ec90b0f9868cf0b08ea5b954dfe \
	file://Utilities/KWIML/Copyright.txt;md5=bdc657917a0eec5751b3d5eafd4b413c \
	file://Utilities/cmbzip2/LICENSE;md5=1e5cffe65fc786f83a11a4b225495c0b \
	file://Utilities/cmcurl/COPYING;md5=425f6fdc767cc067518eef9bbdf4ab7b \
	file://Utilities/cmexpat/COPYING;md5=9e2ce3b3c4c0f2670883a23bbd7c37a9 \
	file://Utilities/cmjsoncpp/LICENSE;md5=fa2a23dd1dc6c139f35105379d76df2b \
	file://Utilities/cmlibarchive/COPYING;md5=fe01f5e02b1f0cc934d593a7b0ddceb6 \
	file://Utilities/cmlibrhash/COPYING;md5=a8c2a557a5c53b1c12cddbee98c099af \
	file://Utilities/cmlibuv/LICENSE;md5=a68902a430e32200263d182d44924d47 \
	file://Utilities/cmnghttp2/COPYING;md5=764abdf30b2eadd37ce47dcbce0ea1ec \
	file://Utilities/cmzlib/Copyright.txt;md5=20549c31f1fec4df39b48732d8802c2a \
	file://Utilities/cmzstd/LICENSE;md5=c7f0b161edbe52f5f345a3d1311d0b32


# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_CMAKE_CONF_ENV	:= \
	$(HOST_ENV) \
	MAKEFLAGS="$(PARALLELMFLAGS)"

HOST_CMAKE_BUILD_OOT	:= YES
HOST_CMAKE_CONF_TOOL	:= autoconf
HOST_CMAKE_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	-- \
	-DBUILD_TESTING=NO \
	-DCMAKE_USE_OPENSSL=NO


$(STATEDIR)/host-cmake.install.post: \
	$(PTXDIST_CMAKE_TOOLCHAIN_TARGET) \
	$(PTXDIST_CMAKE_TOOLCHAIN_HOST)

# vim: syntax=make
