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
LIBOGG_VERSION	:= 1.3.5
LIBOGG_MD5	:= 3267127fe8d7ba77d3e00cb9d7ad578d
LIBOGG		:= libogg-$(LIBOGG_VERSION)
LIBOGG_SUFFIX	:= tar.gz
LIBOGG_URL	:= http://downloads.xiph.org/releases/ogg/$(LIBOGG).$(LIBOGG_SUFFIX)
LIBOGG_SOURCE	:= $(SRCDIR)/$(LIBOGG).$(LIBOGG_SUFFIX)
LIBOGG_DIR	:= $(BUILDDIR)/$(LIBOGG)
LIBOGG_LICENSE	:= BSD-3-Clause
LIBOGG_LICENSE_FILES := \
	file://COPYING;md5=db1b7a668b2a6f47b2af88fb008ad555

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBOGG_CONF_TOOL	:= autoconf
LIBOGG_CONF_OPT		:= \
	$(CROSS_AUTOCONF_USR) \
	--enable-crc

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
