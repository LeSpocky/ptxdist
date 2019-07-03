# -*-makefile-*-
#
# Copyright (C) 2003 by Benedikt Spranger
#               2009 by Wolfram Sang, Pengutronix
#               2010 by Marc Kleine-Budde <mkl@pengutronix.de>
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
DHCP_VERSION	:= 4.1.2
DHCP_MD5	:= 23bc6016297aa831dc9f321403e30ddc
DHCP		:= dhcp-$(DHCP_VERSION)
DHCP_SUFFIX	:= tar.gz
DHCP_URL	:= \
	http://ftp.isc.org/isc/dhcp/$(DHCP).$(DHCP_SUFFIX) \
	http://ftp.isc.org/isc/dhcp/dhcp-4.1-history/$(DHCP).$(DHCP_SUFFIX)
DHCP_SOURCE	:= $(SRCDIR)/$(DHCP).$(DHCP_SUFFIX)
DHCP_DIR	:= $(BUILDDIR)/$(DHCP)
DHCP_LICENSE	:= ISC


# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
DHCP_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--$(call ptx/endis, PTXCONF_GLOBAL_IPV6)-dhcpv6

# overwrite CFLAGS to remove -Werror
DHCP_MAKE_OPT := \
	CFLAGS="-g -O2  -Wall -fno-strict-aliasing"

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
endif

ifdef PTXCONF_DHCP_DHCPD_CONF
	@$(call install_alternative, dhcp, 0, 0, 0644, /etc/dhcpd.conf)
endif

ifdef PTXCONF_DHCP_CLIENT
	@$(call install_copy, dhcp, 0, 0, 0755, /var/db)
	@$(call install_copy, dhcp, 0, 0, 0755, /var/state/dhcp )

	@$(call install_copy, dhcp, 0, 0, 0755, -, \
		/usr/sbin/dhclient)

endif

ifdef PTXCONF_DHCP_DHCLIENT_SCRIPT
	@$(call install_alternative, dhcp, 0, 0, 0755, /etc/dhclient-script)
endif

ifdef PTXCONF_DHCP_DHCLIENT_CONF
	@$(call install_alternative, dhcp, 0, 0, 0644, /etc/dhclient.conf)
endif

ifdef PTXCONF_DHCP_RELAY
	@$(call install_copy, dhcp, 0, 0, 0755, -, \
		/usr/sbin/dhcrelay)
endif

	@$(call install_finish, dhcp)

	@$(call touch)

# vim: syntax=make
