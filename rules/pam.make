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
PACKAGES-$(PTXCONF_PAM) += pam

#
# Paths and names
#
PAM_VERSION	:= 1.7.3
PAM_SHA256	:= 29c2a93f819a62ba981f695b03fe00550b49ce7ae5c5342edaaf860687fbb1a0
PAM		:= Linux-PAM-$(PAM_VERSION)
PAM_SUFFIX	:= tar.gz
PAM_URL		:= https://github.com/linux-pam/linux-pam/archive/refs/tags/v$(PAM_VERSION).$(PAM_SUFFIX)
PAM_SOURCE	:= $(SRCDIR)/$(PAM).$(PAM_SUFFIX)
PAM_DIR		:= $(BUILDDIR)/$(PAM)
PAM_LICENSE	:= BSD-3-Clause OR (GPL-2.0-or-later AND LGPL-2.0-or-later)
PAM_LICENSE_FILES := \
	file://Copyright;md5=7eb5c1bf854e8881005d673599ee74d3 \
	file://COPYING;md5=7eb5c1bf854e8881005d673599ee74d3

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PAM_CONF_TOOL	:= meson
PAM_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Daudit=disabled \
	-Ddocs=disabled \
	-Deconf=disabled \
	-Delogind=disabled \
	-Dexamples=false \
	-Di18n=disabled \
	-Dlckpwdf=false \
	-Dlogind=disabled \
	-Dnis=$(call ptx/endis, PTXCONF_PAM_NIS)d \
	-Dopenssl=disabled \
	-Dpam-debug=false \
	-Dpam_lastlog=disabled \
	-Dpam_unix=enabled \
	-Dpam_unix-try-getspnam=false \
	-Dpam_userdb=$(call ptx/endis, PTXCONF_PAM_DB)d \
	-Dpamlocking=false \
	-Dpwaccess=disabled \
	-Dread-both-confs=false \
	-Dselinux=disabled \
	-Duidmin=1000 \
	-Dusergroups=false \
	-Dxtests=false

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/pam.targetinstall:
	@$(call targetinfo)

	@$(call install_init, pam)
	@$(call install_fixup, pam,PRIORITY,optional)
	@$(call install_fixup, pam,SECTION,base)
	@$(call install_fixup, pam,AUTHOR,"Ladislav Michl <ladis@linux-mips.org>")
	@$(call install_fixup, pam,DESCRIPTION,"Pluggable Authentication Modules for Linux")

	@$(call install_lib, pam, 0, 0, 0644, libpamc)
	@$(call install_lib, pam, 0, 0, 0644, libpam_misc)
	@$(call install_lib, pam, 0, 0, 0644, libpam)

	@$(call install_tree, pam, 0, 0, -, /usr/lib/security)

	@$(call install_alternative, pam, 0, 0, 0644, /usr/share/pam/environment)
	@$(call install_alternative, pam, 0, 0, 0644, /usr/share/pam/security/access.conf)
	@$(call install_alternative, pam, 0, 0, 0644, /usr/share/pam/security/group.conf)
	@$(call install_alternative, pam, 0, 0, 0644, /usr/share/pam/security/limits.conf)
	@$(call install_alternative, pam, 0, 0, 0644, /usr/share/pam/security/namespace.conf)
	@$(call install_alternative, pam, 0, 0, 0755, /usr/share/pam/security/namespace.init)
	@$(call install_alternative, pam, 0, 0, 0644, /usr/share/pam/security/pam_env.conf)
	@$(call install_alternative, pam, 0, 0, 0644, /usr/share/pam/security/time.conf)

	@$(call install_alternative, pam, 0, 0, 0755, /usr/sbin/mkhomedir_helper)
	@$(call install_alternative, pam, 0, 0, 0755, /usr/sbin/unix_chkpwd)

	@$(call install_finish, pam)

	@$(call touch)

# vim: syntax=make
