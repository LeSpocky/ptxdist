# -*-makefile-*-
#
# Copyright (C) 2026 by Sascha Hauer <s.hauer@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_PKCS11_PROVIDER) += host-pkcs11-provider

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_PKCS11_PROVIDER_CONF_ENV	:= \
	$(HOST_ENV)

#
# meson
#
HOST_PKCS11_PROVIDER_CONF_TOOL	:= meson
HOST_PKCS11_PROVIDER_CONF_OPT	:=  \
	$(HOST_MESON_OPT)

# vim: ft=make
