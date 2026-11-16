# -*-makefile-*-
#
# Copyright (C) 2014 by Markus Pargmann <mpa@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_NINJA) += host-ninja

#
# Paths and names
#
HOST_NINJA_VERSION	:= 1.13.2.g7659b.kitware.jobserver-pipe-1
HOST_NINJA_SHA256	:= d3d8408c3ed8898cc178dc87aaab620c101f45d82941a17765a19507ca1155d1
HOST_NINJA		:= ninja-$(HOST_NINJA_VERSION)
HOST_NINJA_SUFFIX	:= tar.gz
HOST_NINJA_URL		:= https://github.com/Kitware/ninja/archive/refs/tags/v$(HOST_NINJA_VERSION).$(HOST_NINJA_SUFFIX)
HOST_NINJA_SOURCE	:= $(SRCDIR)/$(HOST_NINJA).$(HOST_NINJA_SUFFIX)
HOST_NINJA_DIR		:= $(HOST_BUILDDIR)/$(HOST_NINJA)
HOST_NINJA_LICENSE	:= Apache-2.0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_NINJA_CONF_TOOL	:= cmake
HOST_NINJA_CONF_OPT	:= \
	$(HOST_CMAKE_OPT) \
	-DBUILD_TESTING=OFF

# vim: syntax=make
