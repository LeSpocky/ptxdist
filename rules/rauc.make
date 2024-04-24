# -*-makefile-*-
#
# Copyright (C) 2015-2024 by Enrico Joerns <e.joerns@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_RAUC) += rauc

#
# Paths and names
#
RAUC_VERSION		:= 1.11.3
RAUC_MD5		:= f6822268230e50efb6b2fe3a4db28e2b
RAUC			:= rauc-$(RAUC_VERSION)
RAUC_SUFFIX		:= tar.xz
RAUC_URL		:= https://github.com/rauc/rauc/releases/download/v$(RAUC_VERSION)/$(RAUC).$(RAUC_SUFFIX)
RAUC_SOURCE		:= $(SRCDIR)/$(RAUC).$(RAUC_SUFFIX)
RAUC_DIR		:= $(BUILDDIR)/$(RAUC)
RAUC_LICENSE		:= LGPL-2.1-or-later
RAUC_LICENSE_FILES	:= \
	file://README.rst;startline=281;endline=294;md5=d98e15259a1a004b59d4701b3d49cf44 \
	file://COPYING;md5=4fbd65380cdd255951079008b364516c

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# meson
#
RAUC_CONF_TOOL	:= meson
RAUC_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Dcreate=$(call ptx/truefalse,PTXCONF_RAUC_CREATE) \
	-Ddbusinterfacesdir=/usr/share/dbus-1/interfaces \
	-Ddbuspolicydir=/usr/share/dbus-1/system.d \
	-Ddbussystemservicedir=/usr/share/dbus-1/system-services \
	-Dfuzzing=false \
	-Dgpt=$(call ptx/endis,PTXCONF_RAUC_GPT)d \
	-Dhtmldocs=false \
	-Djson=$(call ptx/endis,PTXCONF_RAUC_JSON)d \
	-Dnetwork=$(call ptx/truefalse,PTXCONF_RAUC_NETWORK) \
	-Dservice=$(call ptx/truefalse,PTXCONF_RAUC_SERVICE) \
	-Dstreaming=$(call ptx/truefalse,PTXCONF_RAUC_STREAMING) \
	-Dstreaming_user=nobody \
	-Dsystemdunitdir=/usr/lib/systemd/system \
	-Dtests=false

$(STATEDIR)/rauc.prepare:
	@$(call targetinfo)
	@keyfile="$(call ptx/in-platformconfigdir, config/rauc/rauc.key.pem)"; \
		test ! -e "$${keyfile}" || \
		ptxd_bailout "Legacy RAUC keyring exists at $${keyfile}!" \
			"Please use the signing provider infrastructure instead, as described in:" \
			"https://www.ptxdist.org/doc/dev_code_signing.html"
	@$(call world/prepare, RAUC)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/rauc.targetinstall:
	@$(call targetinfo)

	@$(call install_init, rauc)
	@$(call install_fixup, rauc,PRIORITY,optional)
	@$(call install_fixup, rauc,SECTION,base)
	@$(call install_fixup, rauc,AUTHOR,"Enrico Joerns <e.joerns@pengutronix.de>")
	@$(call install_fixup, rauc,DESCRIPTION,missing)

	@$(call install_copy, rauc, 0, 0, 0755, -, /usr/bin/rauc)

ifdef PTXCONF_RAUC_CONFIGURATION
	@$(call install_alternative, rauc, 0, 0, 0644, /etc/rauc/system.conf)
	@$(call install_replace, rauc, /etc/rauc/system.conf, \
		@RAUC_BUNDLE_COMPATIBLE@, \
		"$(call remove_quotes,$(PTXCONF_RAUC_COMPATIBLE))")
	@$(call install_copy, rauc, 0, 0, 0644, $(shell cs_get_ca update), \
		/etc/rauc/ca.cert.pem)
endif

ifdef PTXCONF_RAUC_SERVICE
	@$(call install_copy, rauc, 0, 0, 0644, -, \
		/usr/share/dbus-1/system-services/de.pengutronix.rauc.service)
	@$(call install_copy, rauc, 0, 0, 0644, -, \
		/usr/share/dbus-1/system.d/de.pengutronix.rauc.conf)

ifdef PTXCONF_INITMETHOD_SYSTEMD
	@$(call install_alternative, rauc, 0, 0, 0644, \
		/usr/lib/systemd/system/rauc.service)

	@$(call install_alternative, rauc, 0, 0, 0644, \
		/usr/lib/systemd/system/rauc-mark-good.service)
	@$(call install_link, rauc, ../rauc-mark-good.service, \
		/usr/lib/systemd/system/multi-user.target.wants/rauc-mark-good.service)
else
	@$(call install_copy, rauc, 0, 0, 0755, -, \
		/usr/libexec/rauc-service.sh)
endif
endif

	@$(call install_finish, rauc)

	@$(call touch)

# vim: syntax=make
