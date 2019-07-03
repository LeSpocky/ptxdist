# -*-makefile-*-
#
# Copyright (C) 2003 by Sascha Hauer <sascha.hauer@gyro-net.de>
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SETMIXER) += setmixer

#
# Paths and names
#
SETMIXER_VERSION	:= 27DEC94ds1
SETMIXER_MD5		:= 2e0792ae48e74933ddcdfc3d42e73cfb
SETMIXER		:= setmixer_$(SETMIXER_VERSION).orig
SETMIXER_SUFFIX		:= tar.gz
SETMIXER_URL		:= http://www.pengutronix.de/software/ptxdist/temporary-src/$(SETMIXER).$(SETMIXER_SUFFIX)
SETMIXER_SOURCE		:= $(SRCDIR)/$(SETMIXER).$(SETMIXER_SUFFIX)
SETMIXER_DIR		:= $(BUILDDIR)/setmixer-27DEC94ds1.orig


# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SETMIXER_PATH		:= PATH=$(CROSS_PATH)
SETMIXER_MAKE_ENV	:= $(CROSS_ENV)
SETMIXER_MAKE_OPT	:= CC=$(CROSS_CC)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/setmixer.targetinstall:
	@$(call targetinfo)

	@$(call install_init, setmixer)
	@$(call install_fixup, setmixer,PRIORITY,optional)
	@$(call install_fixup, setmixer,SECTION,base)
	@$(call install_fixup, setmixer,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, setmixer,DESCRIPTION,missing)

	@$(call install_copy, setmixer, 0, 0, 0755, -, /usr/bin/setmixer)

	@$(call install_finish, setmixer)

	@$(call touch)

# vim: syntax=make
