# -*-makefile-*-
#
# Copyright (C) 2012 by Wolfram Sang <w.sang@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_POLICYCOREUTILS) += policycoreutils

#
# Paths and names
#
POLICYCOREUTILS_VERSION	:= $(SELINUX_VERSION)
POLICYCOREUTILS_SHA256	:= 054e41ec039731a5ee6b797a8e0b8d6e346ee1d0a9bac2f252db48c23f9a8b1b
POLICYCOREUTILS		:= policycoreutils-$(POLICYCOREUTILS_VERSION)
POLICYCOREUTILS_SUFFIX	:= tar.gz
POLICYCOREUTILS_URL	:= $(SELINUX_URL)/$(POLICYCOREUTILS).$(POLICYCOREUTILS_SUFFIX)
POLICYCOREUTILS_SOURCE	:= $(SRCDIR)/$(POLICYCOREUTILS).$(POLICYCOREUTILS_SUFFIX)
POLICYCOREUTILS_DIR	:= $(BUILDDIR)/$(POLICYCOREUTILS)
POLICYCOREUTILS_LICENSE	:= GPL-2.0-only
POLICYCOREUTILS_LICENSE_FILES	:= file://LICENSE;md5=393a5ca445f6965873eca0259a17f833
POLICYCOREUTILS_CVE_PRODUCT	:= selinuxproject:policycoreutils

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

POLICYCOREUTILS_SUBDIRS_y :=
POLICYCOREUTILS_PROGS_y :=

POLICYCOREUTILS_SUBDIRS_$(PTXCONF_POLICYCOREUTILS_LOAD_POLICY)	+= load_policy
POLICYCOREUTILS_PROGS_$(PTXCONF_POLICYCOREUTILS_LOAD_POLICY)	+= /usr/sbin/load_policy

POLICYCOREUTILS_SUBDIRS_$(PTXCONF_POLICYCOREUTILS_NEWROLE)	+= newrole
POLICYCOREUTILS_PROGS_$(PTXCONF_POLICYCOREUTILS_NEWROLE)	+= /usr/bin/newrole

POLICYCOREUTILS_SUBDIRS_$(PTXCONF_POLICYCOREUTILS_RUN_INIT)	+= run_init
POLICYCOREUTILS_PROGS_$(PTXCONF_POLICYCOREUTILS_RUN_INIT)	+= /usr/sbin/run_init
POLICYCOREUTILS_PROGS_$(PTXCONF_POLICYCOREUTILS_RUN_INIT)	+= /usr/sbin/open_init_pty

POLICYCOREUTILS_SUBDIRS_$(PTXCONF_POLICYCOREUTILS_FIXFILES)	+= scripts
POLICYCOREUTILS_PROGS_$(PTXCONF_POLICYCOREUTILS_FIXFILES)	+= /usr/sbin/fixfiles

POLICYCOREUTILS_SUBDIRS_$(PTXCONF_POLICYCOREUTILS_SECON)	+= secon
POLICYCOREUTILS_PROGS_$(PTXCONF_POLICYCOREUTILS_SECON)		+= /usr/bin/secon

POLICYCOREUTILS_SUBDIRS_$(PTXCONF_POLICYCOREUTILS_SEMODULE)	+= semodule hll/pp
POLICYCOREUTILS_PROGS_$(PTXCONF_POLICYCOREUTILS_SEMODULE)	+= /usr/sbin/semodule
POLICYCOREUTILS_PROGS_$(PTXCONF_POLICYCOREUTILS_SEMODULE)	+= /usr/libexec/selinux/hll/pp

POLICYCOREUTILS_SUBDIRS_$(PTXCONF_POLICYCOREUTILS_SESTATUS)	+= sestatus
POLICYCOREUTILS_PROGS_$(PTXCONF_POLICYCOREUTILS_SESTATUS)	+= /usr/bin/sestatus

