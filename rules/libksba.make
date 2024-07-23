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
PACKAGES-$(PTXCONF_LIBKSBA) += libksba

#
# Paths and names
#
LIBKSBA_VERSION	:= 1.6.7
LIBKSBA_MD5	:= 7e736de467b67c7ea88de746c31ea12f
LIBKSBA		:= libksba-$(LIBKSBA_VERSION)
LIBKSBA_SUFFIX	:= tar.bz2
LIBKSBA_URL	:= https://www.gnupg.org/ftp/gcrypt/libksba/$(LIBKSBA).$(LIBKSBA_SUFFIX)
LIBKSBA_SOURCE	:= $(SRCDIR)/$(LIBKSBA).$(LIBKSBA_SUFFIX)
LIBKSBA_DIR	:= $(BUILDDIR)/$(LIBKSBA)
LIBKSBA_LICENSE	:= GPL-2.0-only AND GPL-3.0-only AND LGPL-3.0-only
LIBKSBA_LICENSE_FILES := \
	file://COPYING.GPLv2;md5=b234ee4d69f5fce4486a80fdaf4a4263 \
	file://COPYING.GPLv3;md5=2f31b266d3440dd7ee50f92cf67d8e6c \
	file://COPYING.LGPLv3;md5=e6a600fd5e1d9cbde2d983680233ad02

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBKSBA_CONF_TOOL := autoconf
LIBKSBA_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--enable-build-timestamp="$(PTXDIST_BUILD_TIMESTAMP)" \
	--disable-doc \
	--enable-optimization

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libksba.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libksba)
	@$(call install_fixup, libksba,PRIORITY,optional)
	@$(call install_fixup, libksba,SECTION,base)
	@$(call install_fixup, libksba,AUTHOR,"Alexander Stein")
	@$(call install_fixup, libksba,DESCRIPTION,missing)

	@$(call install_lib, libksba, 0, 0, 0644, libksba)

	@$(call install_finish, libksba)

	@$(call touch)

# vim: syntax=make
