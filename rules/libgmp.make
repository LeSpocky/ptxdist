# -*-makefile-*-
#
# Copyright (C) 2007 by Carsten Schlote <c.schlote@konzeptpark.de>
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBGMP) += libgmp

#
# Paths and names
#
LIBGMP_VERSION	:= 6.3.0
LIBGMP_MD5	:= c1cd6ef33085e9cb818b9b08371f9000
LIBGMP		:= gmp-$(LIBGMP_VERSION)
LIBGMP_SUFFIX	:= tar.bz2
LIBGMP_URL	:= $(call ptx/mirror, GNU, gmp/$(LIBGMP).$(LIBGMP_SUFFIX))
LIBGMP_SOURCE	:= $(SRCDIR)/$(LIBGMP).$(LIBGMP_SUFFIX)
LIBGMP_DIR	:= $(BUILDDIR)/$(LIBGMP)
LIBGMP_LICENSE	:= GPL-2.0-or-later OR LGPL-3.0-or-later
LIBGMP_LICENSE_FILES := \
	file://README;startline=1;endline=27;md5=20e1eb0dbe1e7dba4f5934a132360fe9 \
	file://COPYING.LESSERv3;md5=6a6a8e020838b23406c81b19c1d46df6 \
	file://COPYINGv2;md5=b234ee4d69f5fce4486a80fdaf4a4263 \
	file://COPYINGv3;md5=11cc2d3ee574f9d6b7ee797bdce4d423

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBGMP_CONF_TOOL	:= autoconf
# libgmp autoconf guesses target arch and sets CFLAGS to options leading
# to crashes on at least armv5te, so override those CFLAGS with working
# ones, replacing the wrong ones set by libgmp in the first place
LIBGMP_CONF_ENV     := \
    CFLAGS='-O2 -pedantic -g'
LIBGMP_CONF_OPT		:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-assert \
	--enable-alloca \
	--disable-cxx \
	--enable-assembly \
	--enable-fft \
	--disable-old-fft-full \
	--disable-nails \
	--disable-profiling \
	--disable-fat \
	--disable-minithres \
	--disable-fake-cpuid \
	--enable-shared \
	--disable-static \
	--without-readline

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libgmp.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libgmp)
	@$(call install_fixup, libgmp,PRIORITY,optional)
	@$(call install_fixup, libgmp,SECTION,base)
	@$(call install_fixup, libgmp,AUTHOR,"Carsten Schlote <c.schlote@konzeptpark.de>")
	@$(call install_fixup, libgmp,DESCRIPTION,missing)

	@$(call install_lib, libgmp, 0, 0, 0644, libgmp)

	@$(call install_finish, libgmp)

	@$(call touch)

# vim: syntax=make
