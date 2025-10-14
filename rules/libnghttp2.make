# -*-makefile-*-
#
# Copyright (C) 2022 by Bastian Krause <bst@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBNGHTTP2) += libnghttp2

#
# Paths and names
#
LIBNGHTTP2_VERSION	:= 1.67.1
LIBNGHTTP2_MD5		:= 87083f18d6b44c38a4b21a887faa3e86
LIBNGHTTP2		:= nghttp2-$(LIBNGHTTP2_VERSION)
LIBNGHTTP2_SUFFIX	:= tar.xz
LIBNGHTTP2_URL		:= https://github.com/nghttp2/nghttp2/releases/download/v$(LIBNGHTTP2_VERSION)/$(LIBNGHTTP2).$(LIBNGHTTP2_SUFFIX)
LIBNGHTTP2_SOURCE	:= $(SRCDIR)/$(LIBNGHTTP2).$(LIBNGHTTP2_SUFFIX)
LIBNGHTTP2_DIR		:= $(BUILDDIR)/$(LIBNGHTTP2)
LIBNGHTTP2_LICENSE	:= MIT
LIBNGHTTP2_LICENSE_FILES	:= file://COPYING;md5=764abdf30b2eadd37ce47dcbce0ea1ec

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# cmake
#
LIBNGHTTP2_CONF_TOOL	:= cmake
LIBNGHTTP2_CONF_OPT	:=  \
	$(CROSS_CMAKE_USR) \
	-DBUILD_SHARED_LIBS=ON \
	-DBUILD_STATIC_LIBS=OFF \
	-DENABLE_APP=OFF \
	-DENABLE_DEBUG=OFF \
	-DENABLE_DOC=OFF \
	-DENABLE_EXAMPLES=OFF \
	-DENABLE_FAILMALLOC=OFF \
	-DENABLE_HPACK_TOOLS=OFF \
	-DENABLE_HTTP3=OFF \
	-DENABLE_LIB_ONLY=ON \
	-DENABLE_STATIC_CRT=OFF \
	-DENABLE_THREADS=ON \
	-DENABLE_WERROR=OFF \
	-DWITH_JEMALLOC=OFF \
	-DWITH_LIBBPF=OFF \
	-DWITH_LIBXML2=OFF \
	-DWITH_MRUBY=OFF \
	-DWITH_NEVERBLEED=OFF \
	-DWITH_WOLFSSL=OFF

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libnghttp2.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libnghttp2)
	@$(call install_fixup, libnghttp2,PRIORITY,optional)
	@$(call install_fixup, libnghttp2,SECTION,base)
	@$(call install_fixup, libnghttp2,AUTHOR,"Bastian Krause <bst@pengutronix.de>")
	@$(call install_fixup, libnghttp2,DESCRIPTION,missing)

	@$(call install_lib, libnghttp2, 0, 0, 0644, libnghttp2)

	@$(call install_finish, libnghttp2)

	@$(call touch)

# vim: syntax=make
