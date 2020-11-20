# -*-makefile-*-
#
# Copyright (C) 2003 by Benedikt Spranger
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_THTTPD) += thttpd

#
# Paths and names
#
THTTPD_VERSION	:= 2.25b
THTTPD_MD5	:= 156b249b3b0bcd48b06badd2db0d56c5
THTTPD		:= thttpd-$(THTTPD_VERSION)
THTTPD_SUFFIX	:= tar.gz
THTTPD_URL	:= http://www.acme.com/software/thttpd/$(THTTPD).$(THTTPD_SUFFIX)
THTTPD_SOURCE	:= $(SRCDIR)/$(THTTPD).$(THTTPD_SUFFIX)
THTTPD_DIR	:= $(BUILDDIR)/$(THTTPD)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

THTTPD_PATH	:= PATH=$(CROSS_PATH)
THTTPD_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
THTTPD_AUTOCONF	:= $(CROSS_AUTOCONF_USR)

THTTPD_MAKE_PAR	:= NO

# DESTDIR is broken. Overwrite prefix instead
THTTPD_INSTALL_OPT := \
	DESTDIR= \
	prefix=$(THTTPD_PKGDIR)/usr \
	WEBGROUP=root \
	install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/thttpd.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  thttpd)
	@$(call install_fixup, thttpd,PRIORITY,optional)
	@$(call install_fixup, thttpd,SECTION,base)
	@$(call install_fixup, thttpd,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, thttpd,DESCRIPTION,missing)

	@$(call install_copy, thttpd, 0, 0, 0755, -, /usr/sbin/thttpd)

ifdef PTXCONF_THTTPD_STARTSCRIPT
	@$(call install_alternative, thttpd, 0, 0, 0755, /etc/init.d/thttpd, n)

ifneq ($(call remove_quotes,$(PTXCONF_THTTPD_BBINIT_LINK)),)
	@$(call install_link, thttpd, \
		../init.d/thttpd, \
		/etc/rc.d/$(PTXCONF_THTTPD_BBINIT_LINK))
endif
endif

ifdef PTXCONF_THTTPD__GENERIC_SITE
	@$(call install_copy, thttpd, 12, 102, 0755, /var/www)
	@$(call install_copy, thttpd, 12, 102, 0644, \
		$(PTXDIST_TOPDIR)/projectroot/var/www/thttpd.html, \
		/var/www/index.html, n)
endif

ifdef PTXCONF_THTTPD__INSTALL_HTPASSWD
	@$(call install_copy, thttpd, 0, 0, 0755, -, \
		/usr/sbin/htpasswd)
endif

	@$(call install_finish, thttpd)
	@$(call touch)

# vim: syntax=make
