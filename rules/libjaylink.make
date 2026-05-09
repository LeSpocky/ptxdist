# -*-makefile-*-
#
# Copyright (C) 2019 by Michael Grzeschik <mgr@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

PACKAGES-$(PTXCONF_LIBJAYLINK) += libjaylink

LIBJAYLINK_VERSION	:= 0.1.0-15-g8645845
LIBJAYLINK_SHA256	:= 3f259c163acf73b041c4ae2b9cdceba1cf8f5243c4d282bbefba13a131d2ae97
LIBJAYLINK		:= libjaylink-$(LIBJAYLINK_VERSION)
LIBJAYLINK_SUFFIX	:= tar.bz2
LIBJAYLINK_URL		:= https://gitlab.zapb.de/libjaylink/libjaylink/-/archive/$(LIBJAYLINK_VERSION)/$(LIBJAYLINK).$(LIBJAYLINK_SUFFIX)
LIBJAYLINK_SOURCE	:= $(SRCDIR)/$(LIBJAYLINK).$(LIBJAYLINK_SUFFIX)
LIBJAYLINK_DIR		:= $(BUILDDIR)/$(LIBJAYLINK)
LIBJAYLINK_LICENSE	:= GPL-2.0+

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libjaylink.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libjaylink)
	@$(call install_fixup, libjaylink,PRIORITY,optional)
	@$(call install_fixup, libjaylink,SECTION,base)
	@$(call install_fixup, libjaylink,AUTHOR,"Michael Grzeschik <mgr@pengutronix.de>")
	@$(call install_fixup, libjaylink,DESCRIPTION,"Library to access J-Link devices")

	@$(call install_lib, libjaylink, 0, 0, 0644, libjaylink)

	@$(call install_finish, libjaylink)

	@$(call touch)

# vim: syntax=make
