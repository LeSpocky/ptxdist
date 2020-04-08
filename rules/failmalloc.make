# -*-makefile-*-
#
# Copyright (C) 2009 by Juergen Beisert
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_FAILMALLOC) += failmalloc

#
# Paths and names
#
FAILMALLOC_VERSION	:= 1.0
FAILMALLOC_MD5		:= eae617cb8d800dc17efe55b26565a7e2
FAILMALLOC		:= failmalloc-$(FAILMALLOC_VERSION)
FAILMALLOC_SUFFIX	:= tar.gz
FAILMALLOC_URL		:= http://download.savannah.nongnu.org/releases/failmalloc/$(FAILMALLOC).$(FAILMALLOC_SUFFIX)
FAILMALLOC_SOURCE	:= $(SRCDIR)/$(FAILMALLOC).$(FAILMALLOC_SUFFIX)
FAILMALLOC_DIR		:= $(BUILDDIR)/$(FAILMALLOC)
FAILMALLOC_LICENSE	:= LGPL-2.1-or-later
FAILMALLOC_LICENSE_FILES	:= \
	file://failmalloc.c;md5=9b4aa792b46eded7ca560d0f1a2d96a5;startline=3;endline=18 \
	file://COPYING;md5=fbc093901857fcd118f065f900982c24

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

FAILMALLOC_PATH	:= PATH=$(CROSS_PATH)
FAILMALLOC_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
FAILMALLOC_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-static=no

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/failmalloc.targetinstall:
	@$(call targetinfo)

	@$(call install_init, failmalloc)
	@$(call install_fixup, failmalloc,PRIORITY,optional)
	@$(call install_fixup, failmalloc,SECTION,base)
	@$(call install_fixup, failmalloc,AUTHOR,"Juergen Beisert <j.beisert@pengutronix.de>")
	@$(call install_fixup, failmalloc,DESCRIPTION,missing)

	@$(call install_lib, failmalloc, 0, 0, 0644, libfailmalloc)

	@$(call install_finish, failmalloc)

	@$(call touch)

# vim: syntax=make
