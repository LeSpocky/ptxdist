# -*-makefile-*-
#
# Copyright (C) 2006 by Robert Schwebel
#               2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBDAEMON) += libdaemon

#
# Paths and names
#
LIBDAEMON_VERSION	:= 0.14
LIBDAEMON_SHA256	:= fd23eb5f6f986dcc7e708307355ba3289abe03cc381fc47a80bca4a50aa6b834
LIBDAEMON		:= libdaemon-$(LIBDAEMON_VERSION)
LIBDAEMON_SUFFIX	:= tar.gz
LIBDAEMON_URL		:= http://0pointer.de/lennart/projects/libdaemon/$(LIBDAEMON).$(LIBDAEMON_SUFFIX)
LIBDAEMON_SOURCE	:= $(SRCDIR)/$(LIBDAEMON).$(LIBDAEMON_SUFFIX)
LIBDAEMON_DIR		:= $(BUILDDIR)/$(LIBDAEMON)
LIBDAEMON_LICENSE	:= LGPL-2.1-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBDAEMON_CONF_TOOL	:= autoconf
LIBDAEMON_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-lynx

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libdaemon.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libdaemon)
	@$(call install_fixup, libdaemon,PRIORITY,optional)
	@$(call install_fixup, libdaemon,SECTION,base)
	@$(call install_fixup, libdaemon,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libdaemon,DESCRIPTION,missing)

	@$(call install_lib, libdaemon, 0, 0, 0644, libdaemon)

	@$(call install_finish, libdaemon)

	@$(call touch)

# vim: syntax=make
