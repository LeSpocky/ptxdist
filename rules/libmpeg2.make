# -*-makefile-*-
#
# Copyright (C) 2009 by Erwin Rol
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBMPEG2) += libmpeg2

#
# Paths and names
#
LIBMPEG2_VERSION	:= 0.5.1
LIBMPEG2_MD5		:= 0f92c7454e58379b4a5a378485bbd8ef
LIBMPEG2		:= libmpeg2-$(LIBMPEG2_VERSION)
LIBMPEG2_SUFFIX		:= tar.gz
LIBMPEG2_URL		:= http://libmpeg2.sourceforge.net/files//$(LIBMPEG2).$(LIBMPEG2_SUFFIX)
LIBMPEG2_SOURCE		:= $(SRCDIR)/$(LIBMPEG2).$(LIBMPEG2_SUFFIX)
LIBMPEG2_DIR		:= $(BUILDDIR)/$(LIBMPEG2)
LIBMPEG2_LICENSE	:= GPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBMPEG2_CONF_TOOL := autoconf
LIBMPEG2_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-debug \
	--disable-accel-detect \
	--disable-sdl \
	--disable-warnings \
	--disable-gprof \
	--without-x

ifdef PTXCONF_ARCH_PPC
LIBMPEG2_CONF_ENV := $(CROSS_ENV) CFLAGS="$(CROSS_CFLAGS) -mno-altivec"
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libmpeg2.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libmpeg2)
	@$(call install_fixup, libmpeg2,PRIORITY,optional)
	@$(call install_fixup, libmpeg2,SECTION,base)
	@$(call install_fixup, libmpeg2,AUTHOR,"Erwin Rol <erwin@erwinrol.com>")
	@$(call install_fixup, libmpeg2,DESCRIPTION,missing)

	@$(call install_lib, libmpeg2, 0, 0, 0644, libmpeg2)
	@$(call install_lib, libmpeg2, 0, 0, 0644, libmpeg2convert)

	@$(call install_finish, libmpeg2)

	@$(call touch)

# vim: syntax=make
