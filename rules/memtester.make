# -*-makefile-*-
#
# Copyright (C) 2005 by Sascha Hauer
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MEMTESTER) += memtester

#
# Paths and names
#
MEMTESTER_VERSION	:= 4.3.0
MEMTESTER_MD5		:= 598f41b7308e1f736164bca3ab84ddbe
MEMTESTER		:= memtester-$(MEMTESTER_VERSION)
MEMTESTER_SUFFIX	:= tar.gz
MEMTESTER_URL		:= http://pyropus.ca/software/memtester/old-versions/$(MEMTESTER).$(MEMTESTER_SUFFIX)
MEMTESTER_SOURCE	:= $(SRCDIR)/$(MEMTESTER).$(MEMTESTER_SUFFIX)
MEMTESTER_DIR		:= $(BUILDDIR)/$(MEMTESTER)
MEMTESTER_LICENSE	:= GPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

MEMTESTER_PATH := PATH=$(CROSS_PATH)
MEMTESTER_MAKE_ENV := $(CROSS_ENV)

$(STATEDIR)/memtester.prepare:
	@$(call targetinfo)
	@sed -i 's/^cc\>/$(CROSS_CC)/' $(MEMTESTER_DIR)/conf-cc $(MEMTESTER_DIR)/conf-ld
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/memtester.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/memtester.targetinstall:
	@$(call targetinfo)

	@$(call install_init, memtester)
	@$(call install_fixup, memtester,PRIORITY,optional)
	@$(call install_fixup, memtester,SECTION,base)
	@$(call install_fixup, memtester,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, memtester,DESCRIPTION,missing)

	@$(call install_copy, memtester, 0, 0, 0755, $(MEMTESTER_DIR)/memtester, /usr/sbin/memtester)

	@$(call install_finish, memtester)

	@$(call touch)

# vim: syntax=make
