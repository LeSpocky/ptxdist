# -*-makefile-*-
#
# Copyright (C) 2008 by Juergen Beisert
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SDPARM) += sdparm

#
# Paths and names
#
SDPARM_VERSION	:= 1.12
SDPARM_SHA256	:= e7f84247069da9a0c293963948d8aba8e5897a13e35e5476c8258acb7ca3a124
SDPARM		:= sdparm-$(SDPARM_VERSION)
SDPARM_SUFFIX	:= tgz
SDPARM_URL	:= http://sg.danny.cz/sg/p/$(SDPARM).$(SDPARM_SUFFIX)
SDPARM_SOURCE	:= $(SRCDIR)/$(SDPARM).$(SDPARM_SUFFIX)
SDPARM_DIR	:= $(BUILDDIR)/$(SDPARM)
SDPARM_LICENSE	:= BSD-2-Clause AND BSD-3-Clause
SDPARM_LICENSE_FILES	:= \
	file://COPYING;md5=ecab6c36b7ba82c675581dd0afde36f7 \
	file://BSD_LICENSE;md5=e78442656852f644cc485f0a24ee0b44 \
	file://src/sdparm.c;startline=1;endline=24;md5=a46ba29e5bc13d41083437fe74fb4414

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
# Note: regardless of --{en,dis}able-linuxbsg, --{en,dis}able-scsistrings,
# --{en,dis}able-nvme-supp and --{en,dis}able-fast-lebe configure always
# disables them, so leave them out to keep the defaults.
#
SDPARM_CONF_TOOL	:= autoconf
SDPARM_CONF_OPT		:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-debug \
	--disable-libsgutils

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/sdparm.targetinstall:
	@$(call targetinfo)

	@$(call install_init, sdparm)
	@$(call install_fixup, sdparm,PRIORITY,optional)
	@$(call install_fixup, sdparm,SECTION,base)
	@$(call install_fixup, sdparm,AUTHOR,"Juergen Beisert <j.beisert@pengutronix.de>")
	@$(call install_fixup, sdparm,DESCRIPTION,missing)

	@$(call install_copy, sdparm, 0, 0, 0755, -, /usr/bin/sdparm)

	@$(call install_finish, sdparm)

	@$(call touch)

# vim: syntax=make
