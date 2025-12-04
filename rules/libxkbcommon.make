# -*-makefile-*-
#
# Copyright (C) 2013 by Philipp Zabel <p.zabel@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBXKBCOMMON) += libxkbcommon

#
# Paths and names
#
LIBXKBCOMMON_VERSION	:= 1.13.1
LIBXKBCOMMON_MD5	:= 80f106737263eb7e19d6b4f7e0d82287
LIBXKBCOMMON		:= libxkbcommon-$(LIBXKBCOMMON_VERSION)
LIBXKBCOMMON_SUFFIX	:= tar.gz
LIBXKBCOMMON_URL	:= https://github.com/xkbcommon/libxkbcommon/archive/refs/tags/xkbcommon-$(LIBXKBCOMMON_VERSION).$(LIBXKBCOMMON_SUFFIX)
LIBXKBCOMMON_SOURCE	:= $(SRCDIR)/$(LIBXKBCOMMON).$(LIBXKBCOMMON_SUFFIX)
LIBXKBCOMMON_DIR	:= $(BUILDDIR)/$(LIBXKBCOMMON)
LIBXKBCOMMON_LICENSE	:= MIT AND MIT-open-group AND X11 AND HPND AND HPND-sell-variant
LIBXKBCOMMON_LICENSE_FILES := file://LICENSE;md5=70eff33050c59f900f5b83275dcf1211

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBXKBCOMMON_CONF_TOOL	:= meson
LIBXKBCOMMON_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Dxkb-config-root=$(XORG_DATADIR)/X11/xkb \
	-Dxkb-config-extra-path=/etc/xkb \
	-Dx-locale-root=$(XORG_DATADIR)/X11/locale \
	-Ddefault-rules='evdev' \
	-Ddefault-model='pc105' \
	-Ddefault-layout='us' \
	-Ddefault-variant='' \
	-Ddefault-options='' \
	-Denable-tools=false \
	-Denable-x11=$(call ptx/truefalse, PTXCONF_LIBXKBCOMMON_X11) \
	-Denable-docs=false \
	-Denable-cool-uris=false \
	-Denable-wayland=false \
	-Denable-xkbregistry=false \
	-Denable-bash-completion=true

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libxkbcommon.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libxkbcommon)
	@$(call install_fixup, libxkbcommon,PRIORITY,optional)
	@$(call install_fixup, libxkbcommon,SECTION,base)
	@$(call install_fixup, libxkbcommon,AUTHOR,"Philipp Zabel <p.zabel@pengutronix.de>")
	@$(call install_fixup, libxkbcommon,DESCRIPTION,missing)

	@$(call install_lib, libxkbcommon, 0, 0, 0644, libxkbcommon)
ifdef PTXCONF_LIBXKBCOMMON_X11
	@$(call install_lib, libxkbcommon, 0, 0, 0644, libxkbcommon-x11)
endif

	@$(call install_finish, libxkbcommon)

	@$(call touch)

# vim: syntax=make
