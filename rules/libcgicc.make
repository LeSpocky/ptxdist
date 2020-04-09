# -*-makefile-*-
#
# Copyright (C) 2005 by Alessio Igor Bogani
#               2008, 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBCGICC) += libcgicc

#
# Paths and names
#
LIBCGICC_VERSION	:= 3.2.19
LIBCGICC_MD5		:= a795531556aef314018834981a1466c9
LIBCGICC		:= cgicc-$(LIBCGICC_VERSION)
LIBCGICC_SUFFIX		:= tar.gz
LIBCGICC_URL		:= $(call ptx/mirror, GNU, cgicc/$(LIBCGICC).$(LIBCGICC_SUFFIX))
LIBCGICC_SOURCE		:= $(SRCDIR)/$(LIBCGICC).$(LIBCGICC_SUFFIX)
LIBCGICC_DIR		:= $(BUILDDIR)/$(LIBCGICC)
LIBCGICC_LICENSE	:= LGPL-3.0-or-later AND GFDL-1.2
LIBCGICC_LICENSE_FILES	:= \
	file://cgicc/Cgicc.cpp;md5=ef3b35fffb8b4e9cedc6e796bca50756;startline=9;endline=22 \
	file://COPYING.DOC;md5=a923195d9202d0665777c5ab55746c5b \
	file://COPYING.LIB;md5=60627c3fa530266bd8c2d1f15b554b86

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBCGICC_PATH	:= PATH=$(CROSS_PATH)
LIBCGICC_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBCGICC_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libcgicc.targetinstall:

	@$(call targetinfo)
	@$(call install_init, libcgicc)
	@$(call install_fixup, libcgicc,PRIORITY,optional)
	@$(call install_fixup, libcgicc,SECTION,base)
	@$(call install_fixup, libcgicc,AUTHOR,"Carsten Schlote <c.schlote@konzeptpark.de>")
	@$(call install_fixup, libcgicc,DESCRIPTION,missing)

	@$(call install_lib, libcgicc, 0,0, 644, libcgicc)

	@$(call install_finish, libcgicc)

	@$(call touch)

# vim: syntax=make
