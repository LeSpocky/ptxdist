# -*-makefile-*-
#
# Copyright (C) 2014 by Guillaume Gourat <guillaume.gourat@nexvision.fr>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GFLAGS) += gflags

#
# Paths and names
#
GFLAGS_VERSION	:= 2.0
GFLAGS_SHA256	:= 8017e7b7841e81f6ac546a57902dc1f90df144f0d1fa6f97d4d9fbf919f48323 6e7193fcebf392fa17514764f7993fdba1e8017fd5107037d39934fb48e98c6f
GFLAGS		:= gflags-$(GFLAGS_VERSION)
GFLAGS_SUFFIX	:= tar.gz
GFLAGS_URL	:= https://github.com/gflags/gflags/archive/v$(GFLAGS_VERSION).$(GFLAGS_SUFFIX)
GFLAGS_SOURCE	:= $(SRCDIR)/$(GFLAGS)-no-svn-files.$(GFLAGS_SUFFIX)
GFLAGS_DIR	:= $(BUILDDIR)/$(GFLAGS)
GFLAGS_LICENSE	:= BSD-3-Clause

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GFLAGS_CONF_TOOL	:= autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gflags.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gflags)
	@$(call install_fixup, gflags,PRIORITY,optional)
	@$(call install_fixup, gflags,SECTION,base)
	@$(call install_fixup, gflags,AUTHOR,"Guillaume Gourat <guillaume.gourat@nexvision.fr>")
	@$(call install_fixup, gflags,DESCRIPTION,missing)

	@$(call install_lib, gflags, 0, 0, 0644, libgflags)

	@$(call install_finish, gflags)

	@$(call touch)

# vim: syntax=make
