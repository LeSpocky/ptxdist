# -*-makefile-*-
#
# Copyright (C) 2003-2009 by Pengutronix e.K., Hildesheim, Germany
#               2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_NTPCLIENT) += ntpclient

#
# Paths and names
#
NTPCLIENT_VERSION	:= 365
NTPCLIENT_MD5		:= cb98711f11769cdd22fc592844cef414
NTPCLIENT_SUFFIX	:= tar.gz
NTPCLIENT		:= ntpclient-2007
NTPCLIENT_TARBALL	:= ntpclient_2007_$(NTPCLIENT_VERSION).$(NTPCLIENT_SUFFIX)
NTPCLIENT_URL		:= http://doolittle.icarus.com/ntpclient/$(NTPCLIENT_TARBALL)
NTPCLIENT_SOURCE	:= $(SRCDIR)/$(NTPCLIENT_TARBALL)
NTPCLIENT_DIR		:= $(BUILDDIR)/$(NTPCLIENT)
NTPCLIENT_LICENSE	:= GPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

NTPCLIENT_PATH	:= PATH=$(CROSS_PATH)
NTPCLIENT_MAKE_OPT := \
	CC="$(CROSS_CC)"

NTPCLIENT_CFLAGS :=
NTPCLIENT_INSTALL_OPT :=

ifdef PTXCONF_NTPCLIENT_BUILD_DEBUG
NTPCLIENT_CFLAGS += -DENABLE_DEBUG
endif

ifdef PTXCONF_NTPCLIENT_BUILD_REPLAY_OPTION
NTPCLIENT_CFLAGS += -DENABLE_REPLAY
endif

ifdef PTXCONF_NTPCLIENT_BUILD_NTPCLIENT
NTPCLIENT_MAKE_OPT += ntpclient
NTPCLIENT_INSTALL_OPT += install
endif

ifdef PTXCONF_NTPCLIENT_BUILD_ADJTIMEX
NTPCLIENT_MAKE_OPT += adjtimex
NTPCLIENT_INSTALL_OPT += install_adjtimex
endif

NTPCLIENT_MAKE_OPT += CFLAGS='-O2 $(NTPCLIENT_CFLAGS)'

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ntpclient.targetinstall:
	@$(call targetinfo)
	@$(call install_init, ntpclient)
	@$(call install_fixup, ntpclient,PRIORITY,optional)
	@$(call install_fixup, ntpclient,SECTION,base)
	@$(call install_fixup, ntpclient,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, ntpclient,DESCRIPTION,missing)

ifdef PTXCONF_NTPCLIENT_BUILD_NTPCLIENT
	@$(call install_copy, ntpclient, 0, 0, 0755, -, \
		/usr/sbin/ntpclient)
endif
ifdef PTXCONF_NTPCLIENT_BUILD_ADJTIMEX
	@$(call install_copy, ntpclient, 0, 0, 0755, -, \
		/sbin/adjtimex)
endif

#
# busybox init: start script
#

ifdef PTXCONF_NTPCLIENT_STARTSCRIPT
	@$(call install_alternative, ntpclient, 0, 0, 0755, /etc/init.d/ntpclient)
ifneq ($(PTXCONF_NTPCLIENT_NTPSERVER_NAME),"")
#	# replace the @HOST@ with name of NTP server
	@$(call install_replace, ntpclient, /etc/init.d/ntpclient, \
		@HOST@, \
		"$(PTXCONF_NTPCLIENT_NTPSERVER_NAME)")
endif

ifneq ($(call remove_quotes,$(PTXCONF_NTPCLIENT_BBINIT_LINK)),)
	@$(call install_link, ntpclient, \
		../init.d/ntpclient, \
		/etc/rc.d/$(PTXCONF_NTPCLIENT_BBINIT_LINK))
endif
endif

	@$(call install_finish, ntpclient)
	@$(call touch)

# vim: syntax=make
