# -*-makefile-*-
#
# Copyright (C) 2018 by Guillermo Rodriguez <guille.rodriguez@gmail.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBEV) += libev

#
# Paths and names
#
LIBEV_VERSION	:= 4.24
LIBEV_SHA256	:= 973593d3479abdf657674a55afe5f78624b0e440614e2b8cb3a07f16d4d7f821
LIBEV		:= libev-$(LIBEV_VERSION)
LIBEV_SUFFIX	:= tar.gz
LIBEV_URL	:= http://dist.schmorp.de/libev/Attic/$(LIBEV).$(LIBEV_SUFFIX)
LIBEV_SOURCE	:= $(SRCDIR)/$(LIBEV).$(LIBEV_SUFFIX)
LIBEV_DIR	:= $(BUILDDIR)/$(LIBEV)
LIBEV_LICENSE	:= GPL-2.0-or-later AND BSD

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBEV_CONF_TOOL	:= autoconf
LIBEV_CONF_OPT	:= $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libev.install:
	@$(call targetinfo)
	@$(call world/install, LIBEV)
	@rm $(LIBEV_PKGDIR)/usr/include/event.h
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libev.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libev)
	@$(call install_fixup, libev, PRIORITY, optional)
	@$(call install_fixup, libev, SECTION, base)
	@$(call install_fixup, libev, AUTHOR, "Guillermo Rodriguez <guille.rodriguez@gmail.com>")
	@$(call install_fixup, libev, DESCRIPTION, missing)

	@$(call install_lib, libev, 0, 0, 0644, libev)

	@$(call install_finish, libev)

	@$(call touch)

# vim: syntax=make
