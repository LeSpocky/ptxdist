# -*-makefile-*-
#
# Copyright (C) 2005 by Bjoern Buerger <b.buerger@pengutronix.de>
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_CHRONY) += chrony

#
# Paths and names
#
CHRONY_VERSION	:= 3.5
CHRONY_MD5	:= 5f66338bc940a9b51eede8f391e7bed3
CHRONY		:= chrony-$(CHRONY_VERSION)
CHRONY_SUFFIX	:= tar.gz
CHRONY_URL	:= http://download.tuxfamily.org/chrony/$(CHRONY).$(CHRONY_SUFFIX)
CHRONY_SOURCE	:= $(SRCDIR)/$(CHRONY).$(CHRONY_SUFFIX)
CHRONY_DIR	:= $(BUILDDIR)/$(CHRONY)
CHRONY_LICENSE	:= GPL-2.0-only AND RSA-MD
CHRONY_LICENSE_FILES	:= \
	file://COPYING;md5=751419260aa954499f7abaabaa882bbe \
	file://md5.c;startline=20;endline=36;md5=66d5a6df5fcc43891661c560cf5b74b1

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# Chony is using a handcrafted configure script so normal ptx/endis
# and ptx/wwo are broken and causes "Unrecognized option".
# CROSS_AUTOCONF_USR is not used as that adds 3 unrecognized options:
# --libdir=, --build=, --host=
#
CHRONY_CONF_TOOL	:= autoconf
CHRONY_CONF_OPT		:= \
	--localstatedir=/var \
	--prefix=/usr \
	--sysconfdir=/etc \
	--disable-readline \
	--without-editline \
	$(call ptx/ifdef, PTXCONF_CHRONY_USE_NETTLE,,--disable-sechash) \
	$(call ptx/ifdef, PTXCONF_CHRONY_USE_NETTLE,,--without-nettle) \
	--without-nss \
	--without-tomcrypt \
	$(call ptx/ifdef, PTXCONF_CHRONY_ADVANCED_COMMAND,,--disable-cmdmon) \
	$(call ptx/ifdef, PTXCONF_CHRONY_ADVANCED_COMMAND,--enable-debug,) \
	--disable-refclock \
	--disable-phc \
	--disable-pps \
	$(call ptx/ifdef, PTXCONF_GLOBAL_IPV6,,--disable-ipv6) \
	--with-user=chrony \
	$(call ptx/ifdef, PTXCONF_CHRONY_SECCOMP,--enable-scfilter,) \
	$(call ptx/ifdef, PTXCONF_CHRONY_SECCOMP,,--without-seccomp)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/chrony.install:
	@$(call targetinfo)
	@$(call world/install, CHRONY)
	@install -D -m 644 $(CHRONY_DIR)/examples/chronyd.service \
		$(CHRONY_PKGDIR)/usr/lib/systemd/system/chronyd.service
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/chrony.targetinstall:
	@$(call targetinfo)

	@$(call install_init, chrony)
	@$(call install_fixup, chrony,PRIORITY,optional)
	@$(call install_fixup, chrony,SECTION,base)
	@$(call install_fixup, chrony,AUTHOR,"PTXdist Base Package <ptxdist@pengutronix.de>")
	@$(call install_fixup, chrony,DESCRIPTION,missing)

# binaries
	@$(call install_copy, chrony, 0, 0, 0755, -, \
		/usr/sbin/chronyd)
	@$(call install_copy, chrony, 0, 0, 0755, -, \
		/usr/bin/chronyc)

# command helper script
ifdef PTXCONF_CHRONY_INSTALL_CHRONY_COMMAND
	@$(call install_alternative, chrony, 0, 0, 0755, /usr/bin/chrony_command)
endif

# chrony stat convenience wrapper
ifdef PTXCONF_CHRONY_INSTALL_CHRONY_STAT
	@$(call install_alternative, chrony, 0, 0, 0755, /usr/bin/chrony_stat)
endif

# generic one
ifdef PTXCONF_CHRONY_INSTALL_CONFIG
	@$(call install_alternative, chrony, 0, 0, 0644, /etc/chrony/chrony.conf)
	@$(call install_alternative, chrony, 0, 0, 0600, /etc/chrony/chrony.keys)

# modify placeholders with data from configuration
	@$(call install_replace, chrony, /etc/chrony/chrony.conf, \
		@UNCONFIGURED_CHRONY_SERVER_IP@, $(PTXCONF_CHRONY_DEFAULT_NTP_SERVER))

	@$(call install_replace, chrony, /etc/chrony/chrony.keys, \
		@UNCONFIGURED_CHRONY_ACCESS_KEY@, $(PTXCONF_CHRONY_DEFAULT_ACCESS_KEY))
endif

#	#
#	# busybox init: startscripts
#	#
ifdef PTXCONF_CHRONY_STARTSCRIPT
	@$(call install_alternative, chrony, 0, 0, 0755, /etc/init.d/chrony)

ifneq ($(call remove_quotes, $(PTXCONF_CHRONY_BBINIT_LINK)),)
	@$(call install_link, chrony, \
		../init.d/chrony, \
		/etc/rc.d/$(PTXCONF_CHRONY_BBINIT_LINK))
endif
endif

ifdef PTXCONF_CHRONY_SYSTEMD_UNIT
	@$(call install_alternative, chrony, 0, 0, 0644, /usr/lib/systemd/system/chronyd.service)
	@$(call install_link, chrony, ../chronyd.service, \
		/usr/lib/systemd/system/multi-user.target.wants/chronyd.service)
endif

	@$(call install_finish, chrony)

	@$(call touch)

# vim: syntax=make
