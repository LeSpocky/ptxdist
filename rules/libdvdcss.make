# -*-makefile-*-
#
# Copyright (C) 2023 by Ladislav Michl <ladis@linux-mips.org>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBDVDCSS) += libdvdcss

#
# Paths and names
#
LIBDVDCSS_VERSION	:= 1.4.3
LIBDVDCSS_SHA256	:= 233cc92f5dc01c5d3a96f5b3582be7d5cee5a35a52d3a08158745d3d86070079
LIBDVDCSS		:= libdvdcss-$(LIBDVDCSS_VERSION)
LIBDVDCSS_SUFFIX	:= tar.bz2
LIBDVDCSS_URL		:= https://download.videolan.org/pub/libdvdcss/$(LIBDVDCSS_VERSION)/$(LIBDVDCSS).$(LIBDVDCSS_SUFFIX)
LIBDVDCSS_SOURCE	:= $(SRCDIR)/$(LIBDVDCSS).$(LIBDVDCSS_SUFFIX)
LIBDVDCSS_DIR		:= $(BUILDDIR)/$(LIBDVDCSS)
LIBDVDCSS_LICENSE	:= GPL-2.0-or-later
LIBDVDCSS_LICENSE_FILES	:= \
	file://COPYING;md5=b234ee4d69f5fce4486a80fdaf4a4263

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBDVDCSS_CONF_TOOL	:= autoconf
LIBDVDCSS_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-doc

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libdvdcss.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libdvdcss)
	@$(call install_fixup, libdvdcss,PRIORITY,optional)
	@$(call install_fixup, libdvdcss,SECTION,base)
	@$(call install_fixup, libdvdcss,AUTHOR,"Ladislav Michl <ladis@linux-mips.org>")
	@$(call install_fixup, libdvdcss,DESCRIPTION,missing)

	@$(call install_lib, libdvdcss, 0, 0, 0644, libdvdcss)

	@$(call install_finish, libdvdcss)

	@$(call touch)

# vim: syntax=make
