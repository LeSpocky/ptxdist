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
PAM_VERSION	:= 1.3.1
PAM_MD5		:= 558ff53b0fc0563ca97f79e911822165
PAM		:= Linux-PAM-$(PAM_VERSION)
PAM_SUFFIX	:= tar.xz
PAM_URL		:= https://github.com/linux-pam/linux-pam/releases/download/v$(PAM_VERSION)/$(PAM).$(PAM_SUFFIX)
PAM_SOURCE	:= $(SRCDIR)/$(PAM).$(PAM_SUFFIX)
PAM_DIR		:= $(BUILDDIR)/$(PAM)
PAM_LICENSE	:= BSD-3-Clause OR (GPL-2.0-or-later AND LGPL-2.0-or-later)
PAM_LICENSE_FILES := \
	file://Copyright;md5=7eb5c1bf854e8881005d673599ee74d3 \
	file://COPYING;md5=7eb5c1bf854e8881005d673599ee74d3

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
PAM_CONF_TOOL	:= autoconf
PAM_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-lckpwdf \
	--disable-cracklib \
	--disable-audit \
	--$(call ptx/endis, PTXCONF_PAM_DB)-db \
	--$(call ptx/endis, PTXCONF_PAM_NIS)-nis \
	--disable-selinux \
	--disable-regenerate-docu \
	--disable-nls \
	--disable-rpath

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

	@$(call install_alternative, pam, 0, 0, 0644, /etc/environment)
	@$(call install_alternative, pam, 0, 0, 0644, /etc/security/access.conf)
	@$(call install_alternative, pam, 0, 0, 0644, /etc/security/group.conf)
	@$(call install_alternative, pam, 0, 0, 0644, /etc/security/limits.conf)
	@$(call install_alternative, pam, 0, 0, 0644, /etc/security/namespace.conf)
	@$(call install_alternative, pam, 0, 0, 0755, /etc/security/namespace.init)
	@$(call install_alternative, pam, 0, 0, 0644, /etc/security/pam_env.conf)
	@$(call install_alternative, pam, 0, 0, 0644, /etc/security/time.conf)

	@$(call install_finish, pam)

	@$(call touch)

# vim: syntax=make
