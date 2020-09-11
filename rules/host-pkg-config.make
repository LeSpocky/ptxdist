# -*-makefile-*-
#
# Copyright (C) 2006-2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_PKG_CONFIG) += host-pkg-config

#
# Paths and names
#
HOST_PKG_CONFIG_VERSION	:= 0.29.2
HOST_PKG_CONFIG_MD5	:= f6e931e319531b736fadc017f470e68a
HOST_PKG_CONFIG		:= pkg-config-$(HOST_PKG_CONFIG_VERSION)
HOST_PKG_CONFIG_SUFFIX	:= tar.gz
HOST_PKG_CONFIG_URL	:= http://pkgconfig.freedesktop.org/releases/$(HOST_PKG_CONFIG).$(HOST_PKG_CONFIG_SUFFIX)
HOST_PKG_CONFIG_SOURCE	:= $(SRCDIR)/$(HOST_PKG_CONFIG).$(HOST_PKG_CONFIG_SUFFIX)
HOST_PKG_CONFIG_DIR	:= $(HOST_BUILDDIR)/$(HOST_PKG_CONFIG)
HOST_PKG_CONFIG_LICENSE	:= GPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_PKG_CONFIG_CONF_TOOL	:= autoconf
HOST_PKG_CONFIG_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--disable-host-tool \
	--with-internal-glib

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

PKG_CONFIG_SCRIPT = \
	$(shell ptxd_get_alternative scripts pkg-config-wrapper && echo $$ptxd_reply)

HOST_PKG_CONFIG_BINCONFIG_GLOB := does-not-exist

$(STATEDIR)/host-pkg-config.install:
	@$(call targetinfo)
	@$(call world/install, HOST_PKG_CONFIG)
	@mv $(HOST_PKG_CONFIG_PKGDIR)/bin/pkg-config \
		$(HOST_PKG_CONFIG_PKGDIR)/bin/pkg-config.real
	@ln -sv $(PKG_CONFIG_SCRIPT) \
		$(HOST_PKG_CONFIG_PKGDIR)/bin/pkg-config
	@$(call touch)

# vim: syntax=make
