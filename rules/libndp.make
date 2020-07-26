# -*-makefile-*-
#
# Copyright (C) 2015 by Juergen Borleis <jbe@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBNDP) += libndp

#
# Paths and names
#
LIBNDP_VERSION	:= 1.7
LIBNDP_MD5	:= ea4a2a3351991c1d561623772364ae14
LIBNDP		:= libndp-$(LIBNDP_VERSION)
LIBNDP_SUFFIX	:= tar.gz
LIBNDP_URL	:= http://libndp.org/files/$(LIBNDP).$(LIBNDP_SUFFIX)
LIBNDP_SOURCE	:= $(SRCDIR)/$(LIBNDP).$(LIBNDP_SUFFIX)
LIBNDP_DIR	:= $(BUILDDIR)/$(LIBNDP)
LIBNDP_LICENSE	:= LGPL-2.1-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBNDP_CONF_TOOL	:= autoconf
LIBNDP_CONF_OPT		:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-logging \
	--disable-debug

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libndp.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libndp)
	@$(call install_fixup, libndp,PRIORITY,optional)
	@$(call install_fixup, libndp,SECTION,base)
	@$(call install_fixup, libndp,AUTHOR,"Juergen Borleis <jbe@pengutronix.de>")
	@$(call install_fixup, libndp,DESCRIPTION,"Neighbor Discovery Protocol support")

	@$(call install_lib, libndp, 0, 0, 0644, libndp)
ifdef PTXCONF_LIBNDP_NDPTOOL
	@$(call install_copy, libndp, 0, 0, 0755, -, /usr/bin/ndptool)
endif
	@$(call install_finish, libndp)

	@$(call touch)

# vim: syntax=make
