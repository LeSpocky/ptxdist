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
LIBTASN1_VERSION	:= 4.16.0
LIBTASN1_MD5		:= 531208de3729d42e2af0a32890f08736
LIBTASN1		:= libtasn1-$(LIBTASN1_VERSION)
LIBTASN1_SUFFIX		:= tar.gz
LIBTASN1_URL		:= $(call ptx/mirror, GNU, libtasn1/$(LIBTASN1).$(LIBTASN1_SUFFIX))
LIBTASN1_SOURCE		:= $(SRCDIR)/$(LIBTASN1).$(LIBTASN1_SUFFIX)
LIBTASN1_DIR		:= $(BUILDDIR)/$(LIBTASN1)
LIBTASN1_LICENSE	:= LGPL-2.1-only AND GPL-3.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBTASN1_CONF_TOOL := autoconf

LIBTASN1_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--disable-doc \
	--disable-gtk-doc \
	--disable-gtk-doc-html \
	--disable-gtk-doc-pdf \
	--disable-valgrind-tests \
	--disable-code-coverage \
	--disable-gcc-warnings

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
