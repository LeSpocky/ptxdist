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
LIBNFNETLINK_MD5	:= 98927583d2016a9fb1936fed992e2c5e
LIBNFNETLINK		:= libnfnetlink-$(LIBNFNETLINK_VERSION)
LIBNFNETLINK_SUFFIX	:= tar.bz2
LIBNFNETLINK_URL		:= http://ftp.netfilter.org/pub/libnfnetlink/$(LIBNFNETLINK).$(LIBNFNETLINK_SUFFIX)
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

