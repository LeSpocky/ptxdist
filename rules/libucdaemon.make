# -*-makefile-*-
#
# Copyright (C) 2008 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBUCDAEMON) += libucdaemon

#
# Paths and names
#
LIBUCDAEMON_VERSION	:= 0.0.5
LIBUCDAEMON_MD5		:= 78ec4581a76692ebe31c7f8c78f4a026
LIBUCDAEMON		:= libucdaemon-$(LIBUCDAEMON_VERSION)
LIBUCDAEMON_SUFFIX	:= tar.bz2
LIBUCDAEMON_URL		:= http://www.pengutronix.de/software/libucdaemon/download/$(LIBUCDAEMON).$(LIBUCDAEMON_SUFFIX)
LIBUCDAEMON_SOURCE	:= $(SRCDIR)/$(LIBUCDAEMON).$(LIBUCDAEMON_SUFFIX)
LIBUCDAEMON_DIR		:= $(BUILDDIR)/$(LIBUCDAEMON)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBUCDAEMON_PATH	:= PATH=$(CROSS_PATH)
LIBUCDAEMON_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBUCDAEMON_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libucdaemon.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libucdaemon)
	@$(call install_fixup, libucdaemon,PRIORITY,optional)
	@$(call install_fixup, libucdaemon,SECTION,base)
	@$(call install_fixup, libucdaemon,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libucdaemon,DESCRIPTION,missing)

	@$(call install_lib, libucdaemon, 0, 0, 0644, libucdaemon)

	@$(call install_finish, libucdaemon)

	@$(call touch)

# vim: syntax=make
