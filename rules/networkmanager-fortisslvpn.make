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
PACKAGES-$(PTXCONF_NETWORKMANAGER_FORTISSLVPN) += networkmanager-fortisslvpn

#
# Paths and names
#
NETWORKMANAGER_FORTISSLVPN_VERSION	:= 1.2.10
NETWORKMANAGER_FORTISSLVPN_MD5		:= 4a4bc3aae826623620c2090753a7acee
NETWORKMANAGER_FORTISSLVPN		:= NetworkManager-fortisslvpn-$(NETWORKMANAGER_FORTISSLVPN_VERSION)
NETWORKMANAGER_FORTISSLVPN_SUFFIX	:= tar.xz
NETWORKMANAGER_FORTISSLVPN_URL		:= $(call ptx/mirror, GNOME, NetworkManager-fortisslvpn/$(basename $(NETWORKMANAGER_FORTISSLVPN_VERSION))/$(NETWORKMANAGER_FORTISSLVPN).$(NETWORKMANAGER_FORTISSLVPN_SUFFIX))
NETWORKMANAGER_FORTISSLVPN_SOURCE	:= $(SRCDIR)/$(NETWORKMANAGER_FORTISSLVPN).$(NETWORKMANAGER_FORTISSLVPN_SUFFIX)
NETWORKMANAGER_FORTISSLVPN_DIR		:= $(BUILDDIR)/$(NETWORKMANAGER_FORTISSLVPN)
NETWORKMANAGER_FORTISSLVPN_LICENSE	:= GPL-2.0-or-later 
NETWORKMANAGER_FORTISSLVPN_LICENSE_FILES := \
	file://COPYING;md5=59530bdf33659b29e73d4adb9f9f6552 \
	file://src/nm-fortisslvpn-service.c;startline=6;endline=18;md5=dc133184bee887456e34cd179e2e9549

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
NETWORKMANAGER_FORTISSLVPN_CONF_TOOL	:= autoconf
NETWORKMANAGER_FORTISSLVPN_CONF_OPT	 = \
	$(CROSS_AUTOCONF_USR) \
	--enable-shared \
	--disable-static \
	--disable-absolute-paths \
	--disable-nls \
	--disable-rpath \
	--disable-more-warnings \
	--with-pppd-plugin-dir=$(PPP_SHARED_INST_PATH) \
	--without-gnome \
	--without-libnm-glib

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/networkmanager-fortisslvpn.targetinstall:
	@$(call targetinfo)

	@$(call install_init, networkmanager-fortisslvpn)
	@$(call install_fixup, networkmanager-fortisslvpn,PRIORITY,optional)
	@$(call install_fixup, networkmanager-fortisslvpn,SECTION,base)
	@$(call install_fixup, networkmanager-fortisslvpn,AUTHOR,"Ladislav Michl <ladis@linux-mips.org>")
	@$(call install_fixup, networkmanager-fortisslvpn,DESCRIPTION, "networkmanager-fortisslvpn")

	@$(call install_copy, networkmanager-fortisslvpn, 0, 0, 0644, -, \
		$(PPP_SHARED_INST_PATH)/nm-fortisslvpn-pppd-plugin.so)
	@$(call install_copy, networkmanager-fortisslvpn, 0, 0, 0644, -, \
		/usr/lib/NetworkManager/libnm-vpn-plugin-fortisslvpn.so)
	@$(call install_copy, networkmanager-fortisslvpn, 0, 0, 0644, -, \
		/usr/lib/NetworkManager/VPN/nm-fortisslvpn-service.name)
	@$(call install_tree, networkmanager-fortisslvpn, 0, 0, -, /usr/libexec)

	@$(call install_finish, networkmanager-fortisslvpn)

	@$(call touch)

# vim: syntax=make
