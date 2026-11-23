# -*-makefile-*-
#
# Copyright (C) 2005 by Christian Gagneraud <chgans@gna.org>
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_RAWREC) += rawrec

#
# Paths and names
#
RAWREC_VERSION		:= 0.9.991
RAWREC_SHA256		:= 1b65d65ae5f11650cc9cd2c10d54ac379eaaa802b89b08423b6a95046faac03f
RAWREC			:= rawrec-$(RAWREC_VERSION)
RAWREC_SUFFIX		:= tar.gz
RAWREC_URL		:= $(call ptx/mirror, SF, rawrec/$(RAWREC).$(RAWREC_SUFFIX))
RAWREC_SOURCE		:= $(SRCDIR)/$(RAWREC).$(RAWREC_SUFFIX)
RAWREC_DIR		:= $(BUILDDIR)/$(RAWREC)
RAWREC_LICENSE		:= GPL-2.0-or-later
RAWREC_LICENSE_FILES	:= \
	file://copyright;md5=feae33512e77544b2c8fc53279b196dc \
	file://src/main.c;startline=1;endline=1;md5=1ba23e1d63e5feb0f265af0dd4ad4188

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

RAWREC_MAKE_ENV	:= $(CROSS_ENV)
RAWREC_MAKE_OPT	:= \
	CC=$(CROSS_CC) \
	DEBUGFLAGS=
RAWREC_SUBDIR	:= src

RAWREC_INSTALL_OPT	:= EXE_DIR=$(RAWREC_PKGDIR)/usr/bin bin_install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/rawrec.targetinstall:
	@$(call targetinfo)

	@$(call install_init, rawrec)
	@$(call install_fixup, rawrec,PRIORITY,optional)
	@$(call install_fixup, rawrec,SECTION,base)
	@$(call install_fixup, rawrec,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, rawrec,DESCRIPTION,missing)

	@$(call install_copy, rawrec, 0, 0, 0755, -, /usr/bin/rawrec)
	@$(call install_link, rawrec, rawrec, /usr/bin/rawplay)

	@$(call install_finish, rawrec)

	@$(call touch)

# vim: syntax=make
