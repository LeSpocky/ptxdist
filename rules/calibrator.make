# -*-makefile-*-
#
# Copyright (C) 2007 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_CALIBRATOR) += calibrator

#
# Paths and names
#
CALIBRATOR_VERSION	:= 20070821-1
CALIBRATOR_MD5		:= b26765e360144e951f4924aed6e6d45c
CALIBRATOR		:= calibrator-$(CALIBRATOR_VERSION)
CALIBRATOR_SUFFIX	:= tar.bz2
CALIBRATOR_URL		:= http://www.pengutronix.de/software/ptxdist/temporary-src/$(CALIBRATOR).$(CALIBRATOR_SUFFIX)
CALIBRATOR_SOURCE	:= $(SRCDIR)/$(CALIBRATOR).$(CALIBRATOR_SUFFIX)
CALIBRATOR_DIR		:= $(BUILDDIR)/$(CALIBRATOR)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

CALIBRATOR_PATH		:= PATH=$(CROSS_PATH)
CALIBRATOR_MAKE_ENV	:= $(CROSS_ENV) LDLIBS=-lm
CALIBRATOR_MAKE_OPT	:= calibrator

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/calibrator.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/calibrator.targetinstall:
	@$(call targetinfo)

	@$(call install_init, calibrator)
	@$(call install_fixup, calibrator,PRIORITY,optional)
	@$(call install_fixup, calibrator,SECTION,base)
	@$(call install_fixup, calibrator,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, calibrator,DESCRIPTION,missing)

	@$(call install_copy, calibrator, 0, 0, 0755, $(CALIBRATOR_DIR)/calibrator, /usr/bin/calibrator)

	@$(call install_finish, calibrator)

	@$(call touch)

# vim: syntax=make
