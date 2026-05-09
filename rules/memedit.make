# -*-makefile-*-
#
# Copyright (C) 2004 by Robert Schwebel
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MEMEDIT) += memedit

#
# Paths and names
#
MEMEDIT_VERSION	:= 0.9
MEMEDIT_SHA256	:= 3ec778338d0d4f2351ad291b607ea1a4ac2391763cbf7870ff5357305c4a86ae
MEMEDIT_LICENSE	:= GPL-2.0-only
MEMEDIT		:= memedit-$(MEMEDIT_VERSION)
MEMEDIT_SUFFIX	:= tar.gz
MEMEDIT_URL	:= http://www.pengutronix.de/software/memedit/downloads/$(MEMEDIT).$(MEMEDIT_SUFFIX)
MEMEDIT_SOURCE	:= $(SRCDIR)/$(MEMEDIT).$(MEMEDIT_SUFFIX)
MEMEDIT_DIR	:= $(BUILDDIR)/$(MEMEDIT)


# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
MEMEDIT_CONF_TOOL := autoconf
MEMEDIT_CONF_OPT := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/memedit.targetinstall:
	@$(call targetinfo)

	@$(call install_init, memedit)
	@$(call install_fixup, memedit,PRIORITY,optional)
	@$(call install_fixup, memedit,SECTION,base)
	@$(call install_fixup, memedit,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, memedit,DESCRIPTION,missing)

	@$(call install_copy, memedit, 0, 0, 0755, -, /usr/bin/memedit)

	@$(call install_finish, memedit)

	@$(call touch)

# vim: syntax=make
