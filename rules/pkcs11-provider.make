# -*-makefile-*-
#
# Copyright (C) 2024 by Rouven Czerwinski <r.czerwinski@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PKCS11_PROVIDER) += pkcs11-provider

#
# Paths and names
#
PKCS11_PROVIDER_VERSION	:= 0.6
PKCS11_PROVIDER_MD5	:= 7e5dc3c81d12c4670615dbd9a7342248
PKCS11_PROVIDER		:= pkcs11-provider-$(PKCS11_PROVIDER_VERSION)
PKCS11_PROVIDER_SUFFIX	:= tar.xz
PKCS11_PROVIDER_URL	:= https://github.com/latchset/pkcs11-provider/releases/download/v$(PKCS11_PROVIDER_VERSION)/$(PKCS11_PROVIDER).$(PKCS11_PROVIDER_SUFFIX)
PKCS11_PROVIDER_SOURCE	:= $(SRCDIR)/$(PKCS11_PROVIDER).$(PKCS11_PROVIDER_SUFFIX)
PKCS11_PROVIDER_DIR	:= $(BUILDDIR)/$(PKCS11_PROVIDER)
PKCS11_PROVIDER_LICENSE	:= Apache-2.0
PKCS11_PROVIDER_LICENSE_FILES	:= file://LICENSES/Apache-2.0.txt;md5=3b83ef96387f14655fc854ddc3c6bd57

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------
PKCS11_PROVIDER_CONF_ENV := \
	PTXDIST_PKG_CONFIG_VAR_NO_SYSROOT=modulesdir

#
# meson
#
PKCS11_PROVIDER_CONF_TOOL	:= meson
PKCS11_PROVIDER_CONF_OPT	:= \
	$(CROSS_MESON_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/pkcs11-provider.targetinstall:
	@$(call targetinfo)

	@$(call install_init, pkcs11-provider)
	@$(call install_fixup, pkcs11-provider,PRIORITY,optional)
	@$(call install_fixup, pkcs11-provider,SECTION,base)
	@$(call install_fixup, pkcs11-provider,AUTHOR,"Rouven Czerwinski <r.czerwinski@pengutronix.de>")
	@$(call install_fixup, pkcs11-provider,DESCRIPTION,missing)

	@$(call install_copy, pkcs11-provider, 0, 0, 0755, -, /usr/lib/ossl-modules/pkcs11.so)

	@$(call install_finish, pkcs11-provider)

	@$(call touch)

# vim: syntax=make
