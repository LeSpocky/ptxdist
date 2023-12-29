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
PACKAGES-$(PTXCONF_LIBDVDREAD) += libdvdread

#
# Paths and names
#
LIBDVDREAD_VERSION	:= 6.1.3
LIBDVDREAD_MD5		:= 3c58d1624a71a16ff40f55dbaca82523
LIBDVDREAD		:= libdvdread-$(LIBDVDREAD_VERSION)
LIBDVDREAD_SUFFIX	:= tar.bz2
LIBDVDREAD_URL		:= https://download.videolan.org/pub/videolan/libdvdread/$(LIBDVDREAD_VERSION)/$(LIBDVDREAD).$(LIBDVDREAD_SUFFIX) 
LIBDVDREAD_SOURCE	:= $(SRCDIR)/$(LIBDVDREAD).$(LIBDVDREAD_SUFFIX)
LIBDVDREAD_DIR		:= $(BUILDDIR)/$(LIBDVDREAD)
LIBDVDREAD_LICENSE	:= GPL-2.0-or-later
LIBDVDREAD_LICENSE_FILES	:= \
	file://COPYING;md5=64e753fa7d1ca31632bc383da3b57c27

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBDVDREAD_CONF_TOOL	:= autoconf
LIBDVDREAD_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-apidoc

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libdvdread.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libdvdread)
	@$(call install_fixup, libdvdread,PRIORITY,optional)
	@$(call install_fixup, libdvdread,SECTION,base)
	@$(call install_fixup, libdvdread,AUTHOR,"Ladislav Michl <ladis@linux-mips.org>")
	@$(call install_fixup, libdvdread,DESCRIPTION,missing)

	@$(call install_lib, libdvdread, 0, 0, 0644, libdvdread)

	@$(call install_finish, libdvdread)

	@$(call touch)

# vim: syntax=make
