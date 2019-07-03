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
MADPLAY_MD5	:= 6814b47ceaa99880c754c5195aa1aac1
MADPLAY		:= madplay-$(MADPLAY_VERSION)
MADPLAY_SUFFIX	:= tar.gz
MADPLAY_URL	:= ftp://ftp.mars.org/pub/mpeg/$(MADPLAY).$(MADPLAY_SUFFIX)
MADPLAY_SOURCE	:= $(SRCDIR)/$(MADPLAY).$(MADPLAY_SUFFIX)
MADPLAY_DIR	:= $(BUILDDIR)/$(MADPLAY)


# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

MADPLAY_PATH	:= PATH=$(CROSS_PATH)
MADPLAY_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
MADPLAY_AUTOCONF := $(CROSS_AUTOCONF_USR) \
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
