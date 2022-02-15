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
PACKAGES-$(PTXCONF_WIREPLUMBER) += wireplumber

#
# Paths and names
#
WIREPLUMBER_VERSION		:= 0.4.8
WIREPLUMBER_MD5			:= a5a405f0f8e973df9d644a20a8c0620b
WIREPLUMBER			:= wireplumber-$(WIREPLUMBER_VERSION)
WIREPLUMBER_SUFFIX		:= tar.bz2
WIREPLUMBER_URL			:= https://gitlab.freedesktop.org/pipewire/wireplumber/-/archive/$(WIREPLUMBER_VERSION)/$(WIREPLUMBER).$(WIREPLUMBER_SUFFIX)
WIREPLUMBER_SOURCE		:= $(SRCDIR)/$(WIREPLUMBER).$(WIREPLUMBER_SUFFIX)
WIREPLUMBER_DIR			:= $(BUILDDIR)/$(WIREPLUMBER)
WIREPLUMBER_LICENSE		:= MIT
WIREPLUMBER_LICENSE_FILES	:= file://LICENSE;md5=17d1fe479cdec331eecbc65d26bc7e77

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# meson
#
WIREPLUMBER_CONF_TOOL	:= meson
WIREPLUMBER_CONF_OPT	:=  \
	$(CROSS_MESON_USR) \
	-Ddoc=disabled \
	-Delogind=disabled \
	-Dglib-supp= \
	-Dintrospection=disabled \
	-Dsystem-lua=true \
	-Dsystem-lua-version=auto \
	-Dsystemd=$(call ptx/endis,PTXCONF_WIREPLUMBER_SYSTEMD)d \
	-Dsystemd-system-service=$(call ptx/truefalse,PTXCONF_WIREPLUMBER_SYSTEMD_UNIT) \
	-Dsystemd-system-unit-dir=/usr/lib/systemd/system \
	-Dsystemd-user-service=$(call ptx/truefalse,PTXCONF_WIREPLUMBER_SYSTEMD_UNIT_USER) \
	-Dsystemd-user-unit-dir=/usr/lib/systemd/user \
	-Dtests=false

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

WIREPLUMBER_MODULES := \
	default-nodes \
	default-nodes-api \
	default-profile \
	device-activation \
	file-monitor-api \
	lua-scripting \
	metadata \
	mixer-api \
	portal-permissionstore \
	reserve-device \
	si-audio-adapter \
	si-audio-endpoint \
	si-node \
	si-standard-link

$(STATEDIR)/wireplumber.targetinstall:
	@$(call targetinfo)

	@$(call install_init, wireplumber)
	@$(call install_fixup, wireplumber,PRIORITY,optional)
	@$(call install_fixup, wireplumber,SECTION,base)
	@$(call install_fixup, wireplumber,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, wireplumber,DESCRIPTION,missing)

	@$(call install_lib, wireplumber, 0, 0, 644, libwireplumber-0.4)

	@$(call install_copy, wireplumber, 0, 0, 755, -, /usr/bin/wireplumber)
	@$(call install_copy, wireplumber, 0, 0, 755, -, /usr/bin/wpctl)
	@$(call install_copy, wireplumber, 0, 0, 755, -, /usr/bin/wpexec)

	@$(foreach module, $(WIREPLUMBER_MODULES), \
		$(call install_lib, wireplumber, 0, 0, 644, \
			wireplumber-0.4/libwireplumber-module-$(module))$(ptx/nl))
	@$(call install_tree, wireplumber, 0, 0, -, \
		/usr/share/wireplumber)

ifdef PTXCONF_WIREPLUMBER_SYSTEMD_UNIT
	@$(call install_alternative, wireplumber, 0, 0, 0644, \
		/usr/lib/systemd/system/wireplumber.service)
	@$(call install_link, wireplumber, ../wireplumber.service, \
		/usr/lib/systemd/system/pipewire.service.wants/wireplumber.service)
endif
ifdef PTXCONF_WIREPLUMBER_SYSTEMD_UNIT_USER
	@$(call install_alternative, wireplumber, 0, 0, 0644, \
		/usr/lib/systemd/user/wireplumber.service)
	@$(call install_link, wireplumber, ../wireplumber.service, \
		/usr/lib/systemd/user/pipewire.service.wants/wireplumber.service)
endif

	@$(call install_finish, wireplumber)

	@$(call touch)

# vim: syntax=make
