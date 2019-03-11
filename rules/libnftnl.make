# -*-makefile-*-
#
# Copyright (C) 2016 by Andreas Geisenhainer <andreas.geisenhainer@atsonline.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBNFTNL) += libnftnl

#
# Paths and names
#
LIBNFTNL_VERSION	:= 1.1.2
LIBNFTNL_MD5		:= 14093a238d5025d4a452e6d1cef88c58
LIBNFTNL		:= libnftnl-$(LIBNFTNL_VERSION)
LIBNFTNL_SUFFIX		:= tar.bz2
LIBNFTNL_URL		:= http://ftp.netfilter.org/pub/libnftnl/$(LIBNFTNL).$(LIBNFTNL_SUFFIX)
LIBNFTNL_SOURCE		:= $(SRCDIR)/$(LIBNFTNL).$(LIBNFTNL_SUFFIX)
LIBNFTNL_DIR		:= $(BUILDDIR)/$(LIBNFTNL)
LIBNFTNL_LICENSE	:= GPL-2.0-only

#
# autoconf
#
LIBNFTNL_CONF_TOOL	:= autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libnftnl.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libnftnl)
	@$(call install_fixup, libnftnl,PRIORITY,optional)
	@$(call install_fixup, libnftnl,SECTION,base)
	@$(call install_fixup, libnftnl,AUTHOR,"Andreas Geisenhainer <andreas.geisenhainer@atsonline.de>")
	@$(call install_fixup, libnftnl,DESCRIPTION,missing)

	@$(call install_lib, libnftnl, 0, 0, 0644, libnftnl)

	@$(call install_finish, libnftnl)

	@$(call touch)

# vim: syntax=make
