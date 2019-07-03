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
NETWORKMANAGER_OPENVPN_VERSION	:= 1.8.4
NETWORKMANAGER_OPENVPN_MD5	:= db5bee5160da14ee76e9f8cf287ab9ec
NETWORKMANAGER_OPENVPN		:= NetworkManager-openvpn-$(NETWORKMANAGER_OPENVPN_VERSION)
NETWORKMANAGER_OPENVPN_SUFFIX	:= tar.xz
NETWORKMANAGER_OPENVPN_URL	:= http://ftp.gnome.org/pub/GNOME/sources/NetworkManager-openvpn/1.8/$(NETWORKMANAGER_OPENVPN).$(NETWORKMANAGER_OPENVPN_SUFFIX)
NETWORKMANAGER_OPENVPN_SOURCE	:= $(SRCDIR)/$(NETWORKMANAGER_OPENVPN).$(NETWORKMANAGER_OPENVPN_SUFFIX)
NETWORKMANAGER_OPENVPN_DIR	:= $(BUILDDIR)/$(NETWORKMANAGER_OPENVPN)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
NETWORKMANAGER_OPENVPN_CONF_TOOL := autoconf
NETWORKMANAGER_OPENVPN_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--enable-shared \
	--disable-static \
	--disable-absolute-paths \
	--disable-ld-gc \
	--disable-lto \
	--disable-nls \
	--enable-more-warnings \
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

	@$(call install_copy, networkmanager-openvpn, 0, 0, 0644, -, /etc/dbus-1/system.d/nm-openvpn-service.conf)
	@$(call install_copy, networkmanager-openvpn, 0, 0, 0644, -, /usr/lib/NetworkManager/VPN/nm-openvpn-service.name)

	@$(call install_tree, networkmanager-openvpn, 0, 0, -, /usr/libexec/)

	@$(call install_finish, networkmanager-openvpn)

	@$(call touch)

# vim: syntax=make
