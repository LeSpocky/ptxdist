# -*-makefile-*-
#
# Copyright (C) 2007 by Lars Munch <lars@segv.dk>
#               2010 by Ryan Raasch <ryan.raasch@gmail.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

PACKAGES-$(PTXCONF_LIBMXML) += libmxml

#
# Paths and names
#
LIBMXML_VERSION	:= 2.12
LIBMXML_MD5	:= 35f8416ee2d27ceab653ea2ff64c794c
LIBMXML		:= mxml-$(LIBMXML_VERSION)
LIBMXML_SUFFIX	:= tar.gz
LIBMXML_URL	:= https://github.com/michaelrsweet/mxml/releases/download/v$(LIBMXML_VERSION)/$(LIBMXML).$(LIBMXML_SUFFIX)
# TODO: remove 'v2' with next version bump
# needed for 2.12 because of incompatible tarball changes
LIBMXML_SOURCE	:= $(SRCDIR)/$(LIBMXML)v2.$(LIBMXML_SUFFIX)
LIBMXML_DIR	:= $(BUILDDIR)/mxml-$(LIBMXML_VERSION)
LIBMXML_LICENSE	:= LGPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBMXML_CONF_TOOL := autoconf
LIBMXML_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--disable-debug \
	--enable-threads \
	--enable-shared

# build static lib, too. make install will fail otherwise
LIBMXML_MAKE_OPT := \
	all \
	libmxml.a

LIBMXML_INSTALL_OPT := \
	install \
	DSTROOT=$(LIBMXML_PKGDIR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libmxml.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libmxml)
	@$(call install_fixup, libmxml,PRIORITY,optional)
	@$(call install_fixup, libmxml,SECTION,base)
	@$(call install_fixup, libmxml,AUTHOR,"Ryan Raasch <ryan.raasch@gmail.com>")
	@$(call install_fixup, libmxml,DESCRIPTION,missing)

	@$(call install_lib, libmxml, 0, 0, 0644, libmxml)

	@$(call install_finish, libmxml)

	@$(call touch)

# vim: syntax=make
