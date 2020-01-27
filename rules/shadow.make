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
PACKAGES-$(PTXCONF_SHADOW) += shadow

#
# Paths and names
#
SHADOW_VERSION	:= 4.8.1
SHADOW_MD5	:= 4b05eff8a427cf50e615bda324b5bc45
SHADOW		:= shadow-$(SHADOW_VERSION)
SHADOW_SUFFIX	:= tar.xz
SHADOW_URL	:= https://github.com/shadow-maint/shadow/releases/download/$(SHADOW_VERSION)/$(SHADOW).$(SHADOW_SUFFIX)
SHADOW_SOURCE	:= $(SRCDIR)/$(SHADOW).$(SHADOW_SUFFIX)
SHADOW_DIR	:= $(BUILDDIR)/$(SHADOW)
SHADOW_LICENSE	:= BSD-3-Clause

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
SHADOW_CONF_TOOL	:= autoconf
SHADOW_CONF_OPT		:= \
	$(CROSS_AUTOCONF_USR) \
	--bindir=/usr/bin \
	--sbindir=/usr/sbin \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--enable-shadowgrp \
	--disable-man \
	--$(call ptx/endis, PTXCONF_GLOBAL_PAM)-account-tools-setuid \
	--disable-utmpx \
	--enable-subordinate-ids \
	--disable-nls \
	--disable-rpath \
	--without-audit \
	--$(call ptx/wwo, PTXCONF_GLOBAL_PAM)-libpam \
	--without-btrfs \
	--$(call ptx/wwo, PTXCONF_GLOBAL_SELINUX)-selinux \
	--without-acl \
  	--without-attr \
	--without-skey \
	--without-tcb \
	--without-libcrack \
	--with-sha-crypt \
	--without-nscd \
	--without-sssd \
	--with-su \
	--without-fcaps

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

SHADOW_ADMIN_BIN_PROGS	:= \
	chage chfn chsh expiry gpasswd newgidmap newgrp newuidmap passwd
SHADOW_ADMIN_SBIN_PROGS	:= \
	chgpasswd chpasswd \
	groupadd groupdel groupmems groupmod grpck grpconv grpunconv \
	newusers pwck pwconv pwunconv useradd userdel usermod vipw
SHADOW_ADMIN_PAMD	:= \
	chage chfn chgpasswd chpasswd chsh \
	groupadd groupdel groupmems groupmod \
	newusers passwd useradd userdel usermod

$(STATEDIR)/shadow.targetinstall:
	@$(call targetinfo)

	@$(call install_init, shadow)
	@$(call install_fixup, shadow,PRIORITY,optional)
	@$(call install_fixup, shadow,SECTION,base)
	@$(call install_fixup, shadow,AUTHOR,"Ladislav Michl <ladis@linux-mips.org>")
	@$(call install_fixup, shadow,DESCRIPTION,missing)

	@$(call install_copy, shadow, 0, 0, 0755, -, /usr/bin/faillog)
	@$(call install_copy, shadow, 0, 0, 0755, -, /usr/bin/groups)
	@$(call install_copy, shadow, 0, 0, 0755, -, /usr/bin/lastlog)
	@$(call install_copy, shadow, 0, 0, 0755, -, /usr/bin/login)
	@$(call install_copy, shadow, 0, 0, 4755, -, /usr/bin/su)
	@$(call install_copy, shadow, 0, 0, 0755, -, /usr/sbin/nologin)

	@$(call install_alternative, shadow, 0, 0, 0644, /etc/login.defs)
ifdef PTXCONF_GLOBAL_PAM
	@$(call install_alternative, shadow, 0, 0, 0644, /etc/pam.d/login)
	@$(call install_alternative, shadow, 0, 0, 0644, /etc/pam.d/su)
endif

ifdef PTXCONF_SHADOW_ADMIN
	@$(foreach prog, $(SHADOW_ADMIN_BIN_PROGS), \
		$(call install_copy, shadow, 0, 0, 4755, -, \
			/usr/bin/$(prog))$(ptx/nl))
	@$(call install_link, shadow, newgrp, /usr/bin/sg)

	@$(foreach prog, $(SHADOW_ADMIN_SBIN_PROGS), \
		$(call install_copy, shadow, 0, 0, 0755, -, \
			/usr/sbin/$(prog))$(ptx/nl))
	@$(call install_link, shadow, vipw, /usr/sbin/wigr)

	@$(call install_alternative, shadow, 0, 0, 0644, /etc/default/useradd)
ifdef PTXCONF_GLOBAL_PAM
	@$(foreach pam, $(SHADOW_ADMIN_PAMD), \
		$(call install_alternative, shadow, 0, 0, 0644, \
			/etc/pam.d/$(pam))$(ptx/nl))
endif
endif

	@$(call install_finish, shadow)

	@$(call touch)

# vim: syntax=make
