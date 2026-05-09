# -*-makefile-*-
#
# Copyright (C) 2026 by RACOM s.r.o.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_CONNTRACK_TOOLS) += conntrack-tools

#
# Paths and names
#
CONNTRACK_TOOLS_VERSION	:= 1.4.9
CONNTRACK_TOOLS_SHA256	:= c15afe488a8d408c9d6d61e97dbd19f3c591942f62c13df6453a961ca4231cae
CONNTRACK_TOOLS		:= conntrack-tools-$(CONNTRACK_TOOLS_VERSION)
CONNTRACK_TOOLS_SUFFIX	:= tar.xz
CONNTRACK_TOOLS_URL	:= https://ftp.netfilter.org/pub/conntrack-tools/$(CONNTRACK_TOOLS).$(CONNTRACK_TOOLS_SUFFIX)
CONNTRACK_TOOLS_SOURCE	:= $(SRCDIR)/$(CONNTRACK_TOOLS).$(CONNTRACK_TOOLS_SUFFIX)
CONNTRACK_TOOLS_DIR	:= $(BUILDDIR)/$(CONNTRACK_TOOLS)
CONNTRACK_TOOLS_LICENSE	:= GPL-2.0-or-later
CONNTRACK_TOOLS_LICENSE_FILES	:= \
	file://COPYING;md5=8ca43cbc842c2336e835926c2166c28b

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
CONNTRACK_TOOLS_CONF_TOOL	:= autoconf
CONNTRACK_TOOLS_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--$(call ptx/endis,PTXCONF_CONNTRACK_TOOLS_CTHELPER)-cthelper \
	--$(call ptx/endis,PTXCONF_CONNTRACK_TOOLS_CTTIMEOUT)-cttimeout \
	--$(call ptx/endis,PTXCONF_CONNTRACK_TOOLS_SYSTEMD)-systemd

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/conntrack-tools.targetinstall:
	@$(call targetinfo)

	@$(call install_init, conntrack-tools)
	@$(call install_fixup, conntrack-tools,PRIORITY,optional)
	@$(call install_fixup, conntrack-tools,SECTION,base)
	@$(call install_fixup, conntrack-tools,AUTHOR,"Ladislav Michl <ladis@triops.cz>")
	@$(call install_fixup, conntrack-tools,DESCRIPTION,"Netfilter connection tracking tools")

	@$(call install_copy, conntrack-tools, 0, 0, 0755, -, /usr/sbin/conntrack)

ifdef PTXCONF_CONNTRACK_TOOLS_CONNTRACKD
	@$(call install_copy, conntrack-tools, 0, 0, 0755, -, /usr/sbin/conntrackd)
endif

	@$(call install_finish, conntrack-tools)

	@$(call touch)

# vim: syntax=make
