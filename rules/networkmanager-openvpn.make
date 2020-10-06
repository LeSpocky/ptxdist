# -*-makefile-*-
#
# Copyright (C) 2016 by Ladislav Michl <ladis@linux-mips.org>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_NETWORKMANAGER_OPENVPN) += networkmanager-openvpn

#
# Paths and names
#
NETWORKMANAGER_OPENVPN_VERSION	:= 1.8.12
NETWORKMANAGER_OPENVPN_MD5	:= e8b1210011ece18d0278310fbff45af5
NETWORKMANAGER_OPENVPN		:= NetworkManager-openvpn-$(NETWORKMANAGER_OPENVPN_VERSION)
NETWORKMANAGER_OPENVPN_SUFFIX	:= tar.xz
NETWORKMANAGER_OPENVPN_URL	:= $(call ptx/mirror, GNOME, NetworkManager-openvpn/$(basename $(NETWORKMANAGER_OPENVPN_VERSION))/$(NETWORKMANAGER_OPENVPN).$(NETWORKMANAGER_OPENVPN_SUFFIX))
NETWORKMANAGER_OPENVPN_SOURCE	:= $(SRCDIR)/$(NETWORKMANAGER_OPENVPN).$(NETWORKMANAGER_OPENVPN_SUFFIX)
NETWORKMANAGER_OPENVPN_DIR	:= $(BUILDDIR)/$(NETWORKMANAGER_OPENVPN)
NETWORKMANAGER_OPENVPN_LICENSE	:= GPL-2.0-or-later
NETWORKMANAGER_OPENVPN_LICENSE_FILES := \
	file://COPYING;md5=100d5a599bead70ddcd70dcd73f2e29c \
	file://src/nm-openvpn-service.c;startline=4;endline=16;md5=dc133184bee887456e34cd179e2e9549

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
NETWORKMANAGER_OPENVPN_CONF_TOOL	:= autoconf
NETWORKMANAGER_OPENVPN_CONF_OPT		:= \
	$(CROSS_AUTOCONF_USR) \
	--enable-shared \
	--disable-static \
	--disable-absolute-paths \
	--disable-ld-gc \
	--disable-lto \
	--disable-nls \
	--disable-more-warnings \
	--without-gnome \
	--without-libnm-glib

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/networkmanager-openvpn.targetinstall:
	@$(call targetinfo)

	@$(call install_init, networkmanager-openvpn)
	@$(call install_fixup, networkmanager-openvpn,PRIORITY,optional)
	@$(call install_fixup, networkmanager-openvpn,SECTION,base)
	@$(call install_fixup, networkmanager-openvpn,AUTHOR,"Ladislav Michl <ladis@linux-mips.org>")
	@$(call install_fixup, networkmanager-openvpn,DESCRIPTION, "networkmanager-openvpn")

	@$(call install_copy, networkmanager-openvpn, 0, 0, 0644, -, \
		/usr/lib/NetworkManager/libnm-vpn-plugin-openvpn.so)
	@$(call install_copy, networkmanager-openvpn, 0, 0, 0644, -, \
		/usr/lib/NetworkManager/VPN/nm-openvpn-service.name)
	@$(call install_tree, networkmanager-openvpn, 0, 0, -, /usr/libexec)
	@$(call install_copy, networkmanager-openvpn, 0, 0, 0644, -, \
		/usr/share/dbus-1/system.d/nm-openvpn-service.conf)

	@$(call install_finish, networkmanager-openvpn)

	@$(call touch)

# vim: syntax=make
