# -*-makefile-*-
#
# Copyright (C) 2014 by Markus Pargmann <mpa@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ALFRED) += alfred

#
# Paths and names
#
ALFRED_VERSION	:= 2017.1
ALFRED_SHA256	:= f8d3a8058d076f6b7686696f6117de1780a2905d827dfa7faa3c2c0b24c2dfb0
ALFRED		:= alfred-$(ALFRED_VERSION)
ALFRED_SUFFIX	:= tar.gz
ALFRED_URL	:= https://downloads.open-mesh.org/batman/stable/sources/alfred/$(ALFRED).$(ALFRED_SUFFIX)
ALFRED_SOURCE	:= $(SRCDIR)/$(ALFRED).$(ALFRED_SUFFIX)
ALFRED_DIR	:= $(BUILDDIR)/$(ALFRED)
ALFRED_LICENSE	:= GPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ALFRED_CONF_TOOL	:= NO

ALFRED_MAKE_ENV		:= \
	$(CROSS_ENV)

# let's build with libcap support and drop privileges
ALFRED_MAKE_OPT		:= \
	CONFIG_ALFRED_GPSD=n \
	CONFIG_ALFRED_CAPABILITIES=y

ALFRED_INSTALL_OPT	:= \
	$(ALFRED_MAKE_OPT) \
	PREFIX=/usr \
	install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/alfred.targetinstall:
	@$(call targetinfo)

	@$(call install_init, alfred)
	@$(call install_fixup, alfred,PRIORITY,optional)
	@$(call install_fixup, alfred,SECTION,base)
	@$(call install_fixup, alfred,AUTHOR,"Markus Pargmann <mpa@pengutronix.de>")
	@$(call install_fixup, alfred,DESCRIPTION,missing)

	@$(call install_copy, alfred, 0, 0, 0755, -, /usr/sbin/alfred)
	@$(call install_copy, alfred, 0, 0, 0755, -, /usr/sbin/batadv-vis)

ifdef PTXCONF_ALFRED_SYSTEMD_SERVICE
	@$(call install_alternative, alfred, 0, 0, 0644, /usr/lib/systemd/system/alfred@.service)
	@$(call install_alternative, alfred, 0, 0, 0644, /usr/lib/systemd/system/batadv-vis@.service)
ifneq ($(PTXCONF_ALFRED_SYSTEMD_SERVICE_ALFRED_INTF),"")
	@$(call install_link, alfred, ../alfred@.service, \
	/usr/lib/systemd/system/multi-user.target.wants/alfred@$(PTXCONF_ALFRED_SYSTEMD_SERVICE_ALFRED_INTF).service)
endif
ifneq ($(PTXCONF_ALFRED_SYSTEMD_SERVICE_BATADVVIS_INTF),"")
	@$(call install_link, alfred, ../batadv-vis@.service, \
	/usr/lib/systemd/system/multi-user.target.wants/batadv-vis@$(PTXCONF_ALFRED_SYSTEMD_SERVICE_BATADVVIS_INTF).service)
endif
endif

	@$(call install_finish, alfred)

	@$(call touch)

# vim: syntax=make
