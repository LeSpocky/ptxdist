# -*-makefile-*-
#
# Copyright (C) 2023 by Mellanox Technologies Ltd.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SOCKPERF) += sockperf

#
# Paths and names
#
SOCKPERF_VERSION        := 3.10
SOCKPERF_MD5            := c589f072adf8c00eb95ef83c2d371f28
SOCKPERF                := sockperf-$(SOCKPERF_VERSION)
SOCKPERF_SUFFIX         := tar.gz
SOCKPERF_URL            := https://github.com/Mellanox/sockperf/archive/refs/tags/$(SOCKPERF_VERSION).$(SOCKPERF_SUFFIX)
SOCKPERF_SOURCE         := $(SRCDIR)/$(SOCKPERF).$(SOCKPERF_SUFFIX)
SOCKPERF_DIR            := $(BUILDDIR)/$(SOCKPERF)
SOCKPERF_LICENSE        := BSD-3-Clause
SOCKPERF_LICENSE_FILES  := file://copying;md5=13ab6d8129b2b03a18ec815d88b545ce

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SOCKPERF_CONF_TOOL	:= autoconf
SOCKPERF_CONF_ENV       := $(CROSS_ENV) GIT_CEILING_DIRECTORIES="$(BUILDDIR)"
SOCKPERF_MAKE_ENV       := $(CROSS_ENV) GIT_CEILING_DIRECTORIES="$(BUILDDIR)"

$(STATEDIR)/sockperf.prepare:
	@$(call targetinfo)
	@$(call world/execute, SOCKPERF, ./autogen.sh)
	@$(call world/prepare, SOCKPERF)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/sockperf.targetinstall:
	@$(call targetinfo)

	@$(call install_init, sockperf)
	@$(call install_fixup, sockperf,PRIORITY,optional)
	@$(call install_fixup, sockperf,SECTION,base)
	@$(call install_fixup, sockperf,AUTHOR,"Mellanox Technologies Ltd.")
	@$(call install_fixup, sockperf,DESCRIPTION,missing)

	@$(call install_copy, sockperf, 0, 0, 0755, -, /usr/bin/sockperf)

	@$(call install_finish, sockperf)

	@$(call touch)

# vim: syntax=make
