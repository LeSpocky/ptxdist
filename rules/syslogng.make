# -*-makefile-*-
#
# Copyright (C) 2006 by Robert Schwebel
#               2008, 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#               2016 Pengutronix, Steffen Trumtrar <entwicklung@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SYSLOGNG) += syslogng

#
# Paths and names
#
SYSLOGNG_VERSION	:= 3.7.3
SYSLOG_LIBVERSION	:= 3.7
SYSLOGNG_MD5		:= 803d61a713d6d41a973942d417fec999
SYSLOGNG		:= syslog-ng-$(SYSLOGNG_VERSION)
SYSLOGNG_SUFFIX		:= tar.gz
SYSLOGNG_URL		:= https://github.com/balabit/syslog-ng/releases/download/syslog-ng-$(SYSLOGNG_VERSION)/$(SYSLOGNG).$(SYSLOGNG_SUFFIX)
SYSLOGNG_SOURCE		:= $(SRCDIR)/$(SYSLOGNG).$(SYSLOGNG_SUFFIX)
SYSLOGNG_DIR		:= $(BUILDDIR)/$(SYSLOGNG)
SYSLOGNG_LICENSE	:= GPL-2.0-or-later AND LGPL-2.1-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SYSLOGNG_ENV 	= \
	$(CROSS_ENV) \
	ac_cv_path_PYTHON=$(CROSS_PYTHON)

#
# autoconf
#
SYSLOGNG_AUTOCONF = \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_IPV6_OPTION) \
	--enable-dynamic-linking \
	--disable-debug \
	--disable-sun-streams \
	--$(call ptx/endis, PTXCONF_SYSLOGNG_AMQP_DESTINATION)-amqp \
	--$(call ptx/endis, PTXCONF_SYSLOGNG_MONGODB_DESTINATION)-mongodb \
	--$(call ptx/endis, PTXCONF_SYSLOGNG_PYTHON_DESTINATION)-python \
	--$(call ptx/endis, PTXCONF_SYSLOGNG_SYSTEMD)-systemd \
	--$(call ptx/endis, PTXCONF_SYSLOGNG_SPOOF_SOURCE)-spoof-source \
	--$(call ptx/endis, PTXCONF_SYSLOGNG_STOMP_DESTINATION)-stomp \
	--$(call ptx/endis, PTXCONF_SYSLOGNG_TCP_WRAPPER)-tcp-wrapper \
	--with-systemd-journal=$(call ptx/ifdef, PTXCONF_SYSLOGNG_SYSTEMD,system,no) \
	--with-systemdsystemunitdir=/usr/lib/systemd/system \
	--localstatedir=/var/run \
	--with-libnet=$(SYSROOT)/usr/bin \
	--with-python=$(PYTHON_MAJORMINOR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/syslogng.targetinstall:
	@$(call targetinfo)

	@$(call install_init, syslogng)
	@$(call install_fixup, syslogng,PRIORITY,optional)
	@$(call install_fixup, syslogng,SECTION,base)
	@$(call install_fixup, syslogng,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, syslogng,DESCRIPTION,missing)

#	# binary
	@$(call install_copy, syslogng, 0, 0, 0755, -, \
		/usr/sbin/syslog-ng)
	@$(call install_lib, syslogng, 0, 0, 0644, libsyslog-ng-$(SYSLOG_LIBVERSION))
	@$(call install_glob, syslogng, 0, 0, -, /usr/lib/syslog-ng, *.so)

#	# config
ifdef PTXCONF_SYSLOGNG_CONFIG
	@$(call install_alternative, syslogng, 0, 0, 0644, /etc/syslog-ng.conf, n)
endif

#	# bb init: start scripts
ifdef PTXCONF_INITMETHOD_BBINIT
ifdef PTXCONF_SYSLOGNG_STARTSCRIPT
	@$(call install_alternative, syslogng, 0, 0, 0755, /etc/init.d/syslog-ng, n)

ifneq ($(call remove_quotes,$(PTXCONF_SYSLOGNG_BBINIT_LINK)),)
	@$(call install_link, syslogng, \
		../init.d/syslog-ng, \
		/etc/rc.d/$(PTXCONF_SYSLOGNG_BBINIT_LINK))
endif
endif
endif

ifdef PTXCONF_INITMETHOD_SYSTEMD
ifdef PTXCONF_SYSLOGNG_SYSTEMD
	@$(call install_alternative, syslogng, 0, 0, 0644, \
		/usr/lib/systemd/system/syslog-ng.service)
	@$(call install_link, syslogng, ../syslog-ng.service, \
		/usr/lib/systemd/system/multi-user.target.wants/syslog-ng.service)
	@$(call install_link, syslogng, syslog-ng.service, \
		/usr/lib/systemd/system/syslog.service)
endif
endif
	@$(call install_finish, syslogng)

	@$(call touch)

# vim: syntax=make
