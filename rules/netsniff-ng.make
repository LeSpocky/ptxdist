# -*-makefile-*-
#
# Copyright (C) 2021 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_NETSNIFF_NG) += netsniff-ng

#
# Paths and names
#
NETSNIFF_NG_VERSION		:= 0.6.8
NETSNIFF_NG_MD5			:= c5b280548ee34e9800530bb16892ff18 2d0ad99695db0b74047a8ef463283986
NETSNIFF_NG			:= netsniff-ng-$(NETSNIFF_NG_VERSION)
NETSNIFF_NG_SUFFIX		:= tar.gz
NETSNIFF_NG_URL			:= https://github.com/netsniff-ng/netsniff-ng/archive/refs/tags/v$(NETSNIFF_NG_VERSION).$(NETSNIFF_NG_SUFFIX)
NETSNIFF_NG_SOURCE		:= $(SRCDIR)/$(NETSNIFF_NG).$(NETSNIFF_NG_SUFFIX)
NETSNIFF_NG_DIR			:= $(BUILDDIR)/$(NETSNIFF_NG)
NETSNIFF_NG_LICENSE		:= GPL-2.0-only
NETSNIFF_NG_LICENSE_FILES	:= file://COPYING;md5=9dd40dfb621eed702c0775577fbb7011

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

NETSNIFF_NG_CONF_ENV	:= \
	$(CROSS_ENV) \
	TERM=
	HARDENING=1

#
# not really autoconf, there are no options the keep the default
#
NETSNIFF_NG_CONF_TOOL	:= autoconf
NETSNIFF_NG_CONF_OPT	:=  \
	--prefix=/usr \
	--sysconfdir=/etc \
	$(call ptx/ifdef, PTXCONF_NETSNIFF_NG_LIBNL,,--disable-libnl) \
	--disable-geoip \
	$(call ptx/ifdef, PTXCONF_NETSNIFF_NG_ZLIB,,--disable-zlib)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

NETSNIFF_NG_MAKE_ENV	:= \
	$(NETSNIFF_NG_CONF_ENV)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

NETSNIFF_NG_TOOLS-$(PTXCONF_NETSNIFF_NG_ASTRACEROUTE)	+= astraceroute
NETSNIFF_NG_TOOLS-$(PTXCONF_NETSNIFF_NG_BPFC)		+= bpfc
NETSNIFF_NG_TOOLS-$(PTXCONF_NETSNIFF_NG_CURVETUN)	+= curvetun
NETSNIFF_NG_TOOLS-$(PTXCONF_NETSNIFF_NG_FLOWTOP)	+= flowtop
NETSNIFF_NG_TOOLS-$(PTXCONF_NETSNIFF_NG_IFPPS)		+= ifpps
NETSNIFF_NG_TOOLS-$(PTXCONF_NETSNIFF_NG_MAUSEZAHN)	+= mausezahn
NETSNIFF_NG_TOOLS-$(PTXCONF_NETSNIFF_NG_NETSNIFF_NG)	+= netsniff-ng
NETSNIFF_NG_TOOLS-$(PTXCONF_NETSNIFF_NG_TRAFGEN)	+= trafgen

$(STATEDIR)/netsniff-ng.targetinstall:
	@$(call targetinfo)

	@$(call install_init, netsniff-ng)
	@$(call install_fixup, netsniff-ng,PRIORITY,optional)
	@$(call install_fixup, netsniff-ng,SECTION,base)
	@$(call install_fixup, netsniff-ng,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, netsniff-ng,DESCRIPTION,missing)

	@$(foreach tool, $(NETSNIFF_NG_TOOLS-y), \
		$(call install_copy, netsniff-ng, 0, 0, 0755, -, \
			/usr/sbin/$(tool))$(ptx/nl))

	@$(call install_finish, netsniff-ng)

	@$(call touch)

# vim: syntax=make
