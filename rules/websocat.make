# -*-makefile-*-
#
# Copyright (C) 2023 by Jon Ringle <jringle@gridpoint.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_WEBSOCAT) += websocat

#
# Paths and names
#
WEBSOCAT_VERSION	:= 1.11.0
WEBSOCAT_MD5		:= 2a43004dc1c256119089994b5ddb414b
WEBSOCAT		:= websocat-$(WEBSOCAT_VERSION)
WEBSOCAT_SUFFIX		:= tar.gz
WEBSOCAT_URL		:= https://github.com/vi/websocat/archive/refs/tags/v${WEBSOCAT_VERSION}.$(WEBSOCAT_SUFFIX)
WEBSOCAT_SOURCE		:= $(SRCDIR)/$(WEBSOCAT).$(WEBSOCAT_SUFFIX)
WEBSOCAT_DIR		:= $(BUILDDIR)/$(WEBSOCAT)
WEBSOCAT_LICENSE	:= MIT AND unknown
WEBSOCAT_LICENSE_FILES	:= file://LICENSE;md5=b0249af598633524d7f0cb5b558c832c

WEBSOCAT_CONF_TOOL	:= cargo
WEBSOCAT_CONF_OPT	:= \
	$(CROSS_CARGO_OPT) \
	--features=ssl

WEBSOCAT_MAKE_ENV	:= \
	$(CROSS_CARGO_ENV) \
	PKG_CONFIG_SYSROOT_DIR=/. \

$(STATEDIR)/websocat.install:
	@$(call targetinfo)
	@$(call world/execute, WEBSOCAT, \
		install -v -m755 -t $(WEBSOCAT_PKGDIR)/bin \
			$(WEBSOCAT_DIR)/target/$(PTXCONF_RUST_TARGET)/release/websocat)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/websocat.targetinstall:
	@$(call targetinfo)

	@$(call install_init, websocat)
	@$(call install_fixup, websocat, PRIORITY, optional)
	@$(call install_fixup, websocat, SECTION, base)
	@$(call install_fixup, websocat, AUTHOR, "Jon Ringle <jringle@gridpoint.com>")
	@$(call install_fixup, websocat, DESCRIPTION, missing)

	@$(call install_copy, websocat, 0, 0, 0755, -, /bin/websocat)

	@$(call install_finish, websocat)

	@$(call touch)

# vim: syntax=make
