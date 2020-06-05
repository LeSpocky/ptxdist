# -*-makefile-*-
#
# Copyright (C) 2006 by Robert Schwebel
#          
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_DAEMONIZE) += daemonize

#
# Paths and names
#
DAEMONIZE_VERSION	:= 1.4
DAEMONIZE_MD5		:= 83e518f5b333f8f0ee57c8751fbe97a1
DAEMONIZE		:= daemonize-$(DAEMONIZE_VERSION)
DAEMONIZE_SUFFIX	:= tar.gz
DAEMONIZE_URL		:= http://www.pengutronix.de/software/ptxdist/temporary-src/$(DAEMONIZE).$(DAEMONIZE_SUFFIX)
DAEMONIZE_SOURCE	:= $(SRCDIR)/$(DAEMONIZE).$(DAEMONIZE_SUFFIX)
DAEMONIZE_DIR		:= $(BUILDDIR)/$(DAEMONIZE)
DAEMONIZE_LICENSE	:= GPL-2.0-only
DAEMONIZE_LICENSE_FILES	:= file://COPYING;md5=94d55d512a9ba36caa9b7df079bae19f


# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

DAEMONIZE_PATH	:= PATH=$(CROSS_PATH)
DAEMONIZE_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
DAEMONIZE_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/daemonize.targetinstall:
	@$(call targetinfo)

	@$(call install_init, daemonize)
	@$(call install_fixup, daemonize,PRIORITY,optional)
	@$(call install_fixup, daemonize,SECTION,base)
	@$(call install_fixup, daemonize,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, daemonize,DESCRIPTION,missing)

	@$(call install_copy, daemonize, 0, 0, 0755, -, \
		/usr/sbin/daemonize)

	@$(call install_finish, daemonize)

	@$(call touch)

# vim: syntax=make
