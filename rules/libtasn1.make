# -*-makefile-*-
#
# Copyright (C) 2013 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBTASN1) += libtasn1

#
# Paths and names
#
LIBTASN1_VERSION	:= 4.20.0
LIBTASN1_MD5		:= 930f71d788cf37505a0327c1b84741be
LIBTASN1		:= libtasn1-$(LIBTASN1_VERSION)
LIBTASN1_SUFFIX		:= tar.gz
LIBTASN1_URL		:= $(call ptx/mirror, GNU, libtasn1/$(LIBTASN1).$(LIBTASN1_SUFFIX))
LIBTASN1_SOURCE		:= $(SRCDIR)/$(LIBTASN1).$(LIBTASN1_SUFFIX)
LIBTASN1_DIR		:= $(BUILDDIR)/$(LIBTASN1)
LIBTASN1_LICENSE	:= GPL-3.0-or-later or LGPL-2.1-or-later
LIBTASN1_LICENSE_FILES	:= \
	file://COPYING;md5=1ebbd3e34237af26da5dc08a4e440464 \
	file://COPYING.LESSERv2;md5=4bf661c1e3793e55c8d1051bc5e0ae21 \
	file://src/asn1Decoding.c;startline=2;endline=19;md5=0f8220e37b07ef6094c916bf78630262 \
	file://lib/decoding.c;startline=1;endline=19;md5=c157bbdf0f0275a2f313aee933e95aa7

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBTASN1_CONF_TOOL := autoconf
LIBTASN1_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-doc \
	--disable-gtk-doc \
	--disable-gtk-doc-html \
	--disable-gtk-doc-pdf \
	--disable-valgrind-tests \
	--disable-code-coverage \
	--disable-gcc-warnings \
	--$(call ptx/endis, PTXDIST_Y2038)-year2038

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libtasn1.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libtasn1)
	@$(call install_fixup, libtasn1,PRIORITY,optional)
	@$(call install_fixup, libtasn1,SECTION,base)
	@$(call install_fixup, libtasn1,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, libtasn1,DESCRIPTION,missing)

	@$(call install_lib, libtasn1, 0, 0, 0644, libtasn1)

	@$(call install_finish, libtasn1)

	@$(call touch)

# vim: syntax=make
