# -*-makefile-*-
#
# Copyright (C) 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SYSSTAT) += sysstat

#
# Paths and names
#
SYSSTAT_VERSION	:= 12.7.9
SYSSTAT_SHA256	:= e48fc69401135dc08d2cd4ff58dbdbfce9b7485f76fc9049d97848e313c08dda
SYSSTAT		:= sysstat-$(SYSSTAT_VERSION)
SYSSTAT_SUFFIX	:= tar.gz
SYSSTAT_URL	:= https://github.com/sysstat/sysstat/archive/refs/tags/v$(SYSSTAT_VERSION).$(SYSSTAT_SUFFIX)
SYSSTAT_SOURCE	:= $(SRCDIR)/$(SYSSTAT).$(SYSSTAT_SUFFIX)
SYSSTAT_DIR	:= $(BUILDDIR)/$(SYSSTAT)
SYSSTAT_LICENSE	:= GPL-2.0-or-later
SYSSTAT_LICENSE_FILES	:= file://COPYING;md5=a23a74b3f4caf9616230789d94217acb

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------
SYSSTAT_CONF_ENV = \
	$(CROSS_ENV) \
	sa_lib_dir=/usr/lib/sa \
	sa_dir=/var/log/sa

#
# autoconf
#
SYSSTAT_CONF_TOOL	:= autoconf
SYSSTAT_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-pcp \
	--disable-sensors \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-nls \
	--disable-lto \
	--disable-file-attr \
	--disable-compress-manpg \
	--enable-clean-sa-dir \
	--disable-install-cron \
	--disable-use-crond \
	--enable-collect-all \
	--enable-copy-only \
	--disable-documentation \
	--enable-debuginfo \
	--disable-stripping \
	--$(call ptx/endis, PTXCONF_GLIBC_Y2038)-year2038

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/sysstat.targetinstall:
	@$(call targetinfo)

	@$(call install_init, sysstat)
	@$(call install_fixup, sysstat,PRIORITY,optional)
	@$(call install_fixup, sysstat,SECTION,base)
	@$(call install_fixup, sysstat,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, sysstat,DESCRIPTION,missing)

	@$(call install_alternative, sysstat, 0, 0, 0644, \
		/etc/sysconfig/sysstat)
	@$(call install_alternative, sysstat, 0, 0, 0644, \
		/etc/sysconfig/sysstat.ioconf)

	@$(call install_copy, sysstat, 0, 0, 0755, /var/log/sa)

	@$(call install_copy, sysstat, 0, 0, 0755, -, /usr/bin/cifsiostat)
	@$(call install_copy, sysstat, 0, 0, 0755, -, /usr/bin/iostat)
	@$(call install_copy, sysstat, 0, 0, 0755, -, /usr/bin/mpstat)
	@$(call install_copy, sysstat, 0, 0, 0755, -, /usr/bin/pidstat)
	@$(call install_copy, sysstat, 0, 0, 0755, -, /usr/bin/sadf)
	@$(call install_copy, sysstat, 0, 0, 0755, -, /usr/bin/sar)

	@$(call install_copy, sysstat, 0, 0, 0755, -, /usr/lib/sa/sa1)
	@$(call install_copy, sysstat, 0, 0, 0755, -, /usr/lib/sa/sa2)
	@$(call install_copy, sysstat, 0, 0, 0755, -, /usr/lib/sa/sadc)

	@$(call install_finish, sysstat)

	@$(call touch)

# vim: syntax=make
