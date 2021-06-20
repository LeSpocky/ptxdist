# -*-makefile-*-
#
# Copyright (C) 2003 by Benedikt Spranger
#               2009 by Wolfram Sang, Pengutronix
#               2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#               2021 by Roland Hieber, Pengutronix <rhi@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_DHCP) += dhcp

#
# Paths and names
#
DHCP_VERSION	:= 4.4.2
DHCP_MD5	:= 2afdaf8498dc1edaf3012efdd589b3e1
DHCP		:= dhcp-$(DHCP_VERSION)
DHCP_SUFFIX	:= tar.gz
DHCP_URL	:= \
	https://ftp.isc.org/isc/dhcp/$(DHCP_VERSION)/$(DHCP).$(DHCP_SUFFIX) \
	https://ftp.isc.org/isc/dhcp/$(DHCP).$(DHCP_SUFFIX) \
	https://ftp.isc.org/isc/dhcp/dhcp-4.1-history/$(DHCP).$(DHCP_SUFFIX)
DHCP_SOURCE	:= $(SRCDIR)/$(DHCP).$(DHCP_SUFFIX)
DHCP_DIR	:= $(BUILDDIR)/$(DHCP)
DHCP_LICENSE	:= MPL-2.0 AND BSD-3-Clause AND ISC
DHCP_LICENSE_FILES	:= \
	file://LICENSE;md5=b9c6e660b3d9260de9a342d2fb77540a \
	file://server/ldap.c;startline=6;endline=35;md5=8e5f9d2cd6b641d599871fd2430708c4 \
	file://server/ldap_casa.c;startline=35;endline=48;md5=d2ea64a00aeacb447c6634d984486afe

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
DHCP_CONF_TOOL	:= autoconf
DHCP_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--disable-debug \
	--enable-failover \
	--disable-execute \
	--enable-tracing \
	--enable-delayed-ack \
	--$(call ptx/endis, PTXCONF_GLOBAL_IPV6)-dhcpv6 \
	--disable-dhcpv4o6 \
	--disable-relay-port \
	--enable-paranoia \
	--enable-early-chroot \
	--disable-ipv4-pktinfo \
	--enable-use-sockets \
	--disable-log-pid \
	--disable-binary-leases \
	--disable-kqueue \
	--disable-epoll \
	--disable-devpoll \
	--disable-libtool \
	--disable-bind-install \
	--without-atf \
	--with-randomdev=/dev/random \
	--with-libbind=$(SYSROOT)/usr \
	--without-bind-extra-config \
	--without-ldap \
	--without-ldapcrypto \
	--without-ldap-gssapi \
	--without-ldapcasa

ifdef PTXCONF_ARCH_PPC
DHCP_CONF_ENV	:= \
	$(CROSS_ENV) \
	LIBS=-latomic
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/dhcp.targetinstall:
	@$(call targetinfo)

	@$(call install_init, dhcp)
	@$(call install_fixup, dhcp,PRIORITY,optional)
	@$(call install_fixup, dhcp,SECTION,base)
	@$(call install_fixup, dhcp,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, dhcp,DESCRIPTION,missing)

ifdef PTXCONF_DHCP_SERVER
	@$(call install_copy, dhcp, 0, 0, 0755, -, \
		/usr/sbin/dhcpd)
	@$(call install_alternative, dhcp, 0, 0, 0644, /etc/dhcpd.conf)
endif

ifdef PTXCONF_DHCP_CLIENT
	@$(call install_copy, dhcp, 0, 0, 0755, /var/db)
	@$(call install_copy, dhcp, 0, 0, 0755, /var/state/dhcp )

	@$(call install_copy, dhcp, 0, 0, 0755, -, \
		/usr/sbin/dhclient)

	@$(call install_alternative, dhcp, 0, 0, 0755, /etc/dhclient-script)
	@$(call install_alternative, dhcp, 0, 0, 0644, /etc/dhclient.conf)
endif

ifdef PTXCONF_DHCP_RELAY
	@$(call install_copy, dhcp, 0, 0, 0755, -, \
		/usr/sbin/dhcrelay)
endif

	@$(call install_finish, dhcp)

	@$(call touch)

# vim: syntax=make
