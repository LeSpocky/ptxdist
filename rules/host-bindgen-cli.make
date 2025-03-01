# -*-makefile-*-
#
# Copyright (C) 2025 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_BINDGEN_CLI) += host-bindgen-cli

#
# Paths and names
#
HOST_BINDGEN_CLI_VERSION	:= 0.71.1
HOST_BINDGEN_CLI_MD5		:= 5a487a1bb262a78b0d1a58e2feef8940
HOST_BINDGEN_CLI		:= bindgen-cli-$(HOST_BINDGEN_CLI_VERSION)
HOST_BINDGEN_CLI_SUFFIX		:= tar.gz
HOST_BINDGEN_CLI_URL		:= https://crates.io/api/v1/crates/bindgen-cli/$(HOST_BINDGEN_CLI_VERSION)/download
HOST_BINDGEN_CLI_SOURCE		:= $(SRCDIR)/$(HOST_BINDGEN_CLI).$(HOST_BINDGEN_CLI_SUFFIX)
HOST_BINDGEN_CLI_DIR		:= $(HOST_BUILDDIR)/$(HOST_BINDGEN_CLI)
HOST_BINDGEN_CLI_LICENSE	:= BSD-3-Clause and unknown
HOST_BINDGEN_CLI_LICENSE_FILES	:= \
	file://LICENSE;md5=0b9a98cb3dcdefcceb145324693fda9b

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# cargo
#
HOST_BINDGEN_CLI_CONF_TOOL	:= cargo

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-bindgen-cli.install:
	@$(call targetinfo)
	@$(call world/execute, HOST_BINDGEN_CLI, \
		install -v -m755 -t $(HOST_BINDGEN_CLI_PKGDIR)/usr/bin \
		$(HOST_BINDGEN_CLI_DIR)/target/release/bindgen)
	@$(call touch)

# vim: syntax=make
