# -*-makefile-*-
#
# Copyright (C) 2020 by Lucas Stach <l.stach@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_NVMETCLI) += nvmetcli

#
# Paths and names
#
NVMETCLI_VERSION	:= 0.7
NVMETCLI_MD5		:= eed70ef32d327c814345178dd35d088b
NVMETCLI		:= nvmetcli-$(NVMETCLI_VERSION)
NVMETCLI_SUFFIX		:= tar.gz
NVMETCLI_URL		:= ftp://ftp.infradead.org/pub/nvmetcli/$(NVMETCLI).$(NVMETCLI_SUFFIX)
NVMETCLI_SOURCE		:= $(SRCDIR)/$(NVMETCLI).$(NVMETCLI_SUFFIX)
NVMETCLI_DIR		:= $(BUILDDIR)/$(NVMETCLI)
NVMETCLI_LICENSE	:= Apache-2.0
NVMETCLI_LICENSE_FILES	:= file://COPYING;md5=1dece7821bf3fd70fe1309eaa37d52a2

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# python3
#
NVMETCLI_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/nvmetcli.install:
	@$(call targetinfo)
	@$(call world/install, NVMETCLI)

ifdef PTXCONF_NVMETCLI_SYSTEMD_SERVICE
	@install -v -D -m644 $(NVMETCLI_DIR)/nvmet.service \
		$(NVMETCLI_PKGDIR)/usr/lib/systemd/system/nvmet.service
endif

	@$(call touch)


# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/nvmetcli.targetinstall:
	@$(call targetinfo)

	@$(call install_init, nvmetcli)
	@$(call install_fixup, nvmetcli,PRIORITY,optional)
	@$(call install_fixup, nvmetcli,SECTION,base)
	@$(call install_fixup, nvmetcli,AUTHOR,"Lucas Stach <l.stach@pengutronix.de>")
	@$(call install_fixup, nvmetcli,DESCRIPTION,missing)

	@$(call install_glob, nvmetcli, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES)/nvmet,, *.py)
	@$(call install_copy, nvmetcli, 0, 0, 0755, -, /usr/sbin/nvmetcli)

ifdef PTXCONF_NVMETCLI_SYSTEMD_SERVICE
	@$(call install_copy, nvmetcli, 0, 0, 0644, -, /usr/lib/systemd/system/nvmet.service)
	@$(call install_link, nvmetcli, ../nvmet.service, \
		/usr/lib/systemd/system/multi-user.target.wants/nvmet.service)

	@$(call install_alternative, nvmetcli, 0, 0, 0644, /etc/nvmet/config.json)
endif

	@$(call install_finish, nvmetcli)

	@$(call touch)

# vim: syntax=make
