# -*-makefile-*-
#
# Copyright (C) 2011 by George McCollister <george.mccollister@gmail.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_OPKG) += host-opkg

#
# Paths and names
#

HOST_OPKG	= $(OPKG)
HOST_OPKG_DIR	= $(HOST_BUILDDIR)/$(HOST_OPKG)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_OPKG_CONF_TOOL	:= autoconf
HOST_OPKG_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--disable-libopkg-api \
	--disable-static \
	--disable-xz \
	--disable-bzip2 \
	--disable-lz4 \
	--disable-zstd \
	--disable-curl \
	--disable-sha256 \
	--disable-ssl-curl \
	--disable-gpg \
	--without-static-libopkg \
	--without-libsolv

# vim: syntax=make
