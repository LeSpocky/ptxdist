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
PACKAGES-$(PTXCONF_LIBNETFILTER_CTHELPER) += libnetfilter_cthelper

#
# Paths and names
#
LIBNETFILTER_CTHELPER_VERSION	:= 1.0.1
LIBNETFILTER_CTHELPER_MD5	:= e59279645fe65d40dd7dfc82a797ca5b
LIBNETFILTER_CTHELPER		:= libnetfilter_cthelper-$(LIBNETFILTER_CTHELPER_VERSION)
LIBNETFILTER_CTHELPER_SUFFIX	:= tar.bz2
LIBNETFILTER_CTHELPER_URL	:= https://ftp.netfilter.org/pub/libnetfilter_cthelper/$(LIBNETFILTER_CTHELPER).$(LIBNETFILTER_CTHELPER_SUFFIX)
LIBNETFILTER_CTHELPER_SOURCE	:= $(SRCDIR)/$(LIBNETFILTER_CTHELPER).$(LIBNETFILTER_CTHELPER_SUFFIX)
LIBNETFILTER_CTHELPER_DIR	:= $(BUILDDIR)/$(LIBNETFILTER_CTHELPER)
LIBNETFILTER_CTHELPER_LICENSE	:= GPL-2.0-or-later
LIBNETFILTER_CTHELPER_LICENSE_FILES	:= \
	file://COPYING;md5=8ca43cbc842c2336e835926c2166c28b

#
# autoconf
#
LIBNETFILTER_CTHELPER_CONF_TOOL	:= autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libnetfilter_cthelper.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libnetfilter_cthelper)
	@$(call install_fixup, libnetfilter_cthelper,PRIORITY,optional)
	@$(call install_fixup, libnetfilter_cthelper,SECTION,base)
	@$(call install_fixup, libnetfilter_cthelper,AUTHOR,"Ladislav Michl <ladis@triops.cz>")
	@$(call install_fixup, libnetfilter_cthelper,DESCRIPTION,missing)

	@$(call install_lib, libnetfilter_cthelper, 0, 0, 0644, libnetfilter_cthelper)

	@$(call install_finish, libnetfilter_cthelper)
	@$(call touch)
