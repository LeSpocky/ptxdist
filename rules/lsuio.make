# -*-makefile-*-
#
# Copyright (C) 2008 by Wolfram Sang
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LSUIO) += lsuio

#
# Paths and names
#
LSUIO_VERSION	:= 0.2.0
LSUIO_MD5	:= 8da82b681c24e6c5b3518c99e7f961d7
LSUIO		:= lsuio-$(LSUIO_VERSION)
LSUIO_SUFFIX	:= tar.gz
LSUIO_URL	:= https://www.osadl.org/uploads/media/$(LSUIO).$(LSUIO_SUFFIX)
LSUIO_SOURCE	:= $(SRCDIR)/$(LSUIO).$(LSUIO_SUFFIX)
LSUIO_DIR	:= $(BUILDDIR)/$(LSUIO)
LSUIO_LICENSE	:= GPL-2.0
LSUIO_LICENSE_FILES := file://COPYING;md5=94d55d512a9ba36caa9b7df079bae19f

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LSUIO_PATH	:= PATH=$(CROSS_PATH)
LSUIO_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LSUIO_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/lsuio.targetinstall:
	@$(call targetinfo)

	@$(call install_init, lsuio)
	@$(call install_fixup, lsuio,PRIORITY,optional)
	@$(call install_fixup, lsuio,SECTION,base)
	@$(call install_fixup, lsuio,AUTHOR,"Wolfram Sang <w.sang@pengutronix.de>")
	@$(call install_fixup, lsuio,DESCRIPTION,missing)

	@$(call install_copy, lsuio, 0, 0, 0755, -, /usr/bin/lsuio)

	@$(call install_finish, lsuio)

	@$(call touch)

# vim: syntax=make
