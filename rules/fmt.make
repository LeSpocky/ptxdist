# -*-makefile-*-
#
# Copyright (C) 2024 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_FMT) += fmt

#
# Paths and names
#
FMT_VERSION		:= 11.0.2
FMT_MD5			:= 3fe10c5184c8ecd0d2f9536c1b1ae95c
FMT			:= fmt-$(FMT_VERSION)
FMT_SUFFIX		:= tar.gz
FMT_URL			:= https://github.com/fmtlib/fmt/archive/refs/tags/$(FMT_VERSION).$(FMT_SUFFIX)
FMT_SOURCE		:= $(SRCDIR)/$(FMT).$(FMT_SUFFIX)
FMT_DIR			:= $(BUILDDIR)/$(FMT)
FMT_LICENSE		:= MIT WITH fmt-exception
FMT_LICENSE_FILES	:= file://LICENSE;md5=b9257785fc4f3803a4b71b76c1412729

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# cmake
#
FMT_CONF_TOOL	:= cmake
FMT_CONF_OPT	:=  \
	$(CROSS_CMAKE_USR) \
	-DCMAKE_CXX_VISIBILITY_PRESET=hidden \
	-DCMAKE_VISIBILITY_INLINES_HIDDEN=ON \
	-DFMT_CUDA_TEST=OFF \
	-DFMT_DOC=OFF \
	-DFMT_FUZZ=OFF \
	-DFMT_INSTALL=ON \
	-DFMT_MODULE=OFF \
	-DFMT_OS=ON \
	-DFMT_PEDANTIC=OFF \
	-DFMT_SYSTEM_HEADERS=OFF \
	-DFMT_TEST=OFF \
	-DFMT_UNICODE=ON \
	-DFMT_WERROR=OFF \
	\
	-DCMAKE_DISABLE_FIND_PACKAGE_DOXYGEN=ON

# template headers for the most part and a small static library

# vim: syntax=make
