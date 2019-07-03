# -*-makefile-*-
#
# Copyright (C) 2008 by Robert Schwebel <r.schwebel@pengutronix.de>
#               2011 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MBW) += mbw

#
# Paths and names
#
MBW_VERSION	:= 1.4
MBW_MD5		:= 83b5dfbcdc2d5e4f332ce56135f0a587
MBW		:= mbw-$(MBW_VERSION)
MBW_SUFFIX	:= tar.gz
MBW_URL		:= https://github.com/raas/mbw/releases/download/v$(MBW_VERSION)/$(MBW).$(MBW_SUFFIX)
MBW_SOURCE	:= $(SRCDIR)/$(MBW).$(MBW_SUFFIX)
MBW_DIR		:= $(BUILDDIR)/$(MBW)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

MBW_CONF_TOOL	:= NO
MBW_MAKE_OPT	:= $(CROSS_ENV_PROGS)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/mbw.install:
	@$(call targetinfo)
	install -D -m644 $(MBW_DIR)/mbw $(MBW_PKGDIR)/usr/bin/mbw
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/mbw.targetinstall:
	@$(call targetinfo)

	@$(call install_init, mbw)
	@$(call install_fixup, mbw,PRIORITY,optional)
	@$(call install_fixup, mbw,SECTION,base)
	@$(call install_fixup, mbw,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, mbw,DESCRIPTION,missing)

	@$(call install_copy, mbw, 0, 0, 0755, -, /usr/bin/mbw)

	@$(call install_finish, mbw)

	@$(call touch)

# vim: syntax=make
