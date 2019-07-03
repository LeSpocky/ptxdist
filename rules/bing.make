# -*-makefile-*-
#
# Copyright (C) 2003 by Robert Schwebel
#               2008 by Wolfram Sang, Pengutronix e.K.
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BING) += bing

#
# Paths and names
#
BING_VERSION	:= 1.1.3
BING_MD5	:= 0ccd96cc01351c0562f1e4b94aaa2790
BING		:= bing_src-$(BING_VERSION)
BING_SUFFIX	:= tar.gz
BING_URL	:= http://fgouget.free.fr/bing/$(BING).$(BING_SUFFIX)
BING_SOURCE	:= $(SRCDIR)/$(BING).$(BING_SUFFIX)
BING_DIR	:= $(BUILDDIR)/$(BING)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

BING_CONF_TOOL	:= NO
BING_MAKE_OPT	:= $(CROSS_ENV_PROGS) bing

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/bing.targetinstall:
	@$(call targetinfo)

	@$(call install_init, bing)
	@$(call install_fixup, bing,PRIORITY,optional)
	@$(call install_fixup, bing,SECTION,base)
	@$(call install_fixup, bing,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, bing,DESCRIPTION,missing)

	@$(call install_copy, bing, 0, 0, 0755, -, /usr/sbin/bing)

	@$(call install_finish, bing)

	@$(call touch)

# vim: syntax=make