POLICYCOREUTILS_SUBDIRS_$(PTXCONF_POLICYCOREUTILS_SETFILES)	+= setfiles
POLICYCOREUTILS_PROGS_$(PTXCONF_POLICYCOREUTILS_SETFILES)	+= /usr/sbin/setfiles
POLICYCOREUTILS_PROGS_$(PTXCONF_POLICYCOREUTILS_SETFILES)	+= /usr/sbin/restorecon_xattr

POLICYCOREUTILS_SUBDIRS_$(PTXCONF_POLICYCOREUTILS_SETSEBOOL)	+= setsebool
POLICYCOREUTILS_PROGS_$(PTXCONF_POLICYCOREUTILS_SETSEBOOL)	+= /usr/sbin/setsebool

POLICYCOREUTILS_SUBDIRS_$(PTXCONF_POLICYCOREUTILS_UNSETFILES)	+= unsetfiles
POLICYCOREUTILS_PROGS_$(PTXCONF_POLICYCOREUTILS_UNSETFILES)	+= /usr/sbin/unsetfiles

POLICYCOREUTILS_CONF_TOOL	:= NO
POLICYCOREUTILS_MAKE_ENV	:= $(CROSS_ENV)
POLICYCOREUTILS_MAKE_OPT	:= \
	SUBDIRS="$(POLICYCOREUTILS_SUBDIRS_y)" \
	PREFIX=/usr \
	BINDIR=/usr/bin \
	SBINDIR=/usr/sbin \
	ETCDIR=/etc \
	LOCALEDIR=/usr/share/locale \
	PAMH=$(call ptx/ifdef, PTXCONF_GLOBAL_PAM, y, n) \
	AUDITH=$(call ptx/ifdef, PTXCONF_POLICYCOREUTILS_AUDIT, y, n) \
	AUDIT_LOG_PRIV=n \
	NAMESPACE_PRIV=n \
	LSPP_PRIV=n \
	CFLAGS="-O2 -Wall -g"
POLICYCOREUTILS_INSTALL_OPT	:= \
	$(POLICYCOREUTILS_MAKE_OPT) \
	install

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/policycoreutils.install:
	@$(call targetinfo)
ifdef PTXCONF_GLOBAL_PAM
	@mkdir -p $(POLICYCOREUTILS_PKGDIR)/etc/pam.d
endif
	@$(call world/install, POLICYCOREUTILS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/policycoreutils.targetinstall:
	@$(call targetinfo)

	@$(call install_init, policycoreutils)
	@$(call install_fixup, policycoreutils,PRIORITY,optional)
	@$(call install_fixup, policycoreutils,SECTION,base)
	@$(call install_fixup, policycoreutils,AUTHOR,"Wolfram Sang <w.sang@pengutronix.de>")
	@$(call install_fixup, policycoreutils,DESCRIPTION,missing)

ifdef PTXCONF_POLICYCOREUTILS_NEWROLE_PAM_CFG
	@$(call install_alternative, policycoreutils, 0, 0, 0644, /etc/pam.d/newrole)
endif
ifdef PTXCONF_POLICYCOREUTILS_RUN_INIT_PAM_CFG
	@$(call install_alternative, policycoreutils, 0, 0, 0644, /etc/pam.d/run_init)
endif

	@$(foreach prog, $(POLICYCOREUTILS_PROGS_y), \
		$(call install_copy, policycoreutils, 0, 0, 0755, -, $(prog))$(ptx/nl))

ifdef PTXCONF_POLICYCOREUTILS_SEMODULE
	@$(call install_link, policycoreutils, semodule, /usr/sbin/genhomedircon)
endif

ifdef PTXCONF_POLICYCOREUTILS_SETFILES
	@$(call install_link, policycoreutils, setfiles, /usr/sbin/restorecon)
endif

ifdef PTXCONF_POLICYCOREUTILS_SESTATUS
	@$(call install_alternative, policycoreutils, 0, 0, 0644, /etc/sestatus.conf)
endif

	@$(call install_finish, policycoreutils)

	@$(call touch)

# vim: syntax=make
