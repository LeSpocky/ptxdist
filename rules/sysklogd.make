# -*-makefile-*-
#
# Copyright (C) 2021 by Christian Melki <christian.melki@t2data.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SYSKLOGD) += sysklogd

#
# Paths and names
#
SYSKLOGD_VERSION	:= 2.6.2
SYSKLOGD_MD5		:= 9f64535a9a791f20504841b94d194391
SYSKLOGD		:= sysklogd-$(SYSKLOGD_VERSION)
SYSKLOGD_SUFFIX		:= tar.gz
SYSKLOGD_URL		:= https://github.com/troglobit/sysklogd/releases/download/v$(SYSKLOGD_VERSION)/$(SYSKLOGD).$(SYSKLOGD_SUFFIX)
SYSKLOGD_SOURCE		:= $(SRCDIR)/$(SYSKLOGD).$(SYSKLOGD_SUFFIX)
SYSKLOGD_DIR		:= $(BUILDDIR)/$(SYSKLOGD)
SYSKLOGD_LICENSE	:= BSD-3-Clause

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
SYSKLOGD_CONF_TOOL = autoconf
SYSKLOGD_CONF_OPT = \
	$(CROSS_AUTOCONF_USR) \
	--without-suspend-time \
	--with-systemd=/usr/lib/systemd/system \
	--with-logger

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/sysklogd.install:
	@$(call targetinfo)
	@$(call world/install, SYSKLOGD)
	@install -vD -m 644 $(SYSKLOGD_DIR)/syslog.conf \
		$(SYSKLOGD_PKGDIR)/etc/syslog.conf
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/sysklogd.targetinstall:
	@$(call targetinfo)

	@$(call install_init, sysklogd)
	@$(call install_fixup, sysklogd,PRIORITY,optional)
	@$(call install_fixup, sysklogd,SECTION,base)
	@$(call install_fixup, sysklogd,AUTHOR,"Christian Melki <christian.melki@t2data.com>")
	@$(call install_fixup, sysklogd,DESCRIPTION,missing)

	@$(call install_copy, sysklogd, 0, 0, 0755, -, /usr/bin/logger)
	@$(call install_copy, sysklogd, 0, 0, 0755, -, /usr/sbin/syslogd)
	@$(call install_lib, sysklogd, 0, 0, 0644, libsyslog)

	@$(call install_alternative, sysklogd, 0, 0, 0644, /etc/syslog.conf)

ifdef PTXCONF_SYSKLOGD_STARTSCRIPT
	@$(call install_alternative, sysklogd, 0, 0, 0755, /etc/init.d/syslogd)

ifneq ($(call remove_quotes,$(PTXCONF_SYSKLOGD_BBINIT_LINK)),)
	@$(call install_link, sysklogd, \
		../init.d/syslogd, \
		/etc/rc.d/$(PTXCONF_SYSKLOGD_BBINIT_LINK))
endif
endif

ifdef PTXCONF_INITMETHOD_SYSTEMD
	@$(call install_alternative, sysklogd, 0, 0, 0644, \
		/usr/lib/systemd/system/syslogd.service)
	@$(call install_link, sysklogd, ../syslogd.service, \
		/usr/lib/systemd/system/multi-user.target.wants/syslogd.service)
	@$(call install_link, sysklogd, syslogd.service, \
		/usr/lib/systemd/system/syslog.service)
endif

	@$(call install_finish, sysklogd)

	@$(call touch)

# vim: syntax=make
