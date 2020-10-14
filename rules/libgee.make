# -*-makefile-*-
#
# Copyright (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBGEE) += libgee

#
# Paths and names
#
LIBGEE_VERSION	:= 0.5.1
LIBGEE_MD5	:= 59789b5b266beadfb8b51bf2c96211b3
LIBGEE		:= libgee-$(LIBGEE_VERSION)
LIBGEE_SUFFIX	:= tar.bz2
LIBGEE_URL	:= $(call ptx/mirror, GNOME, libgee/$(basename $(LIBGEE_VERSION))/$(LIBGEE).$(LIBGEE_SUFFIX))
LIBGEE_SOURCE	:= $(SRCDIR)/$(LIBGEE).$(LIBGEE_SUFFIX)
LIBGEE_DIR	:= $(BUILDDIR)/$(LIBGEE)
LIBGEE_LICENSE	:= LGPL-2.1-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# we should not need the vala compiler.
# make sure it fails if it is caled anyways.
LIBGEE_CONF_ENV	:= $(CROSS_ENV) ac_cv_path_VALAC=false

#
# autoconf
#
LIBGEE_CONF_TOOL	:= autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libgee.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  libgee)
	@$(call install_fixup, libgee,PRIORITY,optional)
	@$(call install_fixup, libgee,SECTION,base)
	@$(call install_fixup, libgee,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, libgee,DESCRIPTION,missing)

	@$(call install_lib, libgee, 0, 0, 0644, libgee)

	@$(call install_finish, libgee)

	@$(call touch)

# vim: syntax=make
