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
SYSSTAT_VERSION	:= 12.0.4
SYSSTAT_MD5	:= 237ae1ba7a2073628b2cd7444ae3aed8
SYSSTAT		:= sysstat-$(SYSSTAT_VERSION)
SYSSTAT_SUFFIX	:= tar.xz
SYSSTAT_URL	:= http://pagesperso-orange.fr/sebastien.godard/$(SYSSTAT).$(SYSSTAT_SUFFIX)
SYSSTAT_SOURCE	:= $(SRCDIR)/$(SYSSTAT).$(SYSSTAT_SUFFIX)
SYSSTAT_DIR	:= $(BUILDDIR)/$(SYSSTAT)
SYSSTAT_LICENSE	:= GPL-2.0-or-later

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
	--disable-sensors \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-nls \
	--disable-file-attr \
	--disable-compress-manpg \
	--enable-clean-sa-dir \
	--disable-install-cron \
	--enable-collect-all \
	--enable-copy-only \
	--disable-documentation \
	--enable-debuginfo \
	--disable-stripping

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
