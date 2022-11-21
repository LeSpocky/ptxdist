# -*-makefile-*-
#
# Copyright (C) 2008 by Juergen Beisert
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBCONFUSE) += libconfuse

#
# Paths and names
#
LIBCONFUSE_VERSION	:= 3.3
LIBCONFUSE_MD5		:= a183cef2cecdd3783436ff8de500d274
LIBCONFUSE		:= confuse-$(LIBCONFUSE_VERSION)
LIBCONFUSE_SUFFIX	:= tar.xz
LIBCONFUSE_URL		:= https://github.com/libconfuse/libconfuse/releases/download/v$(LIBCONFUSE_VERSION)/$(LIBCONFUSE).$(LIBCONFUSE_SUFFIX)
LIBCONFUSE_SOURCE	:= $(SRCDIR)/$(LIBCONFUSE).$(LIBCONFUSE_SUFFIX)
LIBCONFUSE_DIR		:= $(BUILDDIR)/$(LIBCONFUSE)
LIBCONFUSE_LICENSE	:= ISC

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBCONFUSE_CONF_TOOL	:= autoconf
LIBCONFUSE_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-examples \
	--disable-nls

ifdef PTXCONF_LIBCONFUSE_STATIC
LIBCONFUSE_CONF_OPT += --enable-shared=no
else
LIBCONFUSE_CONF_OPT += --enable-shared
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libconfuse.targetinstall:
	@$(call targetinfo)

ifndef PTXCONF_LIBCONFUSE_STATIC
	@$(call install_init, libconfuse)
	@$(call install_fixup, libconfuse,PRIORITY,optional)
	@$(call install_fixup, libconfuse,SECTION,base)
	@$(call install_fixup, libconfuse,AUTHOR,"Juergen Beisert <juergen@kreuzholzen.de>")
	@$(call install_fixup, libconfuse,DESCRIPTION,missing)

	@$(call install_lib, libconfuse, 0, 0, 0644, libconfuse)

	@$(call install_finish, libconfuse)
endif
	@$(call touch)

# vim: syntax=make
