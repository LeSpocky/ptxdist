# -*-makefile-*-
#
# Copyright (C) 2009 by Jon Ringle <jon@ringle.org>
#               2010 by Marc Kleine-Budde <mkl@pengutronix.de>
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_SQUASHFS_TOOLS) += host-squashfs-tools

#
# Paths and names
#
HOST_SQUASHFS_TOOLS_DIR		= $(HOST_BUILDDIR)/$(SQUASHFS_TOOLS)
HOST_SQUASHFS_TOOLS_SUBDIR	:= squashfs-tools

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

HOST_SQUASHFS_TOOLS_MAKE_OPT := \
	LZO_SUPPORT=1 \
	XZ_SUPPORT=1 \
	ZSTD_SUPPORT=$(call ptx/ifdef, PTXCONF_HOST_SQUASHFS_TOOLS_ZSTD_SUPPORT,1,0)

HOST_SQUASHFS_TOOLS_MAKE_ENV := $(HOST_ENV) EXTRA_LDFLAGS="-L$(PTXDIST_SYSROOT_HOST)/lib/xz"
HOST_SQUASHFS_TOOLS_MAKE_PAR := NO
HOST_SQUASHFS_TOOLS_INSTALL_OPT = install INSTALL_DIR="$(HOST_SQUASHFS_TOOLS_PKGDIR)/sbin"

# vim: syntax=make
