# -*-makefile-*-
#
# Copyright (C) 2007 by Michael Olbrich <m.olbrich@pengutronix.de>
#               2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ARGTABLE2) += argtable2

#
# Paths and names
#
ARGTABLE2_VERSION	:= 12
ARGTABLE2_MD5		:= 291e249ea60f4d0637e467356a8ae41a
ARGTABLE2		:= argtable2-$(ARGTABLE2_VERSION)
ARGTABLE2_SUFFIX	:= tar.gz
ARGTABLE2_URL		:= $(call ptx/mirror, SF, argtable/$(ARGTABLE2).$(ARGTABLE2_SUFFIX))
ARGTABLE2_SOURCE	:= $(SRCDIR)/$(ARGTABLE2).$(ARGTABLE2_SUFFIX)
ARGTABLE2_DIR		:= $(BUILDDIR)/$(ARGTABLE2)
ARGTABLE2_LICENSE	:= LGPL-2.0-or-later
ARGTABLE2_LICENSE_FILES	:= \
	file://COPYING;md5=f30a9716ef3762e3467a2f62bf790f0a \
	file://src/argtable2.c;startline=6;endline=14;md5=955d1d74393b5b5850210927b08a069a

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
ARGTABLE2_CONF_TOOL	:= autoconf
ARGTABLE2_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-debug

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/argtable2.targetinstall:
	@$(call targetinfo)

	@$(call install_init, argtable2)
	@$(call install_fixup, argtable2,PRIORITY,optional)
	@$(call install_fixup, argtable2,SECTION,base)
	@$(call install_fixup, argtable2,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, argtable2,DESCRIPTION,missing)

	@$(call install_lib, argtable2, 0, 0, 0644, libargtable2)

	@$(call install_finish, argtable2)

	@$(call touch)

# vim: syntax=make
