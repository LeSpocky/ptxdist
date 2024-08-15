# -*-makefile-*-
#
# Copyright (C) 2021 Philipp Zabel
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XWAYLAND) += xwayland

#
# Paths and names
#
XWAYLAND_VERSION	:= 24.1.2
XWAYLAND_MD5		:= 312c5cf17d1b147df1b787fd170958e1
XWAYLAND		:= xwayland-$(XWAYLAND_VERSION)
XWAYLAND_SUFFIX		:= tar.xz
XWAYLAND_URL		:= $(call ptx/mirror, XORG, individual/xserver/$(XWAYLAND).$(XWAYLAND_SUFFIX))
XWAYLAND_SOURCE		:= $(SRCDIR)/$(XWAYLAND).$(XWAYLAND_SUFFIX)
XWAYLAND_DIR		:= $(BUILDDIR)/$(XWAYLAND)
XWAYLAND_LICENSE	:= MIT
XWAYLAND_LICENSE_FILES	:= \
	file://COPYING;md5=5df87950af51ac2c5822094553ea1880

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# meson
#
XWAYLAND_CONF_TOOL	:= meson
XWAYLAND_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Dbuilder_addr=ptxdist@pengutronix.de \
	-Dbuilder_string=PTXdist \
	-Ddefault_font_path=$(subst $(space),$(comma),$(addprefix $(XORG_FONTDIR)/,$(XORG_FONT_DIRS))) \
	-Ddevel-docs=false \
	-Ddocs=false \
	-Ddocs-pdf=false \
	-Ddpms=false \
	-Ddri3=true \
	-Ddrm=true \
	-Ddtrace=false \
	-Dfontrootdir= \
	-Dglamor=$(call ptx/truefalse, PTXCONF_XWAYLAND_GLAMOR) \
	-Dglx=$(call ptx/truefalse, PTXCONF_XWAYLAND_EXT_GLX) \
	-Dinput_thread=auto \
	-Dipv6=$(call ptx/truefalse, PTXCONF_GLOBAL_IPV6) \
	-Dlibdecor=false \
	-Dlibunwind=false \
	-Dlisten_local=true \
	-Dlisten_tcp=false \
	-Dlisten_unix=true \
	-Dmitshm=$(call ptx/truefalse, PTXCONF_XWAYLAND_EXT_SHM) \
	-Dscreensaver=false \
	-Dsecure-rpc=false \
	-Dserverconfigdir= \
	-Dsha1=libnettle \
	-Dsystemd_notify=false \
	-Dvendor_name=PTXdist \
	-Dvendor_name_short=PTXdist \
	-Dvendor_web=https://www.ptxdist.org/ \
	-Dxace=true \
	-Dxcsecurity=false \
	-Dxdm-auth-1=false \
	-Dxdmcp=false \
	-Dxf86bigfont=false \
	-Dxinerama=false \
	-Dxkb_bin_dir=/usr/bin \
	-Dxkb_default_layout=us \
	-Dxkb_default_model=pc105 \
	-Dxkb_default_options= \
	-Dxkb_default_rules=evdev \
	-Dxkb_default_variant= \
	-Dxkb_dir=/usr/share/X11/xkb \
	-Dxkb_output_dir= \
	-Dxres=$(call ptx/truefalse, PTXCONF_XWAYLAND_EXT_XRES) \
	-Dxselinux=false \
	-Dxv=$(call ptx/truefalse, PTXCONF_XWAYLAND_EXT_XV) \
	-Dxvfb=false \
	-Dxwayland-path= \
	-Dxwayland_ei=false

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xwayland.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xwayland)
	@$(call install_fixup, xwayland,PRIORITY,optional)
	@$(call install_fixup, xwayland,SECTION,base)
	@$(call install_fixup, xwayland,AUTHOR,"Philipp Zabel <p.zabel@pengutronix.de>")
	@$(call install_fixup, xwayland,DESCRIPTION,missing)

	@$(call install_copy, xwayland, 0, 0, 0755, -, $(XORG_PREFIX)/bin/Xwayland)

	@$(call install_finish, xwayland)

	@$(call touch)

# vim: syntax=make
