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
LIBMXML_VERSION	:= 4.0.4
LIBMXML_MD5	:= 7052a4bee080d2d86c40a95c9d5d88bc
LIBMXML		:= mxml-$(LIBMXML_VERSION)
LIBMXML_SUFFIX	:= tar.gz
LIBMXML_URL	:= https://github.com/michaelrsweet/mxml/releases/download/v$(LIBMXML_VERSION)/$(LIBMXML).$(LIBMXML_SUFFIX)
LIBMXML_SOURCE	:= $(SRCDIR)/$(LIBMXML).$(LIBMXML_SUFFIX)
LIBMXML_DIR	:= $(BUILDDIR)/mxml-$(LIBMXML_VERSION)
LIBMXML_LICENSE	:= Apache-2.0 WITH custom-exception
LIBMXML_LICENSE_FILES := \
	file://LICENSE;md5=86d3f3a95c324c9479bd8986968f4327 \
	file://NOTICE;md5=198bc141b16768396565a8a372f3d94e

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBMXML_CONF_TOOL := autoconf
LIBMXML_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--enable-threads \
	--enable-shared \
	--disable-debug \
	--disable-maintainer

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

	@$(call install_lib, libmxml, 0, 0, 0644, libmxml4)

	@$(call install_finish, libmxml)

	@$(call touch)

# vim: syntax=make
