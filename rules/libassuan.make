# -*-makefile-*-
#
# Copyright (C) 2010 by Alexander Stein <alexander.stein@systec-electronic.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBASSUAN) += libassuan

#
# Paths and names
#
LIBASSUAN_VERSION	:= 3.0.1
LIBASSUAN_MD5		:= 6f0d239302ae3b8d4aefcb499b137530
LIBASSUAN		:= libassuan-$(LIBASSUAN_VERSION)
LIBASSUAN_SUFFIX	:= tar.bz2
LIBASSUAN_URL		:= https://www.gnupg.org/ftp/gcrypt/libassuan/$(LIBASSUAN).$(LIBASSUAN_SUFFIX)
LIBASSUAN_SOURCE	:= $(SRCDIR)/$(LIBASSUAN).$(LIBASSUAN_SUFFIX)
LIBASSUAN_DIR		:= $(BUILDDIR)/$(LIBASSUAN)
LIBASSUAN_LICENSE	:= LGPL-2.1-or-later
LIBASSUAN_LICENSE_FILES	:= \
	file://COPYING.LIB;md5=2d5025d4aa3495befef8f17206a5b0a1

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBASSUAN_CONF_TOOL := autoconf
LIBASSUAN_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--enable-build-timestamp="$(PTXDIST_BUILD_TIMESTAMP)" \
	--disable-doc

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libassuan.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libassuan)
	@$(call install_fixup, libassuan,PRIORITY,optional)
	@$(call install_fixup, libassuan,SECTION,base)
	@$(call install_fixup, libassuan,AUTHOR,"Alexander Stein")
	@$(call install_fixup, libassuan,DESCRIPTION,missing)

	@$(call install_lib, libassuan, 0, 0, 0644, libassuan)

	@$(call install_finish, libassuan)

	@$(call touch)

# vim: syntax=make
