# -*-makefile-*-
#
# Copyright (C) 2004 by Robert Schwebel <r.schwebel@pengutronix.de>
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_EFAX) += efax

#
# Paths and names
#
EFAX_VERSION	:= 0.9a-001114
EFAX_SHA256	:= 46abddf13f7565ea0c9d85b92845cdb32fb265c47cfc84c972e11a0219cda8ea
EFAX		:= efax-$(EFAX_VERSION)
EFAX_SUFFIX	:= tar.gz
EFAX_URL	:= https://www.cce.com/efax/download/$(EFAX).$(EFAX_SUFFIX)
EFAX_SOURCE	:= $(SRCDIR)/$(EFAX).$(EFAX_SUFFIX)
EFAX_DIR	:= $(BUILDDIR)/$(EFAX)
EFAX_LICENSE	:= GPL-2.0-or-later
EFAX_LICENSE_FILES	:= \
	file://COPYING;md5=0636e73ff0215e8d672dc4c32c317bb3 \
	file://efax.c;startline=6;endline=20;md5=b9a1fd14cdd1955ed760a882cc1956e9

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

EFAX_MAKE_ENV	:= $(CROSS_ENV)
EFAX_MAKE_OPT	:= CC=$(CROSS_CC)

EFAX_INSTALL_OPT := \
	BINDIR=$(EFAX_PKGDIR)/usr/bin \
	MANDIR=$(EFAX_PKGDIR)/usr/man \
	install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/efax.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  efax)
	@$(call install_fixup, efax,PRIORITY,optional)
	@$(call install_fixup, efax,SECTION,base)
	@$(call install_fixup, efax,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, efax,DESCRIPTION,missing)

	@$(call install_copy, efax, 0, 0, 0755, -, /usr/bin/efax)
	@$(call install_copy, efax, 0, 0, 0755, -, /usr/bin/efix)

	@$(call install_finish, efax)

	@$(call touch)

# vim: syntax=make
