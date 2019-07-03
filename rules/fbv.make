# -*-makefile-*-
#
# Copyright (C) 2009 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_FBV) += fbv

#
# Paths and names
#
FBV_VERSION	:= 1.0b-ptx3
FBV_MD5		:= 0d466f678630941fb9a38884e3402f21
FBV		:= fbv-$(FBV_VERSION)
FBV_SUFFIX	:= tar.bz2
FBV_URL		:= http://www.pengutronix.de/software/ptxdist/temporary-src/$(FBV).$(FBV_SUFFIX)
#FBV_URL	:= http://s-tech.elsat.net.pl/fbv/$(FBV).$(FBV_SUFFIX)
FBV_SOURCE	:= $(SRCDIR)/$(FBV).$(FBV_SUFFIX)
FBV_DIR		:= $(BUILDDIR)/$(FBV)
FBV_LICENSE	:= GPL-2.0-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
FBV_CONF_TOOL	:= autoconf
FBV_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--$(call ptx/endis, PTXCONF_FBV_PNG)-libpng \
	--disable-debug

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/fbv.targetinstall:
	@$(call targetinfo)

	@$(call install_init, fbv)
	@$(call install_fixup, fbv,PRIORITY,optional)
	@$(call install_fixup, fbv,SECTION,base)
	@$(call install_fixup, fbv,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, fbv,DESCRIPTION,missing)

	@$(call install_copy, fbv, 0, 0, 0755, -, /usr/bin/fbv)

	@$(call install_finish, fbv)

	@$(call touch)

# vim: syntax=make
