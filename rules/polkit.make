# -*-makefile-*-
#
# Copyright (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_POLKIT) += polkit

#
# Paths and names
#
POLKIT_VERSION	:= 124
POLKIT_MD5	:= 97db655618e1483706fbc764787c7d6e
POLKIT		:= polkit-$(POLKIT_VERSION)
POLKIT_SUFFIX	:= tar.gz
POLKIT_URL	:= https://github.com/polkit-org/polkit/archive/refs/tags/$(POLKIT_VERSION).$(POLKIT_SUFFIX)
POLKIT_SOURCE	:= $(SRCDIR)/$(POLKIT).$(POLKIT_SUFFIX)
POLKIT_DIR	:= $(BUILDDIR)/$(POLKIT)
POLKIT_LICENSE	:= LGPL-2.0-or-later
POLKIT_LICENSE_FILES := \
	file://COPYING;md5=155db86cdbafa7532b41f390409283eb \
	file://src/polkitbackend/polkitd.c;startline=1;endline=20;md5=4a13d29c09d1ef6fa53a5c79ac2c6a28

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# prepare fails when systemdsystemunitdir is specified explicitly
POLKIT_CONF_ENV		:= \
	$(CROSS_ENV) \
	PTXDIST_PKG_CONFIG_VAR_NO_SYSROOT="systemdsystemunitdir sysusers_dir"

POLKIT_CONF_TOOL	:= meson
POLKIT_CONF_OPT		:= \
	$(CROSS_MESON_USR) \
	-Dauthfw=shadow \
	-Dexamples=false \
	-Dgtk_doc=false \
	-Dintrospection=false \
	-Djs_engine=duktape \
	-Dlibs-only=$(call ptx/falsetrue,PTXCONF_POLKIT_POLKITD) \
	-Dman=false \
	-Dos_type=redhat \
	-Dpam_include=no-pam \
	-Dpam_module_dir=/usr/lib/security \
	-Dpam_prefix=/usr/lib/pam.d \
	-Dpolkitd_uid=- \
	-Dpolkitd_user=polkitd \
	-Dsession_tracking=$(call ptx/ifdef,PTXCONF_POLKIT_SYSTEMD,libsystemd-login,ConsoleKit) \
	-Dsystemdsystemunitdir= \
	-Dtests=false

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/polkit.targetinstall:
	@$(call targetinfo)

	@$(call install_init, polkit)
	@$(call install_fixup, polkit,PRIORITY,optional)
	@$(call install_fixup, polkit,SECTION,base)
	@$(call install_fixup, polkit,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, polkit,DESCRIPTION,missing)

	@$(call install_lib, polkit, 0, 0, 0644, libpolkit-gobject-1)
	@$(call install_lib, polkit, 0, 0, 0644, libpolkit-agent-1)

ifdef PTXCONF_POLKIT_POLKITD
	@$(call install_copy, polkit, 0, 0, 0644, -, \
		/usr/share/dbus-1/system.d/org.freedesktop.PolicyKit1.conf)
	@$(call install_copy, polkit, 0, 0, 0644, -, \
		/usr/share/dbus-1/system-services/org.freedesktop.PolicyKit1.service)

	@$(call install_copy, polkit, 0, 0, 0644, -, \
		/usr/share/polkit-1/actions/org.freedesktop.policykit.policy)
	@$(call install_alternative, polkit, 0, 0, 0644, \
		/usr/share/polkit-1/rules.d/50-default.rules)

ifdef PTXCONF_POLKIT_SYSTEMD
	@$(call install_copy, polkit, 0, 0, 0644, -, \
		/usr/lib/systemd/system/polkit.service)
endif

	@$(call install_copy, polkit, 0, 0, 0755, -, /usr/bin/pkaction)
	@$(call install_copy, polkit, 0, 0, 0755, -, /usr/bin/pkcheck)

	@$(call install_copy, polkit, 0, 0, 0755, -, /usr/lib/polkit-1/polkitd)

ifdef PTXCONF_POLKIT_PKEXEC
	@$(call install_copy, polkit, 0, 0, 4755, -, /usr/bin/pkexec)
endif
	@$(call install_copy, polkit, 0, 0, 4755, -, \
		/usr/lib/polkit-1/polkit-agent-helper-1)
endif

	@$(call install_finish, polkit)

	@$(call touch)

# vim: syntax=make
