# -*-makefile-*-
#
# Copyright (C) 2026 by Ladislav Michl <ladis@triops.cz>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_AUDIT) += audit

#
# Paths and names
#
AUDIT_VERSION	:= 4.2.1
AUDIT_SHA256	:= 42876d195ee2ded19e5f72d7664096eee314928aa36ad346719ba5b25818fc84
AUDIT		:= audit-userspace-$(AUDIT_VERSION)
AUDIT_SUFFIX	:= tar.gz
AUDIT_URL	:= https://github.com/linux-audit/audit-userspace/archive/refs/tags/v$(AUDIT_VERSION).$(AUDIT_SUFFIX)
AUDIT_SOURCE	:= $(SRCDIR)/$(AUDIT).$(AUDIT_SUFFIX)
AUDIT_DIR	:= $(BUILDDIR)/$(AUDIT)
AUDIT_LICENSE	:= GPL-2.0-or-later AND LGPL-2.1-or-later
AUDIT_LICENSE_FILES	:= \
	file://COPYING;md5=94d55d512a9ba36caa9b7df079bae19f \
	file://COPYING.LIB;md5=e3eda01d9815f8d24aae2dbd89b68b06
AUDIT_CVE_PRODUCT	:= audit-userspace_project:audit-userspace

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
AUDIT_CONF_TOOL	:= autoconf
AUDIT_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--runstatedir=/run \
	--disable-listener \
	--disable-zos-remote \
	--disable-legacy-actions \
	--disable-gssapi-krb5 \
	--disable-tls \
	--disable-experimental \
	--without-python3 \
	--without-golang \
	--without-asan \
	--$(call ptx/wwo, PTXCONF_ARCH_ARM)-arm \
	--$(call ptx/wwo, PTXCONF_ARCH_ARM64)-aarch64 \
	--$(call ptx/wwo, PTXCONF_ARCH_RISCV)-riscv \
	--without-apparmor \
	--without-libwrap \
	--without-io_uring \
	--without-nftables \
	--with-libcap-ng

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/audit.targetinstall:
	@$(call targetinfo)

	@$(call install_init, audit)
	@$(call install_fixup, audit,PRIORITY,optional)
	@$(call install_fixup, audit,SECTION,base)
	@$(call install_fixup, audit,AUTHOR,"Ladislav Michl <ladis@triops.cz>")
	@$(call install_fixup, audit,DESCRIPTION,missing)

	@$(call install_lib, audit, 0, 0, 0644, libaudit)
	@$(call install_lib, audit, 0, 0, 0644, libauparse)
	@$(call install_alternative, audit, 0, 0, 0640, /etc/libaudit.conf)

ifdef PTXCONF_AUDIT_TOOLS
	@$(call install_copy, audit, 0, 0, 0755, -, /usr/sbin/auditd)
	@$(call install_copy, audit, 0, 0, 0755, -, /usr/sbin/auditctl)
	@$(call install_copy, audit, 0, 0, 0755, -, /usr/sbin/augenrules)
	@$(call install_copy, audit, 0, 0, 0755, -, /usr/sbin/aureport)
	@$(call install_copy, audit, 0, 0, 0755, -, /usr/sbin/ausearch)
	@$(call install_alternative, audit, 0, 0, 0640, /etc/audit/auditd.conf)
	@$(call install_alternative, audit, 0, 0, 0640, /etc/audit/audit-stop.rules)
	@$(call install_copy, audit, 0, 0, 0750, /etc/audit/rules.d)
	@$(call install_copy, audit, 0, 0, 0700, /var/log/audit)

ifdef PTXCONF_INITMETHOD_SYSTEMD
	@$(call install_alternative, audit, 0, 0, 0644, /usr/lib/systemd/system/auditd.service)
	@$(call install_link, audit, ../auditd.service, \
		/usr/lib/systemd/system/multi-user.target.wants/auditd.service)
	@$(call install_alternative, audit, 0, 0, 0644, /usr/lib/systemd/system/audit-rules.service)
	@$(call install_link, audit, ../audit-rules.service, \
		/usr/lib/systemd/system/multi-user.target.wants/audit-rules.service)
	@$(call install_alternative, audit, 0, 0, 0640, /usr/lib/tmpfiles.d/audit.conf)
endif
endif

	@$(call install_finish, audit)

	@$(call touch)

# vim: syntax=make
