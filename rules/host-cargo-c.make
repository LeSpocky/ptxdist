# -*-makefile-*-
#
# Copyright (C) 2022 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_CARGO_C) += host-cargo-c

ifdef PTXCONF_HOST_CARGO_C
HOST_CARGO_C_CARGO_VERSION	:= $(word 2, $(subst -,$(space),$(call ptx/force-sh, cargo --version)))
endif

#
# Paths and names
#
ifneq ($(filter 1.7%,$(HOST_CARGO_C_CARGO_VERSION)),)
HOST_CARGO_C_VERSION		:= 0.9.27+cargo-0.74.0
HOST_CARGO_C_SHA256		:= f83d9e98867fecb774b2f45cd7ed9e253dc453b50a90774f3b8ffecefe095cf7
else
ifneq ($(filter 1.8%,$(HOST_CARGO_C_CARGO_VERSION)),)
HOST_CARGO_C_VERSION		:= 0.10.4+cargo-0.82.0
HOST_CARGO_C_SHA256		:= 516e8c3f59af4f1c2571abf539fe26384d4ee12b3bc91dc32c00a0c6efb1a8a2
else
HOST_CARGO_C_VERSION		:= 0.10.20+cargo-0.94.0
HOST_CARGO_C_SHA256		:= 5e953a7ea21435da3a584c61fcb7650a9a7a290a5a88d3bb05a5b1493b4a2160
endif
endif
HOST_CARGO_C			:= cargo-c-$(HOST_CARGO_C_VERSION)
HOST_CARGO_C_SUFFIX		:= tar.gz
HOST_CARGO_C_URL		:= https://crates.io/api/v1/crates/cargo-c/$(HOST_CARGO_C_VERSION)/download
HOST_CARGO_C_SOURCE		:= $(SRCDIR)/$(HOST_CARGO_C).$(HOST_CARGO_C_SUFFIX)
HOST_CARGO_C_DIR		:= $(HOST_BUILDDIR)/$(HOST_CARGO_C)
HOST_CARGO_C_LICENSE		:= MIT AND unknown
HOST_CARGO_C_LICENSE_FILES	:= \
	file://LICENSE;md5=384ed0e2e0b2dac094e51fbf93fdcbe0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# cargo
#
HOST_CARGO_C_CONF_TOOL	:= cargo

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

HOST_CARGO_C_TOOLS	:= \
	cargo-capi \
	cargo-cbuild \
	cargo-cinstall \
	cargo-ctest

$(STATEDIR)/host-cargo-c.install:
	@$(call targetinfo)
	@$(call world/execute, HOST_CARGO_C, \
		install -v -m755 -t $(HOST_CARGO_C_PKGDIR)/bin \
		$(addprefix $(HOST_CARGO_C_DIR)/target/release/, $(HOST_CARGO_C_TOOLS)))
	@$(call touch)

# vim: syntax=make
