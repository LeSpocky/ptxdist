# -*-makefile-*-
#
# Copyright (C) 2004 by Robert Schwebel
#               2007 by Carsten Schlote, konzeptpark
#               2008 by Juergen Beisert
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#               2016 by Andreas Geisenhainer <andreas.geisenhainer@atsonline.de>
#
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_IPTABLES) += iptables

#
# Paths and names
#
IPTABLES_VERSION	:= 1.8.11
IPTABLES_MD5		:= 44191ce12055da9790a92429c771ba50
IPTABLES		:= iptables-$(IPTABLES_VERSION)
IPTABLES_SUFFIX		:= tar.xz
IPTABLES_URL		:= https://ftp.netfilter.org/pub/iptables/$(IPTABLES).$(IPTABLES_SUFFIX)
IPTABLES_SOURCE		:= $(SRCDIR)/$(IPTABLES).$(IPTABLES_SUFFIX)
IPTABLES_DIR		:= $(BUILDDIR)/$(IPTABLES)
IPTABLES_LICENSE	:= GPL-2.0-only
IPTABLES_LICENSE_FILES	:= \
	file://COPYING;md5=b234ee4d69f5fce4486a80fdaf4a4263

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
IPTABLES_CONF_TOOL	:= autoconf
IPTABLES_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--$(call ptx/endis, PTXCONF_IPTABLES_IPV4)-ipv4 \
	--$(call ptx/endis, PTXCONF_IPTABLES_IPV6)-ipv6 \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--enable-devel \
	--$(call ptx/endis, PTXCONF_IPTABLES_LIBIPQ)-libipq \
	--disable-bpf-compiler \
	--disable-nfsynproxy \
	--$(call ptx/endis, PTXCONF_IPTABLES_NFTABLES_COMPAT)-nftables \
	--$(call ptx/endis, PTXCONF_IPTABLES_LIBNFNETLINK)-libnfnetlink \
	--disable-connlabel \
	--disable-profiling \
	--with-kernel=$(KERNEL_HEADERS_DIR) \
	--with-xtlibdir=/usr/lib

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/iptables.install:
	@$(call targetinfo)
	@$(call world/install, IPTABLES)
	install $(IPTABLES_DIR)/iptables/iptables-apply $(IPTABLES_PKGDIR)/usr/sbin
	@$(touch)


# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/iptables.targetinstall:
	@$(call targetinfo)

	@$(call install_init, iptables)
	@$(call install_fixup, iptables,PRIORITY,optional)
	@$(call install_fixup, iptables,SECTION,base)
	@$(call install_fixup, iptables,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, iptables,DESCRIPTION,missing)

	@$(call install_lib, iptables, 0, 0, 0644, libxtables)

ifdef PTXCONF_IPTABLES_LIBIPQ
	@$(call install_lib, iptables, 0, 0, 0644, libipq)
endif
	@$(call install_glob, iptables, 0, 0, -, /usr/lib, */libxt_*.so,)

ifdef PTXCONF_IPTABLES_IPV6
	@$(call install_glob, iptables, 0, 0, -, /usr/lib, */libip6t_*.so,)
	@$(call install_lib, iptables, 0, 0, 0644, libip6tc)
endif

ifdef PTXCONF_IPTABLES_IPV4
	@$(call install_glob, iptables, 0, 0, -, /usr/lib, */libipt_*.so,)
	@$(call install_lib, iptables, 0, 0, 0644, libip4tc)
endif

ifdef PTXCONF_IPTABLES_INSTALL_TOOLS
	@$(call install_copy, iptables, 0, 0, 0755, -, /usr/sbin/xtables-legacy-multi)
	@$(call install_link, iptables, ../sbin/xtables-legacy-multi, /usr/bin/iptables-xml)

ifdef PTXCONF_IPTABLES_LIBNFNETLINK
	@$(call install_copy, iptables, 0, 0, 0755, -, /usr/sbin/nfnl_osf)
endif

ifdef PTXCONF_IPTABLES_IPV6
	@$(call install_link, iptables, xtables-legacy-multi, /usr/sbin/ip6tables)
	@$(call install_link, iptables, xtables-legacy-multi, /usr/sbin/ip6tables-restore)
	@$(call install_link, iptables, xtables-legacy-multi, /usr/sbin/ip6tables-save)
endif

ifdef PTXCONF_IPTABLES_IPV4
	@$(call install_link, iptables, xtables-legacy-multi, /usr/sbin/iptables)
	@$(call install_link, iptables, xtables-legacy-multi, /usr/sbin/iptables-restore)
	@$(call install_link, iptables, xtables-legacy-multi, /usr/sbin/iptables-save)
endif

ifdef PTXCONF_IPTABLES_IPV6_SYSTEMD_UNIT
	@$(call install_alternative, iptables, 0, 0, 0644, /etc/iptables/rules.v6)
	@$(call install_alternative, iptables, 0, 0, 0755, /usr/sbin/ip6tables-flush)
	@$(call install_alternative, iptables, 0, 0, 0644, \
		/usr/lib/systemd/system/ip6tables.service)
	@$(call install_link, iptables, ../ip6tables.service, \
		/usr/lib/systemd/system/multi-user.target.wants/ip6tables.service)
endif

ifdef PTXCONF_IPTABLES_IPV4_SYSTEMD_UNIT
	@$(call install_alternative, iptables, 0, 0, 0644, /etc/iptables/rules.v4)
	@$(call install_alternative, iptables, 0, 0, 0755, /usr/sbin/iptables-flush)
	@$(call install_alternative, iptables, 0, 0, 0644, \
		/usr/lib/systemd/system/iptables.service)
	@$(call install_link, iptables, ../iptables.service, \
		/usr/lib/systemd/system/multi-user.target.wants/iptables.service)
endif

endif # PTXCONF_IPTABLES_INSTALL_TOOLS

ifdef PTXCONF_IPTABLES_INSTALL_IPTABLES_APPLY
	@$(call install_copy, iptables, 0, 0, 0755, -, /usr/sbin/iptables-apply)
endif

ifdef PTXCONF_IPTABLES_NFTABLES_COMPAT
	@$(call install_copy, iptables, 0, 0, 0755, -, /usr/sbin/xtables-nft-multi)

ifdef PTXCONF_IPTABLES_IPV4
	@$(call install_link, iptables, xtables-nft-multi, /usr/sbin/iptables-nft)
	@$(call install_link, iptables, xtables-nft-multi, /usr/sbin/iptables-nft-save)
	@$(call install_link, iptables, xtables-nft-multi, /usr/sbin/iptables-nft-restore)
endif

ifdef PTXCONF_IPTABLES_IPV6
	@$(call install_link, iptables, xtables-nft-multi, /usr/sbin/ip6tables-nft)
	@$(call install_link, iptables, xtables-nft-multi, /usr/sbin/ip6tables-nft-save)
	@$(call install_link, iptables, xtables-nft-multi, /usr/sbin/ip6tables-nft-restore)
endif

	@$(call install_link, iptables, xtables-nft-multi, /usr/sbin/arptables-nft)
	@$(call install_link, iptables, xtables-nft-multi, /usr/sbin/ebtables-nft)
endif # PTXCONF_IPTABLES_NFTABLES_COMPAT

	@$(call install_finish, iptables)

	@$(call touch)

# vim: syntax=make
