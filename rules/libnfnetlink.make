# -*-makefile-*-
#
# Copyright (C) 2011 by Hans Kortenoeven <hans.kortenoeven@home.nl>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBNFNETLINK) += libnfnetlink

#
# Paths and names
#
LIBNFNETLINK_VERSION	:= 1.0.1
LIBNFNETLINK_SHA256	:= f270e19de9127642d2a11589ef2ec97ef90a649a74f56cf9a96306b04817b51a
LIBNFNETLINK		:= libnfnetlink-$(LIBNFNETLINK_VERSION)
LIBNFNETLINK_SUFFIX	:= tar.bz2
LIBNFNETLINK_URL		:= https://ftp.netfilter.org/pub/libnfnetlink/$(LIBNFNETLINK).$(LIBNFNETLINK_SUFFIX)
LIBNFNETLINK_SOURCE	:= $(SRCDIR)/$(LIBNFNETLINK).$(LIBNFNETLINK_SUFFIX)
LIBNFNETLINK_DIR		:= $(BUILDDIR)/$(LIBNFNETLINK)
LIBNFNETLINK_LICENSE	:= GPL2

#
# autoconf
#
LIBNFNETLINK_CONF_TOOL	:= autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libnfnetlink.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libnfnetlink)
	@$(call install_fixup, libnfnetlink,PRIORITY,optional)
	@$(call install_fixup, libnfnetlink,SECTION,base)
	@$(call install_fixup, libnfnetlink,AUTHOR,"Hans Kortenoeven <hans.kortenoeven@home.nl>")
	@$(call install_fixup, libnfnetlink,DESCRIPTION,missing)

	@$(call install_lib, libnfnetlink, 0, 0, 0644, libnfnetlink)

	@$(call install_finish, libnfnetlink)

	@$(call touch)

