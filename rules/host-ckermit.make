# -*-makefile-*-
#
# Copyright (C) 2008 by Wolfram Sang
#               2011 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_CKERMIT) += host-ckermit

#
# Paths and names
#
HOST_CKERMIT_DIR		= $(HOST_BUILDDIR)/$(CKERMIT)
HOST_CKERMIT_STRIP_LEVEL	:= 0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_CKERMIT_CONF_TOOL	:= NO

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

HOST_CKERMIT_MAKE_OPT := \
	linuxa \
	prefix=/usr \
	KFLAGS='-O2 -DCK_NCURSES -DHAVE_PTMX -DHAVE_OPENPTY -DMAINTYPE=int' \
	LIBS='-lncurses -lutil -lresolv -lcrypt'

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

HOST_CKERMIT_INSTALL_OPT := \
	prefix=/usr \
	install

$(STATEDIR)/host-ckermit.install:
	@$(call targetinfo)
	@$(call world/install, HOST_CKERMIT)
	@ln -sf kermit $(HOST_CKERMIT_PKGDIR)/usr/bin/ckermit
	@install -m755 $(HOST_CKERMIT_DIR)/wart $(HOST_CKERMIT_PKGDIR)/usr/bin/
	@$(call touch)

# vim: syntax=make
