# -*-makefile-*-
#
# Copyright (C) 2011 by Bart vdr. Meulen <bartvdrmeulen@gmail.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBNETFILTER_CONNTRACK) += libnetfilter_conntrack

#
# Paths and names
#
LIBNETFILTER_CONNTRACK_VERSION	:= 1.1.1
LIBNETFILTER_CONNTRACK_SHA256	:= 769d3eaf57fa4fbdb05dd12873b6cb9a5be7844d8937e222b647381d44284820
LIBNETFILTER_CONNTRACK		:= libnetfilter_conntrack-$(LIBNETFILTER_CONNTRACK_VERSION)
LIBNETFILTER_CONNTRACK_SUFFIX	:= tar.xz
LIBNETFILTER_CONNTRACK_URL	:= https://ftp.netfilter.org/pub/libnetfilter_conntrack/$(LIBNETFILTER_CONNTRACK).$(LIBNETFILTER_CONNTRACK_SUFFIX)
LIBNETFILTER_CONNTRACK_SOURCE	:= $(SRCDIR)/$(LIBNETFILTER_CONNTRACK).$(LIBNETFILTER_CONNTRACK_SUFFIX)
LIBNETFILTER_CONNTRACK_DIR	:= $(BUILDDIR)/$(LIBNETFILTER_CONNTRACK)
LIBNETFILTER_CONNTRACK_LICENSE	:= GPL-2.0-or-later
LIBNETFILTER_CONNTRACK_LICENSE_FILES	:= \
	file://COPYING;md5=8ca43cbc842c2336e835926c2166c28b

#
# autoconf
#
LIBNETFILTER_CONNTRACK_CONF_TOOL	:= autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libnetfilter_conntrack.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libnetfilter_conntrack)
	@$(call install_fixup, libnetfilter_conntrack,PRIORITY,optional)
	@$(call install_fixup, libnetfilter_conntrack,SECTION,base)
	@$(call install_fixup, libnetfilter_conntrack,AUTHOR,"Bart vdr. Meulen <bartvdrmeulen@gmail.com>")
	@$(call install_fixup, libnetfilter_conntrack,DESCRIPTION,missing)

	@$(call install_lib, libnetfilter_conntrack, 0, 0, 0644, libnetfilter_conntrack)

	@$(call install_finish, libnetfilter_conntrack)
	@$(call touch)

