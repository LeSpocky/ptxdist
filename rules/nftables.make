# -*-makefile-*-
#
# Copyright (C) 2016 by Andreas Geisenhainer <andreas.geisenhainer@atsonline.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_NFTABLES) += nftables

#
# Paths and names
#
NFTABLES_VERSION	:= 1.1.0
NFTABLES_MD5		:= 3082f7c9ad4b8dd1c9fb260ad82d1472
NFTABLES		:= nftables-$(NFTABLES_VERSION)
NFTABLES_SUFFIX		:= tar.xz
NFTABLES_URL		:= http://ftp.netfilter.org/pub/nftables/$(NFTABLES).$(NFTABLES_SUFFIX)
NFTABLES_SOURCE		:= $(SRCDIR)/$(NFTABLES).$(NFTABLES_SUFFIX)
NFTABLES_DIR		:= $(BUILDDIR)/$(NFTABLES)
NFTABLES_LICENSE	:= GPL-2.0-only AND GPL-2.0-or-later
NFTABLES_LICENSE_FILES	:= file://COPYING;md5=81ec33bb3e47b460fc993ac768c74b62

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
NFTABLES_CONF_TOOL	:= autoconf
NFTABLES_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--$(call ptx/endis, PTXCONF_NFTABLES_DEBUG)-debug \
	--disable-man-doc \
	--$(call ptx/wwo, PTXCONF_NFTABLES_MGMP)-mini-gmp \
	--without-cli \
	--without-xtables \
	--without-json

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/nftables.targetinstall:
	@$(call targetinfo)

	@$(call install_init, nftables)
	@$(call install_fixup, nftables,PRIORITY,optional)
	@$(call install_fixup, nftables,SECTION,base)
	@$(call install_fixup, nftables,AUTHOR,"Andreas Geisenhainer <andreas.geisenhainer@atsonline.de")
	@$(call install_fixup, nftables,DESCRIPTION,missing)

	@$(call install_copy, nftables, 0, 0, 0755, -, /usr/sbin/nft)
	@$(call install_alternative, nftables, 0, 0, 0755, /etc/nftables.conf)
	@$(call install_lib, nftables, 0, 0, 0644, libnftables)

ifdef PTXCONF_NFTABLES_STARTSCRIPT
	@$(call install_alternative, nftables, 0, 0, 0755, /etc/init.d/nftables)

ifneq ($(call remove_quotes,$(PTXCONF_NFTABLES_BBINIT_LINK)),)
	@$(call install_link, nftables, ../init.d/nftables, \
		/etc/rc.d/$(PTXCONF_NFTABLES_BBINIT_LINK))
endif
endif

ifdef PTXCONF_NFTABLES_SYSTEMD_UNIT
	@$(call install_alternative, nftables, 0, 0, 0644, /usr/lib/systemd/system/nftables.service)
	@$(call install_link, nftables, ../nftables.service, \
		/usr/lib/systemd/system/multi-user.target.wants/nftables.service)
endif

	@$(call install_finish, nftables)

	@$(call touch)

# vim: syntax=make
