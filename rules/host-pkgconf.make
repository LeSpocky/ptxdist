# -*-makefile-*-
#
# Copyright (C) 2023 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_PKGCONF) += host-pkgconf

#
# Paths and names
#
HOST_PKGCONF_VERSION		:= 2.2.0
HOST_PKGCONF_MD5		:= 00e309a3bf0909030a4fc701389db2b9
HOST_PKGCONF			:= pkgconf-$(HOST_PKGCONF_VERSION)
HOST_PKGCONF_SUFFIX		:= tar.xz
HOST_PKGCONF_URL		:= https://distfiles.ariadne.space/pkgconf/$(HOST_PKGCONF).$(HOST_PKGCONF_SUFFIX)
HOST_PKGCONF_SOURCE		:= $(SRCDIR)/$(HOST_PKGCONF).$(HOST_PKGCONF_SUFFIX)
HOST_PKGCONF_DIR		:= $(HOST_BUILDDIR)/$(HOST_PKGCONF)
HOST_PKGCONF_LICENSE		:= custom
HOST_PKGCONF_LICENSE_FILES	:= file://COPYING;md5=2214222ec1a820bd6cc75167a56925e0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_PKGCONF_CONF_TOOL	:= autoconf
HOST_PKGCONF_CONF_OPT	:=  \
	$(HOST_AUTOCONF)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

PKG_CONFIG_SCRIPT = \
	$(shell ptxd_get_alternative scripts pkg-config-wrapper && echo $$ptxd_reply)

HOST_PKGCONF_BINCONFIG_GLOB := does-not-exist

$(STATEDIR)/host-pkgconf.install:
	@$(call targetinfo)
	@$(call world/install, HOST_PKGCONF)
	@ln -sv $(PKG_CONFIG_SCRIPT) \
		$(HOST_PKGCONF_PKGDIR)/usr/bin/pkg-config
	@$(call touch)

# vim: syntax=make
