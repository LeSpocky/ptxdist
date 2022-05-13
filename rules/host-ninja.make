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
HOST_NINJA_VERSION	:= 1.10.2.g51db2.kitware.jobserver-1
HOST_NINJA_MD5		:= 0bdd69f1013deb74465fe5d03e8fa2ea
HOST_NINJA		:= ninja-$(HOST_NINJA_VERSION)
HOST_NINJA_SUFFIX	:= tar.gz
HOST_NINJA_URL		:= https://github.com/Kitware/ninja/archive/refs/tags/v$(HOST_NINJA_VERSION).$(HOST_NINJA_SUFFIX)
HOST_NINJA_SOURCE	:= $(SRCDIR)/$(HOST_NINJA).$(HOST_NINJA_SUFFIX)
HOST_NINJA_DIR		:= $(HOST_BUILDDIR)/$(HOST_NINJA)
HOST_NINJA_LICENSE	:= Apache-2.0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_NINJA_BUILD_OOT	:= NO

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

HOST_NINJA_CONF_TOOL	:= cmake
HOST_NINJA_CONF_OPT	:= \
	$(HOST_CMAKE_OPT) 

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-ninja.install:
	@$(call targetinfo)
	@$(call world/execute, HOST_NINJA, \
		install -vD -m755 $(HOST_NINJA_DIR)/ninja $(HOST_NINJA_PKGDIR)/bin/ninja)
	@$(call touch)

# vim: syntax=make
