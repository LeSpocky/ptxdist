# -*-makefile-*-
#
# Copyright (C) 2020 by Ladislav Michl <ladis@linux-mips.org>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_OPENFORTIVPN) += openfortivpn

#
# Paths and names
#
OPENFORTIVPN_VERSION	:= 1.14.1
OPENFORTIVPN_MD5	:= 226472c18f0331491b42b4300e8bff7c
OPENFORTIVPN		:= openfortivpn-$(OPENFORTIVPN_VERSION)
OPENFORTIVPN_SUFFIX	:= tar.gz
OPENFORTIVPN_URL	:= https://github.com/adrienverge/openfortivpn/archive/v$(OPENFORTIVPN_VERSION).$(OPENFORTIVPN_SUFFIX)
OPENFORTIVPN_SOURCE	:= $(SRCDIR)/$(OPENFORTIVPN).$(OPENFORTIVPN_SUFFIX)
OPENFORTIVPN_DIR	:= $(BUILDDIR)/$(OPENFORTIVPN)
OPENFORTIVPN_LICENSE	:= GPL-3.0-or-later WITH unknown-exception AND OpenSSL
OPENFORTIVPN_LICENSE_FILES := \
	file://LICENSE;md5=1d58d8f3da4c52035c4ad376ffabb44a \
	file://LICENSE.OpenSSL;md5=f3317a38a556060e468331158cc43fe3 \
	file://src/main.c;startline=4;endline=15;md5=2d74bd9c818c4c3009c1c8782aaa23e7 \
	file://src/tunnel.c;startline=4;endline=26;md5=5454796bf6fd04c7e4ad6bd83a627e4f

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
OPENFORTIVPN_CONF_TOOL	:= autoconf
OPENFORTIVPN_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--enable-proc \
	--enable-resolvconf \
	--with-rt_dst \
	--without-ppp \
	--with-pppd=/usr/sbin/pppd \
	--with-systemdsystemunitdir=/usr/lib/systemd/system

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/openfortivpn.targetinstall:
	@$(call targetinfo)

	@$(call install_init, openfortivpn)
	@$(call install_fixup, openfortivpn,PRIORITY,optional)
	@$(call install_fixup, openfortivpn,SECTION,base)
	@$(call install_fixup, openfortivpn,AUTHOR,"Ladislav Michl <ladis@linux-mips.org>")
	@$(call install_fixup, openfortivpn,DESCRIPTION,"Client for PPP+SSL VPN tunnel")

	@$(call install_alternative, openfortivpn, 0, 0, 0644, /etc/openfortivpn/config)

	@$(call install_copy, openfortivpn, 0, 0, 0755, -, /usr/bin/openfortivpn)

ifdef PTXCONF_OPENFORTIVPN_SYSTEMD
	@$(call install_alternative, openfortivpn, 0, 0, 0644, \
		/usr/lib/systemd/system/openfortivpn@.service)
endif

	@$(call install_finish, openfortivpn)

	@$(call touch)

# vim: syntax=make
