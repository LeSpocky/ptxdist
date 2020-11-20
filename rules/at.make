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
PACKAGES-$(PTXCONF_AT) += at

#
# Paths and names
#
AT_VERSION	:= 3.1.12
AT_MD5		:= 1e67991776148fb319fd77a2e599a765
AT_SUFFIX	:= tar.gz
AT		:= at-$(AT_VERSION)
AT_TARBALL	:= at_$(AT_VERSION).orig.$(AT_SUFFIX)
AT_URL		:= http://snapshot.debian.org/archive/debian/20091130T214753Z/pool/main/a/at/$(AT_TARBALL)
AT_SOURCE	:= $(SRCDIR)/$(AT_TARBALL)
AT_DIR		:= $(BUILDDIR)/$(AT)
AT_LICENSE	:= GPL-2.0-or-later AND GPL-3.0-or-later AND ISC
AT_LICENSE_FILES := \
	file://COPYING;md5=4325afd396febcb659c36b49533135d4 \
	file://Copyright;md5=dffa11c636884752fbf0b2a159b2883a

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

AT_ENV	:= \
	$(CROSS_ENV) \
	ac_cv_header_security_pam_appl_h=$(call ptx/yesno, PTXCONF_GLOBAL_PAM)

ifdef PTXCONF_AT_MAIL
AT_SENDMAIL := $(PTXCONF_AT_SENDMAIL)
else
AT_SENDMAIL := /bin/true
endif

#
# autoconf
#
AT_CONF_TOOL	:= autoconf
AT_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--with-loadavg_mx=1.5 \
	--with-jobdir=/var/spool/cron/atjobs \
	--with-atspool=/var/spool/cron/atspool \
	--with-daemon_username=root \
	--with-daemon_groupname=root \
	SENDMAIL=$(AT_SENDMAIL)

AT_MAKE_PAR := NO

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/at.targetinstall:
	@$(call targetinfo)

	@$(call install_init, at)
	@$(call install_fixup, at,PRIORITY,optional)
	@$(call install_fixup, at,SECTION,base)
	@$(call install_fixup, at,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, at,DESCRIPTION,missing)

	@$(call install_alternative, at, 0, 0, 0640, /etc/at.deny)

	@$(call install_copy, at, 0, 0, 1770, /var/spool/cron/atjobs)
	@$(call install_copy, at, 0, 0, 1770, /var/spool/cron/atspool)
	@$(call install_copy, at, 0, 0, 0600, -, /var/spool/cron/atjobs/.SEQ)

ifdef PTXCONF_AT_STARTSCRIPT
	@$(call install_alternative, at, 0, 0, 0755, /etc/init.d/atd)

ifneq ($(call remove_quotes, $(PTXCONF_AT_BBINIT_LINK)),)
	@$(call install_link, at, \
		../init.d/atd, \
		/etc/rc.d/$(PTXCONF_AT_BBINIT_LINK))
endif
endif

ifdef PTXCONF_AT_ATD
	@$(call install_copy, at, 0, 0, 0755, -, /usr/sbin/atd)
endif
ifdef PTXCONF_AT_AT
	@$(call install_copy, at, 0, 0, 6755, -, /usr/bin/at)
endif
ifdef PTXCONF_AT_ATQ
	@$(call install_link, at, at, /usr/bin/atq)
endif
ifdef PTXCONF_AT_ATRM
	@$(call install_link, at, at, /usr/bin/atrm)
endif
ifdef PTXCONF_AT_BATCH
	@$(call install_copy, at, 0, 0, 0755, -, /usr/bin/batch)
endif
	@$(call install_finish, at)

	@$(call touch)

# vim: syntax=make
