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

HOST_OPKG_CONF_TOOL	:= cmake
HOST_OPKG_CONF_OPT	:= \
	$(HOST_CMAKE_OPT) \
	-DSTATIC_LIBOPKG=OFF \
	-DUSE_ACL=OFF \
	-DUSE_SOLVER_INTERNAL=OFF \
	-DUSE_SOLVER_LIBSOLV=ON \
	-DUSE_XATTR=OFF \
	-DWITH_BZIP2=OFF \
	-DWITH_CURL=OFF \
	-DWITH_GPGME=OFF \
	-DWITH_LIBOPKG_API=OFF \
	-DWITH_LZ4=OFF \
	-DWITH_SHA256=OFF \
	-DWITH_XZ=OFF \
	-DWITH_ZSTD=OFF

# vim: syntax=make
