# -*-makefile-*-
#
# Copyright (C) 2005 by Robert Schwebel
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SMTPCLIENT) += smtpclient

#
# Paths and names
#
SMTPCLIENT_VERSION	:= 1.0.0
SMTPCLIENT_MD5		:= 8b5d9260572107bb901edf6aacbf3747
SMTPCLIENT		:= smtpclient-$(SMTPCLIENT_VERSION)
SMTPCLIENT_SUFFIX	:= tar.gz
SMTPCLIENT_URL		:= http://www.pengutronix.de/software/ptxdist/temporary-src/$(SMTPCLIENT).$(SMTPCLIENT_SUFFIX)
SMTPCLIENT_SOURCE	:= $(SRCDIR)/$(SMTPCLIENT).$(SMTPCLIENT_SUFFIX)
SMTPCLIENT_DIR		:= $(BUILDDIR)/$(SMTPCLIENT)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SMTPCLIENT_CONF_ENV	:= \
	$(CROSS_ENV) \
	ac_cv_lib_nsl_gethostbyname=no

#
# autoconf
#
SMTPCLIENT_CONF_OPT := \
	$(CROSS_AUTOCONF_USR)

SMTPCLIENT_INSTALL_OPT := \
	prefix=$(SMTPCLIENT_PKGDIR)/usr \
	install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/smtpclient.targetinstall:
	@$(call targetinfo)
	
	@$(call install_init, smtpclient)
	@$(call install_fixup, smtpclient,PRIORITY,optional)
	@$(call install_fixup, smtpclient,SECTION,base)
	@$(call install_fixup, smtpclient,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, smtpclient,DESCRIPTION,missing)

	@$(call install_copy, smtpclient, 0, 0, 0755, -, /usr/bin/smtpclient)

	@$(call install_finish, smtpclient)

	@$(call touch)

# vim: syntax=make
