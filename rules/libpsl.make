# -*-makefile-*-
#
# Copyright (C) 2019 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBPSL) += libpsl

#
# Paths and names
#
LIBPSL_VERSION	:= 0.21.5
LIBPSL_MD5	:= 870a798ee9860b6e77896548428dba7b
LIBPSL		:= libpsl-$(LIBPSL_VERSION)
LIBPSL_SUFFIX	:= tar.gz
LIBPSL_URL	:= https://github.com/rockdaboot/libpsl/releases/download/$(LIBPSL_VERSION)/$(LIBPSL).$(LIBPSL_SUFFIX)
LIBPSL_SOURCE	:= $(SRCDIR)/$(LIBPSL).$(LIBPSL_SUFFIX)
LIBPSL_DIR	:= $(BUILDDIR)/$(LIBPSL)
LIBPSL_LICENSE	:= MIT
LIBPSL_LICENSE_FILES := \
	file://COPYING;md5=9f9e317096db2a598fc44237c5b8a4f7

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# Pretend that libidn2 is available. It's not actually used but needed for
# the --enable-builtin=libidn2 configure check.
LIBPSL_CONF_ENV	:= \
	$(CROSS_ENV) \
	ac_cv_search_idn2_lookup_u8= \
	ac_cv_search_u8_tolower=

#
# autoconf
#
LIBPSL_CONF_TOOL	:= autoconf
LIBPSL_CONF_OPT		:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-nls \
	--disable-rpath \
	--disable-gtk-doc \
	--disable-gtk-doc-html \
	--disable-gtk-doc-pdf \
	--disable-man \
	--disable-cfi \
	--disable-ubsan \
	--disable-asan \
	--disable-runtime \
	--enable-builtin=libidn2 \
	--disable-valgrind-tests

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libpsl.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libpsl)
	@$(call install_fixup, libpsl,PRIORITY,optional)
	@$(call install_fixup, libpsl,SECTION,base)
	@$(call install_fixup, libpsl,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, libpsl,DESCRIPTION,missing)

	@$(call install_lib, libpsl, 0, 0, 0644, libpsl)

	@$(call install_finish, libpsl)

	@$(call touch)

# vim: syntax=make
