# -*-makefile-*-
#
# Copyright (C) 2003 by Sascha Hauer <sascha.hauer@gyro-net.de>
#               2008 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MADPLAY) += madplay

#
# Paths and names
#
MADPLAY_VERSION	:= 0.15.2b
MADPLAY_SHA256	:= 5a79c7516ff7560dffc6a14399a389432bc619c905b13d3b73da22fa65acede0
MADPLAY		:= madplay-$(MADPLAY_VERSION)
MADPLAY_SUFFIX	:= tar.gz
MADPLAY_URL	:= $(call ptx/mirror, SF, mad/madplay/$(MADPLAY_VERSION)/$(MADPLAY).$(MADPLAY_SUFFIX))
MADPLAY_SOURCE	:= $(SRCDIR)/$(MADPLAY).$(MADPLAY_SUFFIX)
MADPLAY_DIR	:= $(BUILDDIR)/$(MADPLAY)


# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
MADPLAY_CONF_TOOL := autoconf
MADPLAY_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--disable-debugging \
	--disable-profiling \
	--disable-nls \
	--disable-experimental \
	--without-esd \
	--with-alsa

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/madplay.targetinstall:
	@$(call targetinfo)

	@$(call install_init, madplay)
	@$(call install_fixup, madplay,PRIORITY,optional)
	@$(call install_fixup, madplay,SECTION,base)
	@$(call install_fixup, madplay,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, madplay,DESCRIPTION,missing)

	@$(call install_copy, madplay, 0, 0, 0755, -, /usr/bin/madplay)

	@$(call install_finish, madplay)
	@$(call touch)

# vim: syntax=make
