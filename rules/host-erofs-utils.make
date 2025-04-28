# -*-makefile-*-
#
# Copyright (C) 2025 by Leonard Göhrs <l.goehrs@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_EROFS_UTILS) += host-erofs-utils

#
# Paths and names
#
HOST_EROFS_UTILS_VERSION	:= 1.8.5
HOST_EROFS_UTILS_MD5		:= a4a4d803bc5120ffacc05a453a505ff7
HOST_EROFS_UTILS		:= erofs-utils-$(HOST_EROFS_UTILS_VERSION)
HOST_EROFS_UTILS_SUFFIX		:= tar.gz
HOST_EROFS_UTILS_URL		:= https://web.git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/snapshot/$(HOST_EROFS_UTILS).$(HOST_EROFS_UTILS_SUFFIX)
HOST_EROFS_UTILS_SOURCE		:= $(SRCDIR)/$(HOST_EROFS_UTILS).$(HOST_EROFS_UTILS_SUFFIX)
HOST_EROFS_UTILS_DIR		:= $(HOST_BUILDDIR)/$(HOST_EROFS_UTILS)
HOST_EROFS_UTILS_LICENSE	:= GPL-2.0-or-later
HOST_EROFS_UTILS_LICENSE_FILES	:= \
	file://COPYING;md5=73001d804ea1e3d84365f652242cca20 \
	file://LICENSES/GPL-2.0;md5=94fa01670a2a8f2d3ab2de15004e0848

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_EROFS_UTILS_CONF_TOOL	:= autoconf
HOST_EROFS_UTILS_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--disable-multithreading \
	--disable-debug \
	--disable-werror \
	--disable-fuzzing \
	--$(call ptx/endis, PTXCONF_HOST_EROFS_UTILS_LZ4_SUPPORT)-lz4 \
	--disable-lzma \
	--disable-fuse \
	--disable-static-fuse \
	--without-zlib \
	--without-libdeflate \
	--$(call ptx/wwo, PTXCONF_HOST_EROFS_UTILS_ZSTD_SUPPORT)-libzstd \
	--without-qpl \
	--without-xxhash \
	--with-uuid \
	--without-selinux

# vim: syntax=make
