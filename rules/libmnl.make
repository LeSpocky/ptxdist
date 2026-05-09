# -*-makefile-*-
#
# Copyright (C) 2016 by Andreas Geisenhainer <andreas.geisenhainer@atsonline.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBMNL) += libmnl

#
# Paths and names
#
LIBMNL_VERSION	:= 1.0.5
LIBMNL_SHA256	:= 274b9b919ef3152bfb3da3a13c950dd60d6e2bcd54230ffeca298d03b40d0525
LIBMNL		:= libmnl-$(LIBMNL_VERSION)
LIBMNL_SUFFIX	:= tar.bz2
LIBMNL_URL	:= https://ftp.netfilter.org/pub/libmnl/$(LIBMNL).$(LIBMNL_SUFFIX)
LIBMNL_SOURCE	:= $(SRCDIR)/$(LIBMNL).$(LIBMNL_SUFFIX)
LIBMNL_DIR	:= $(BUILDDIR)/$(LIBMNL)
LIBMNL_LICENSE	:= LGPL-2.1-or-later
LIBMNL_LICENSE_FILES := file://COPYING;md5=4fbd65380cdd255951079008b364516c

#
# autoconf
#
LIBMNL_CONF_TOOL	:= autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libmnl.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libmnl)
	@$(call install_fixup, libmnl,PRIORITY,optional)
	@$(call install_fixup, libmnl,SECTION,base)
	@$(call install_fixup, libmnl,AUTHOR,"Andreas Geisenhainer <andreas.geisenhainer@atsonline.de>")
	@$(call install_fixup, libmnl,DESCRIPTION,missing)

	@$(call install_lib, libmnl, 0, 0, 0644, libmnl)

	@$(call install_finish, libmnl)

	@$(call touch)

# vim: syntax=make
