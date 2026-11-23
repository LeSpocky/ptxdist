# -*-makefile-*-
#
# Copyright (C) 2014 by Alexander Aring <aar@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_EASY_RSA) += easy-rsa

#
# Paths and names
#
EASY_RSA_VERSION	:= 3.2.7
EASY_RSA_SHA256		:= 308743bc9fe871b902d47dbe98d749daff3a05b27531684f02625ce7208d4598
EASY_RSA		:= EasyRSA-$(EASY_RSA_VERSION)
EASY_RSA_SUFFIX		:= tgz
EASY_RSA_URL		:= https://github.com/OpenVPN/easy-rsa/releases/download/v$(EASY_RSA_VERSION)/$(EASY_RSA).$(EASY_RSA_SUFFIX)
EASY_RSA_SOURCE		:= $(SRCDIR)/$(EASY_RSA).$(EASY_RSA_SUFFIX)
EASY_RSA_DIR		:= $(BUILDDIR)/$(EASY_RSA)
EASY_RSA_LICENSE	:= GPL-2.0-only
EASY_RSA_LICENSE_FILES	:= \
	file://easyrsa;startline=3;endline=11;md5=8f3cad3587a89a701c5161ef4e0b54cc \
	file://COPYING.md;md5=58146dc36278c2de5b89534d1ad8f06c \
	file://gpl-2.0.txt;md5=b234ee4d69f5fce4486a80fdaf4a4263

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

EASY_RSA_CONF_TOOL	:= NO

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/easy-rsa.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/easy-rsa.install:
	@$(call targetinfo)
	@install -D -m 0755 $(EASY_RSA_DIR)/easyrsa \
		$(EASY_RSA_PKGDIR)/usr/share/easy-rsa/easyrsa
	@install -m 0644 $(EASY_RSA_DIR)/openssl-easyrsa.cnf \
		$(EASY_RSA_DIR)/vars.example \
		$(EASY_RSA_PKGDIR)/usr/share/easy-rsa/
	@install -D -m 0644 -t $(EASY_RSA_PKGDIR)/usr/share/easy-rsa/x509-types \
		$(EASY_RSA_DIR)/x509-types/*
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/easy-rsa.targetinstall:
	@$(call targetinfo)

	@$(call install_init, easy-rsa)
	@$(call install_fixup, easy-rsa,PRIORITY,optional)
	@$(call install_fixup, easy-rsa,SECTION,base)
	@$(call install_fixup, easy-rsa,AUTHOR,"Alexander Aring <aar@pengutronix.de>")
	@$(call install_fixup, easy-rsa,DESCRIPTION,missing)

	@$(call install_copy, easy-rsa, 0, 0, 0755, -, /usr/share/easy-rsa/easyrsa)
	@$(call install_link, easy-rsa, ../share/easy-rsa/easyrsa, /usr/bin/easyrsa)
	@$(call install_copy, easy-rsa, 0, 0, 0644, -, \
		/usr/share/easy-rsa/openssl-easyrsa.cnf)
	@$(call install_copy, easy-rsa, 0, 0, 0644, -, \
		/usr/share/easy-rsa/vars.example)
	@$(call install_tree, easy-rsa, 0, 0, -, /usr/share/easy-rsa/x509-types)

	@$(call install_finish, easy-rsa)

	@$(call touch)

# vim: syntax=make
