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
PACKAGES-$(PTXCONF_P11_KIT) += p11-kit

#
# Paths and names
#
P11_KIT_VERSION		:= 0.25.5
P11_KIT_MD5		:= e9c5675508fcd8be54aa4c8cb8e794fc
P11_KIT			:= p11-kit-$(P11_KIT_VERSION)
P11_KIT_SUFFIX		:= tar.xz
P11_KIT_URL		:= https://github.com/p11-glue/p11-kit/releases/download/$(P11_KIT_VERSION)/$(P11_KIT).$(P11_KIT_SUFFIX)
P11_KIT_SOURCE		:= $(SRCDIR)/$(P11_KIT).$(P11_KIT_SUFFIX)
P11_KIT_DIR		:= $(BUILDDIR)/$(P11_KIT)
P11_KIT_LICENSE		:= BSD-3-Clause
P11_KIT_LICENSE_FILES	:= \
	file://COPYING;md5=02933887f609807fbb57aa4237d14a50

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# stdbool.h check is broken with gcc-15 (-std=c23)
P11_KIT_CONF_ENV := \
	$(CROSS_ENV) \
	ac_cv_header_stdbool_h=yes \
	am_cv_pathless_PYTHON=python3

#
# autoconf
#
P11_KIT_CONF_TOOL	:= autoconf
P11_KIT_CONF_OPT		:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-nls \
	--disable-rpath \
	--disable-env-override-paths \
	--disable-trust-module \
	--disable-doc \
	--disable-doc-html \
	--disable-doc-pdf \
	--disable-debug \
	--disable-strict \
	--disable-coverage \
	--without-libtasn1 \
	--with-libffi \
	--with-hash-impl=internal \
	--with-systemd \
	--without-bash-completion

$(STATEDIR)/p11-kit.targetinstall:
	@$(call targetinfo)

	@$(call install_init, p11-kit)
	@$(call install_fixup, p11-kit,PRIORITY,optional)
	@$(call install_fixup, p11-kit,SECTION,base)
	@$(call install_fixup, p11-kit,AUTHOR,"Rouven Czerwinski <r.czerwinski@pengutronix.de>")
	@$(call install_fixup, p11-kit,DESCRIPTION,missing)

	@$(call install_copy, p11-kit, 0, 0, 0755, -, /usr/bin/p11-kit)

	@$(call install_copy, p11-kit, 0, 0, 0755, -, \
		/usr/libexec/p11-kit/p11-kit-remote)
	@$(call install_copy, p11-kit, 0, 0, 0755, -, \
		/usr/libexec/p11-kit/p11-kit-server)
	@$(call install_copy, p11-kit, 0, 0, 0755, -, \
		/usr/lib/pkcs11/p11-kit-client.so)

	@$(call install_lib,  p11-kit, 0, 0, 0644, libp11-kit)
	@$(call install_link, p11-kit, libp11-kit.so.0, \
		/usr/lib/p11-kit-proxy.so)

	@$(call install_finish, p11-kit)

	@$(call touch)

# vim: syntax=make
