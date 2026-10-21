# -*-makefile-*-
#
# Copyright (C) 2026 by Fabian Pfitzner <f.pfitzner@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
EXTRA_PACKAGES-$(PTXCONF_RSINIT) += rsinit

#
# Paths and names
#
RSINIT_VERSION	:= v0.1.0
RSINIT_SHA256	:= 385afc198237bc8c6183516f6b1444d428e130112f0752f40b8364ed6d8c9936
RSINIT		:= rsinit-$(RSINIT_VERSION)
RSINIT_SUFFIX	:= tar.gz
RSINIT_URL		:= https://github.com/pengutronix/rsinit/archive/$(RSINIT_VERSION).$(RSINIT_SUFFIX)
RSINIT_SOURCE	:= $(SRCDIR)/$(RSINIT).$(RSINIT_SUFFIX)
RSINIT_DIR		:= $(BUILDDIR)/$(RSINIT)
RSINIT_LICENSE	:= GPL-2.0-only
RSINIT_LICENSE_FILES	:= \
	file://LICENSES/CC0-1.0.txt;md5=65d3616852dbf7b1a6d4b53b00626032 \
	file://LICENSES/GPL-2.0-only.txt;md5=570a9b3749dd0463a1778803b12a6dce

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

RSINIT_FEATURES-y :=
RSINIT_FEATURES-$(PTXCONF_RSINIT_SYSTEMD) += systemd
RSINIT_FEATURES-$(PTXCONF_RSINIT_DMVERITY) += dmverity
RSINIT_FEATURES-$(PTXCONF_RSINIT_REBOOT_ON_FAILURE) += reboot-on-failure
RSINIT_FEATURES-$(PTXCONF_RSINIT_USB9PFS) += usb9pfs

RSINIT_FEATURES := $(subst $(space),$(comma), $(strip $(RSINIT_FEATURES-y)))

#
# cargo
#
RSINIT_CONF_TOOL	:= cargo
RSINIT_MAKE_OPT	:= \
	$(CROSS_CARGO_OPT) \
	--no-default-features \
	--features $(RSINIT_FEATURES)

RSINIT_MAKE_ENV := \
	$(CROSS_ENV) \
	$(CROSS_CARGO_ENV) \
	RUSTFLAGS='-C target-feature=+crt-static -Zfmt-debug=none'

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/rsinit.install:
	@$(call targetinfo)
	@$(call world/execute, RSINIT, \
		install -D -v -m755 -t $(RSINIT_PKGDIR)/initramfs \
			$(RSINIT_DIR)/target/$(PTXCONF_RUST_TARGET)/release/init)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/rsinit.targetinstall:
	@$(call targetinfo)

	@$(call install_init, rsinit)
	@$(call install_fixup, rsinit,PRIORITY,optional)
	@$(call install_fixup, rsinit,SECTION,base)
	@$(call install_fixup, rsinit,AUTHOR,"Fabian Pfitzner <f.pfitzner@pengutronix.de>")
	@$(call install_fixup, rsinit,DESCRIPTION,missing)

	@$(call install_copy, rsinit, 0, 0, 0755, -, /initramfs/init)

	@$(call install_finish, rsinit)

	@$(call touch)

# vim: syntax=make
