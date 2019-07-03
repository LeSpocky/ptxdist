# -*-makefile-*-
#
# Copyright (C) 2008 by Robert Schwebel
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBOGG) += libogg

#
# Paths and names
#
LIBOGG_VERSION	:= 1.1.4
LIBOGG_MD5	:= 10200ec22543841d9d1c23e0aed4e5e9
LIBOGG		:= libogg-$(LIBOGG_VERSION)
LIBOGG_SUFFIX	:= tar.gz
LIBOGG_URL	:= http://downloads.xiph.org/releases/ogg/$(LIBOGG).$(LIBOGG_SUFFIX)
LIBOGG_SOURCE	:= $(SRCDIR)/$(LIBOGG).$(LIBOGG_SUFFIX)
LIBOGG_DIR	:= $(BUILDDIR)/$(LIBOGG)
LIBOGG_LICENSE	:= BSD-3-Clause

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBOGG_PATH	:= PATH=$(CROSS_PATH)
LIBOGG_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBOGG_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libogg.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libogg)
	@$(call install_fixup, libogg,PRIORITY,optional)
	@$(call install_fixup, libogg,SECTION,base)
	@$(call install_fixup, libogg,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libogg,DESCRIPTION,missing)

	@$(call install_lib, libogg, 0, 0, 0644, libogg)

	@$(call install_finish, libogg)

	@$(call touch)

# vim: syntax=make
