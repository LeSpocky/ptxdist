# -*-makefile-*-
#
# Copyright (C) 2026 by RACOM s.r.o.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBNETFILTER_CTTIMEOUT) += libnetfilter_cttimeout

#
# Paths and names
#
LIBNETFILTER_CTTIMEOUT_VERSION	:= 1.0.1
LIBNETFILTER_CTTIMEOUT_SHA256	:= 0b59da2f3204e1c80cb85d1f6d72285fc07b01a2f5678abf5dccfbbefd650325
LIBNETFILTER_CTTIMEOUT		:= libnetfilter_cttimeout-$(LIBNETFILTER_CTTIMEOUT_VERSION)
LIBNETFILTER_CTTIMEOUT_SUFFIX	:= tar.bz2
LIBNETFILTER_CTTIMEOUT_URL	:= https://ftp.netfilter.org/pub/libnetfilter_cttimeout/$(LIBNETFILTER_CTTIMEOUT).$(LIBNETFILTER_CTTIMEOUT_SUFFIX)
LIBNETFILTER_CTTIMEOUT_SOURCE	:= $(SRCDIR)/$(LIBNETFILTER_CTTIMEOUT).$(LIBNETFILTER_CTTIMEOUT_SUFFIX)
LIBNETFILTER_CTTIMEOUT_DIR	:= $(BUILDDIR)/$(LIBNETFILTER_CTTIMEOUT)
LIBNETFILTER_CTTIMEOUT_LICENSE	:= GPL-2.0-or-later
LIBNETFILTER_CTTIMEOUT_LICENSE_FILES	:= \
	file://COPYING;md5=8ca43cbc842c2336e835926c2166c28b

#
# autoconf
#
LIBNETFILTER_CTTIMEOUT_CONF_TOOL	:= autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libnetfilter_cttimeout.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libnetfilter_cttimeout)
	@$(call install_fixup, libnetfilter_cttimeout,PRIORITY,optional)
	@$(call install_fixup, libnetfilter_cttimeout,SECTION,base)
	@$(call install_fixup, libnetfilter_cttimeout,AUTHOR,"Ladislav Michl <ladis@triops.cz>")
	@$(call install_fixup, libnetfilter_cttimeout,DESCRIPTION,missing)

	@$(call install_lib, libnetfilter_cttimeout, 0, 0, 0644, libnetfilter_cttimeout)

	@$(call install_finish, libnetfilter_cttimeout)
	@$(call touch)

