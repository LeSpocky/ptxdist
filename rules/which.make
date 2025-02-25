# -*-makefile-*-
#
# Copyright (C) 2013 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_WHICH) += which

#
# Paths and names
#
WHICH_VERSION	:= 2.21
WHICH_MD5	:= 097ff1a324ae02e0a3b0369f07a7544a
WHICH		:= which-$(WHICH_VERSION)
WHICH_SUFFIX	:= tar.gz
WHICH_URL	:= $(call ptx/mirror, GNU, which/$(WHICH).$(WHICH_SUFFIX))
WHICH_SOURCE	:= $(SRCDIR)/$(WHICH).$(WHICH_SUFFIX)
WHICH_DIR	:= $(BUILDDIR)/$(WHICH)
WHICH_LICENSE	:= GPL-3.0-only
WHICH_LICENSE_FILES := \
	file://COPYING;md5=d32239bcb673463ab874e80d47fae504 \
	file://which.c;startline=3;endline=16;md5=5b09a4bf3cf99f6e73e868cedcb4ef22

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
WHICH_CONF_TOOL	:= autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/which.targetinstall:
	@$(call targetinfo)

	@$(call install_init, which)
	@$(call install_fixup, which,PRIORITY,optional)
	@$(call install_fixup, which,SECTION,base)
	@$(call install_fixup, which,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, which,DESCRIPTION,missing)

	@$(call install_copy, which, 0, 0, 0755, -, /usr/bin/which)

	@$(call install_finish, which)

	@$(call touch)

# vim: syntax=make
