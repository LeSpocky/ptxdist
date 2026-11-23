# -*-makefile-*-
#
# Copyright (C) 2011 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_NSS_MDNS) += nss-mdns

#
# Paths and names
#
NSS_MDNS_VERSION	:= 0.15.1
NSS_MDNS_SHA256		:= ddf71453d7a7cdc5921fe53ef387b24fd0c3c49f4dcf94a2a437498596761a21
NSS_MDNS		:= nss-mdns-$(NSS_MDNS_VERSION)
NSS_MDNS_SUFFIX		:= tar.gz
NSS_MDNS_URL		:= https://github.com/avahi/nss-mdns/releases/download/v$(NSS_MDNS_VERSION)/$(NSS_MDNS).$(NSS_MDNS_SUFFIX)
NSS_MDNS_SOURCE		:= $(SRCDIR)/$(NSS_MDNS).$(NSS_MDNS_SUFFIX)
NSS_MDNS_DIR		:= $(BUILDDIR)/$(NSS_MDNS)
NSS_MDNS_LICENSE	:= LGPL-2.1-or-later
NSS_MDNS_LICENSE_FILES	:= \
	file://src/nss.c;startline=4;endline=16;md5=782d501b499b9d510aa4732e4c59050f \
	file://LICENSE;md5=2d5025d4aa3495befef8f17206a5b0a1

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
NSS_MDNS_CONF_TOOL	:= autoconf
NSS_MDNS_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-tests

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/nss-mdns.targetinstall:
	@$(call targetinfo)

	@$(call install_init, nss-mdns)
	@$(call install_fixup, nss-mdns,PRIORITY,optional)
	@$(call install_fixup, nss-mdns,SECTION,base)
	@$(call install_fixup, nss-mdns,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, nss-mdns,DESCRIPTION,missing)

	@$(call install_lib, nss-mdns, 0, 0, 0644, libnss_mdns)
	@$(call install_lib, nss-mdns, 0, 0, 0644, libnss_mdns4)
	@$(call install_lib, nss-mdns, 0, 0, 0644, libnss_mdns6)
	@$(call install_lib, nss-mdns, 0, 0, 0644, libnss_mdns_minimal)
	@$(call install_lib, nss-mdns, 0, 0, 0644, libnss_mdns4_minimal)
	@$(call install_lib, nss-mdns, 0, 0, 0644, libnss_mdns6_minimal)

	@$(call install_finish, nss-mdns)

	@$(call touch)

# vim: syntax=make
