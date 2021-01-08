# -*-makefile-*-
#
# Copyright (C) 2010 by Bart vdr. Meulen <bartvdrmeulen@gmail.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_QUOTA_TOOLS) += quota-tools

#
# Paths and names
#
QUOTA_TOOLS_VERSION	:= 4.06
QUOTA_TOOLS_MD5		:= aef94648438832b684978d46fdf75110
QUOTA_TOOLS		:= quota-$(QUOTA_TOOLS_VERSION)
QUOTA_TOOLS_SUFFIX	:= tar.gz
QUOTA_TOOLS_URL		:= $(call ptx/mirror, SF, linuxquota/$(QUOTA_TOOLS).$(QUOTA_TOOLS_SUFFIX))
QUOTA_TOOLS_SOURCE	:= $(SRCDIR)/$(QUOTA_TOOLS).$(QUOTA_TOOLS_SUFFIX)
QUOTA_TOOLS_DIR		:= $(BUILDDIR)/$(QUOTA_TOOLS)
QUOTA_TOOLS_LICENSE	:= GPL-2.0-only

#
# autoconf
#
QUOTA_TOOLS_CONF_TOOL	:= autoconf

QUOTA_TOOLS_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-nls \
	--disable-rpath \
	--disable-werror \
	--disable-ldapmail \
	--$(call ptx/endis, PTXCONF_QUOTA_TOOLS_QUOTACHECK_EXT2)-ext2direct \
	--disable-netlink \
	--disable-libwrap \
	--$(call ptx/endis, PTXCONF_QUOTA_TOOLS_RQUOTAD)-rpc \
	--disable-rpcsetquota \
	--disable-xfs-roothack \
	--enable-bsd-behaviour \
	--with-proc-mounts=/proc/self/mounts

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------
QUOTA_TOOLS_MAKE_ENV	 := $(CROSS_ENV)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------
QUOTA_TOOLS_INSTALL_OPT := ROOTDIR=$(QUOTA_TOOLS_PKGDIR) install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/quota-tools.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  quota-tools)
	@$(call install_fixup, quota-tools,PRIORITY,optional)
	@$(call install_fixup, quota-tools,SECTION,base)
	@$(call install_fixup, quota-tools,AUTHOR,"Bart vdr. Meulen <bartvdrmeulen@gmail.com>")
	@$(call install_fixup, quota-tools,DESCRIPTION,missing)

ifdef PTXCONF_QUOTA_TOOLS_QUOTACHECK
	@$(call install_copy, quota-tools, 0, 0, 0755, -, /usr/sbin/quotacheck)
endif
ifdef PTXCONF_QUOTA_TOOLS_QUOTAONOFF
	@$(call install_copy, quota-tools, 0, 0, 0755, -, /usr/sbin/quotaon)
	@$(call install_link, quota-tools, quotaon, /usr/sbin/quotaoff)
endif
ifdef PTXCONF_QUOTA_TOOLS_SETQUOTA
	@$(call install_copy, quota-tools, 0, 0, 0755, -, /usr/sbin/setquota)
endif
ifdef PTXCONF_QUOTA_TOOLS_QUOTA
	@$(call install_copy, quota-tools, 0, 0, 0755, -, /usr/bin/quota)
endif
ifdef PTXCONF_QUOTA_TOOLS_REPQUOTA
	@$(call install_copy, quota-tools, 0, 0, 0755, -, /usr/sbin/repquota)
endif
ifdef PTXCONF_QUOTA_TOOLS_EDQUOTA
	@$(call install_copy, quota-tools, 0, 0, 0755, -, /usr/sbin/edquota)
endif
ifdef PTXCONF_QUOTA_TOOLS_QUOTASTATS
	@$(call install_copy, quota-tools, 0, 0, 0755, -, /usr/sbin/quotastats)
endif
ifdef PTXCONF_QUOTA_TOOLS_CONVERTQUOTA
	@$(call install_copy, quota-tools, 0, 0, 0755, -, /usr/sbin/convertquota)
endif
ifdef PTXCONF_QUOTA_TOOLS_WARNQUOTA
	@$(call install_copy, quota-tools, 0, 0, 0755, -, /usr/sbin/warnquota)
	@$(call install_copy, quota-tools, 0, 0, 0644, -, /etc/warnquota.conf)
	@$(call install_copy, quota-tools, 0, 0, 0644, -, /etc/quotatab)
	@$(call install_copy, quota-tools, 0, 0, 0644, -, /etc/quotagrpadmins)
endif
ifdef PTXCONF_QUOTA_TOOLS_RQUOTAD
	@$(call install_copy, quota-tools, 0, 0, 0755, -, /usr/sbin/rpc.rquotad)
endif

	@$(call install_finish, quota-tools)

	@$(call touch)

# vim: syntax=make
