# -*-makefile-*-
#
# Copyright (C) 2023 by Philipp Zabel <p.zabel@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_VKRUNNER) += vkrunner

#
# Paths and names
#
VKRUNNER_VERSION	:= 2023-10-29-g93cbb7b1cca7
VKRUNNER_MD5		:= e8f10e5b90d753ad7744662a519c2260
VKRUNNER		:= vkrunner-$(VKRUNNER_VERSION)
VKRUNNER_SUFFIX		:= tar.gz
VKRUNNER_URL		:= https://gitlab.freedesktop.org/mesa/vkrunner/-/archive/$(VKRUNNER_VERSION)/$(VKRUNNER).$(VKRUNNER_SUFFIX)
VKRUNNER_SOURCE		:= $(SRCDIR)/$(VKRUNNER).$(VKRUNNER_SUFFIX)
VKRUNNER_DIR		:= $(BUILDDIR)/$(VKRUNNER)
VKRUNNER_LICENSE	:= MIT AND Apache-2.0
VKRUNNER_LICENSE_FILES	:= file://COPYING;md5=b16067245eacd718bc35526d75bc0893

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

VKRUNNER_CONF_TOOL	:= cargo
VKRUNNER_MAKE_ENV	:= \
	$(CROSS_CARGO_ENV) \
	LIBCLANG_PATH=$(PTXDIST_PLATFORMDIR)/selected_toolchain/../lib

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/vkrunner.install:
	@$(call targetinfo)
	@$(call world/execute, VKRUNNER, \
		install -v -m755 -t $(VKRUNNER_PKGDIR)/usr/bin \
			$(VKRUNNER_DIR)/target/$(PTXCONF_RUST_TARGET)/release/vkrunner)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/vkrunner.targetinstall:
	@$(call targetinfo)

	@$(call install_init, vkrunner)
	@$(call install_fixup, vkrunner, PRIORITY, optional)
	@$(call install_fixup, vkrunner, SECTION, base)
	@$(call install_fixup, vkrunner, AUTHOR, "Philipp Zabel <p.zabel@pengutronix.de>")
	@$(call install_fixup, vkrunner, DESCRIPTION, missing)

	$(call install_copy, vkrunner, 0, 0, 0755, -, /usr/bin/vkrunner)

	@$(call install_finish, vkrunner)

	@$(call touch)

# vim: syntax=make
