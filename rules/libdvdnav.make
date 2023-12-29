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
PACKAGES-$(PTXCONF_LIBDVDNAV) += libdvdnav

#
# Paths and names
#
LIBDVDNAV_VERSION	:= 6.1.1
LIBDVDNAV_MD5		:= 46c46cb0294fbd1fcb8a0181818dad15
LIBDVDNAV		:= libdvdnav-$(LIBDVDNAV_VERSION)
LIBDVDNAV_SUFFIX	:= tar.bz2
LIBDVDNAV_URL		:= https://download.videolan.org/pub/videolan/libdvdnav/$(LIBDVDNAV_VERSION)/$(LIBDVDNAV).$(LIBDVDNAV_SUFFIX) 
LIBDVDNAV_SOURCE	:= $(SRCDIR)/$(LIBDVDNAV).$(LIBDVDNAV_SUFFIX)
LIBDVDNAV_DIR		:= $(BUILDDIR)/$(LIBDVDNAV)
LIBDVDNAV_LICENSE	:= GPL-2.0-or-later
LIBDVDNAV_LICENSE_FILES	:= \
	file://COPYING;md5=94d55d512a9ba36caa9b7df079bae19f

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBDVDNAV_CONF_TOOL	:= autoconf
LIBDVDNAV_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libdvdnav.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libdvdnav)
	@$(call install_fixup, libdvdnav,PRIORITY,optional)
	@$(call install_fixup, libdvdnav,SECTION,base)
	@$(call install_fixup, libdvdnav,AUTHOR,"Ladislav Michl <ladis@linux-mips.org>")
	@$(call install_fixup, libdvdnav,DESCRIPTION,missing)

	@$(call install_lib, libdvdnav, 0, 0, 0644, libdvdnav)

	@$(call install_finish, libdvdnav)

	@$(call touch)

# vim: syntax=make
