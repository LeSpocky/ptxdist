# -*-makefile-*-
#
# Copyright (C) 2007 by Roland Hostettler
#               2010 Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_FBGRAB) += fbgrab

#
# Paths and names
#
FBGRAB_VERSION	:= 1.3.1
FBGRAB_MD5	:= d2f1f9a096954c252335317216dcd501
FBGRAB		:= fbgrab-$(FBGRAB_VERSION)
FBGRAB_SUFFIX	:= tar.gz
FBGRAB_URL	:= https://github.com/GunnarMonell/fbgrab/archive/$(FBGRAB_VERSION).$(FBGRAB_SUFFIX)
FBGRAB_SOURCE	:= $(SRCDIR)/$(FBGRAB).$(FBGRAB_SUFFIX)
FBGRAB_DIR	:= $(BUILDDIR)/$(FBGRAB)
FBGRAB_LICENSE	:= GPL-2.0-only
FBGRAB_LICENSE_FILES	:= \
	file://COPYING;md5=ea5bed2f60d357618ca161ad539f7c0a \
	file://fbgrab.c;startline=6;endline=6;md5=03e379b2e488fbda4e42aa556e9cec93

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

FBGRAB_CONF_TOOL := NO

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

FBGRAB_MAKE_ENV := $(CROSS_ENV_CC)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/fbgrab.targetinstall:
	@$(call targetinfo)

	@$(call install_init, fbgrab)
	@$(call install_fixup, fbgrab,PRIORITY,optional)
	@$(call install_fixup, fbgrab,SECTION,base)
	@$(call install_fixup, fbgrab,AUTHOR,"Roland Hostettler <r.hostettler@gmx.ch>")
	@$(call install_fixup, fbgrab,DESCRIPTION,missing)

	@$(call install_copy, fbgrab, 0, 0, 0755, -, /usr/bin/fbgrab)

	@$(call install_finish, fbgrab)

	@$(call touch)

# vim: syntax=make
