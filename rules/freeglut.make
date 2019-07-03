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
PACKAGES-$(PTXCONF_FREEGLUT) += freeglut

#
# Paths and names
#
FREEGLUT_VERSION	:= 2.8.1
FREEGLUT_MD5		:= 918ffbddcffbac83c218bc52355b6d5a
FREEGLUT		:= freeglut-$(FREEGLUT_VERSION)
FREEGLUT_SUFFIX		:= tar.gz
FREEGLUT_URL		:= $(call ptx/mirror, SF, freeglut/$(FREEGLUT).$(FREEGLUT_SUFFIX))
FREEGLUT_SOURCE		:= $(SRCDIR)/$(FREEGLUT).$(FREEGLUT_SUFFIX)
FREEGLUT_DIR		:= $(BUILDDIR)/$(FREEGLUT)
FREEGLUT_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
FREEGLUT_CONF_TOOL	:= autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/freeglut.targetinstall:
	@$(call targetinfo)

	@$(call install_init, freeglut)
	@$(call install_fixup, freeglut,PRIORITY,optional)
	@$(call install_fixup, freeglut,SECTION,base)
	@$(call install_fixup, freeglut,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, freeglut,DESCRIPTION,missing)

	@$(call install_lib, freeglut, 0, 0, 0644, libglut)

	@$(call install_finish, freeglut)

	@$(call touch)

# vim: syntax=make
