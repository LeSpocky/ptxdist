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
SYSLOGNG_VERSION	:= 4.8.1
SYSLOG_LIBVERSION	:= 4.8
SYSLOGNG_MD5		:= 6a5852343f9a34449c3812b474728aa7
SYSLOGNG		:= syslog-ng-$(SYSLOGNG_VERSION)
SYSLOGNG_SUFFIX		:= tar.gz
SYSLOGNG_URL		:= https://github.com/balabit/syslog-ng/releases/download/syslog-ng-$(SYSLOGNG_VERSION)/$(SYSLOGNG).$(SYSLOGNG_SUFFIX)
SYSLOGNG_SOURCE		:= $(SRCDIR)/$(SYSLOGNG).$(SYSLOGNG_SUFFIX)
SYSLOGNG_DIR		:= $(BUILDDIR)/$(SYSLOGNG)
SYSLOGNG_LICENSE	:= GPL-2.0-or-later AND LGPL-2.1-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SYSLOGNG_CONF_ENV	:= \
	$(CROSS_ENV) \
	ac_cv_lib_nsl_gethostbyname=no \
	am_cv_python_version=$(PYTHON3_MAJORMINOR) \
	ac_cv_path_PYTHON=$(CROSS_PYTHON3)

#
# autoconf
#
SYSLOGNG_CONF_TOOL	:= autoconf
SYSLOGNG_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--enable-forced-server-mode \
	--disable-debug \
	--disable-example-modules \
	--enable-force-gnu99 \
	--disable-extra-warnings \
	--disable-env-wrapper \
	--disable-gprof \
	--disable-memtrace \
	--enable-dynamic-linking \
	--disable-mixed-linking \
	--disable-force-classic-linking \
	$(GLOBAL_IPV6_OPTION) \
	--disable-tcp-wrapper \
	--$(call ptx/endis, PTXCONF_SYSLOGNG_SPOOF_SOURCE)-spoof-source \
	--disable-sun-streams \
	--disable-darwin-osl \
	--disable-openbsd-system-source \
	--disable-sql \
	--disable-pacct \
	--disable-linux-caps \
	--disable-ebpf \
	--disable-gcov \
	--disable-mongodb \
	--$(call ptx/endis, PTXCONF_SYSLOGNG_JSON)-json \
	--disable-amqp \
	--$(call ptx/endis, PTXCONF_SYSLOGNG_STOMP_DESTINATION)-stomp \
	--disable-smtp \
	--disable-mqtt \
	--disable-grpc \
	--disable-cloud-auth \
	--disable-cpp \
	--$(call ptx/endis, PTXCONF_SYSLOGNG_HTTP)-http \
	--disable-redis \
	--$(call ptx/endis, PTXCONF_SYSLOGNG_SYSTEMD)-systemd \
	--disable-geoip2 \
	--disable-riemann \
	--disable-kafka \
	--with-python=auto \
	--$(call ptx/endis, PTXCONF_SYSLOGNG_PYTHON_DESTINATION)-python-modules \
	--disable-manpages \
	--disable-manpages-install \
	--disable-java \
	--disable-java-modules \
	--enable-native \
	--disable-afsnmp \
	--disable-all-modules \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-valgrind \
	--with-libnet=$(SYSROOT)/usr/bin \
	--without-net-snmp \
	--with-pidfile-dir=/var/run \
	--with-module-dir=/usr/lib/syslog-ng \
	--with-systemdsystemunitdir=/usr/lib/systemd/system \
	--with-jsonc \
	--with-ivykis=internal \
	--without-libesmtp \
	--without-libhiredis \
	--without-compile-date \
	--with-systemd-journal=$(call ptx/ifdef, PTXCONF_SYSLOGNG_SYSTEMD,system,no)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/syslogng.install:
	@$(call targetinfo)
	@$(call world/install, SYSLOGNG)
#	# test plugins, not needed on the target
	@rm -r "$(SYSLOGNG_PKGDIR)/usr/lib/syslog-ng/loggen"
	@$(call touch)


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
	@$(call install_lib, syslogng, 0, 0, 0644, libevtlog-$(SYSLOG_LIBVERSION))
	@$(call install_lib, syslogng, 0, 0, 0644, libsecret-storage)
	@$(call install_glob, syslogng, 0, 0, -, /usr/lib/syslog-ng, *.so)

#	# config
ifdef PTXCONF_SYSLOGNG_CONFIG
	@$(call install_alternative, syslogng, 0, 0, 0644, /etc/syslog-ng.conf, n)
endif

#	# bb init: start scripts
ifdef PTXCONF_SYSLOGNG_STARTSCRIPT
	@$(call install_alternative, syslogng, 0, 0, 0755, /etc/init.d/syslog-ng, n)

ifneq ($(call remove_quotes,$(PTXCONF_SYSLOGNG_BBINIT_LINK)),)
	@$(call install_link, syslogng, \
		../init.d/syslog-ng, \
		/etc/rc.d/$(PTXCONF_SYSLOGNG_BBINIT_LINK))
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
