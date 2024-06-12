# -*-makefile-*-
#
# Copyright (C) 2004 by Robert Schwebel
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#               2011 by Wolfram Sang <w.sang@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_FIGLET) += figlet

#
# Paths and names
#
FIGLET_VERSION		:= 2.2.5
FIGLET_MD5		:= eaaeb356007755c9770a842aefd8ed5f d88cb33a14f1469fff975d021ae2858e
FIGLET			:= figlet-$(FIGLET_VERSION)
FIGLET_SUFFIX		:= tar.gz
FIGLET_URL		:= https://github.com/cmatsuoka/figlet/archive/refs/tags/$(FIGLET_VERSION).$(FIGLET_SUFFIX)
FIGLET_SOURCE		:= $(SRCDIR)/$(FIGLET).$(FIGLET_SUFFIX)
FIGLET_DIR		:= $(BUILDDIR)/$(FIGLET)
FIGLET_LICENSE		:= BSD-3-clause
FIGLET_LICENSE_FILES	:= \
	file://LICENSE;md5=1688bcd97b27704f1afcac7336409857

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

FIGLET_MAKE_OPT		:= prefix=/usr CC=$(CROSS_CC) LD=$(CROSS_CC) $(CROSS_ENV_FLAGS)
FIGLET_INSTALL_OPT	:= prefix=/usr install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/figlet.targetinstall:
	@$(call targetinfo)

	@$(call install_init, figlet)
	@$(call install_fixup, figlet,PRIORITY,optional)
	@$(call install_fixup, figlet,SECTION,base)
	@$(call install_fixup, figlet,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, figlet,DESCRIPTION,missing)

	@$(call install_copy, figlet, 0, 0, 0755, -, /usr/bin/figlet)
	@$(call install_copy, figlet, 0, 0, 0644, -, /usr/share/figlet/standard.flf)

	@$(call install_finish, figlet)

	@$(call touch)

# vim: syntax=make
