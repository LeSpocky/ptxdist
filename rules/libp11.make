# -*-makefile-*-
#
# Copyright (C) 2019 by Rouven Czerwinski <r.czerwinski@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBP11) += libp11

#
# Paths and names
#
LIBP11_VERSION		:= 0.4.12
LIBP11_MD5		:= 2ec3c29523cc06ec60166b320c489c63
LIBP11			:= libp11-$(LIBP11_VERSION)
LIBP11_SUFFIX		:= tar.gz
LIBP11_URL		:= https://github.com/OpenSC/libp11/releases/download/$(LIBP11)/$(LIBP11).$(LIBP11_SUFFIX)
LIBP11_SOURCE		:= $(SRCDIR)/$(LIBP11).$(LIBP11_SUFFIX)
LIBP11_DIR		:= $(BUILDDIR)/$(LIBP11)
LIBP11_LICENSE		:= LGPL-2.1-only
LIBP11_LICENSE_FILES	:= \
	file://COPYING;md5=fad9b3332be894bab9bc501572864b29

#
# autoconf
#
LIBP11_CONF_TOOL	:= autoconf
LIBP11_CONF_OPT		:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-strict \
	--disable-pedantic \
	--disable-api-doc \
	--with-enginesdir=/usr/lib/engines-3 \
	--with-pkcs11-module=$(call ptx/ifdef,PTXCONF_LIBP11_PROXY_MODULE,p11-kit-proxy.so)

$(STATEDIR)/libp11.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libp11)
	@$(call install_fixup, libp11,PRIORITY,optional)
	@$(call install_fixup, libp11,SECTION,base)
	@$(call install_fixup, libp11,AUTHOR,"Rouven Czerwinski <r.czerwinski@pengutronix.de>")
	@$(call install_fixup, libp11,DESCRIPTION,missing)

	@$(call install_lib,  libp11, 0, 0, 0644, libp11)
	@$(call install_copy, libp11, 0, 0, 0644, -, \
		/usr/lib/engines-3/pkcs11.so)

	@$(call install_link, libp11, pkcs11.so, \
		/usr/lib/engines-3/libpkcs11.so)

	@$(call install_finish, libp11)

	@$(call touch)

# vim: syntax=make
