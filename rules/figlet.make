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
FIGLET_MD5		:= d88cb33a14f1469fff975d021ae2858e
FIGLET			:= figlet-$(FIGLET_VERSION)
FIGLET_SUFFIX		:= tar.gz
FIGLET_URL		:= ftp://ftp.figlet.org/pub/figlet/program/unix/$(FIGLET).$(FIGLET_SUFFIX)
FIGLET_SOURCE		:= $(SRCDIR)/$(FIGLET).$(FIGLET_SUFFIX)
FIGLET_DIR		:= $(BUILDDIR)/$(FIGLET)
FIGLET_LICENSE		:= BSD-3-Clause AND MIT-CMU AND ISC AND Unicode-DFS-2016 AND WTFPL
FIGLET_LICENSE_FILES	:= \
	file://LICENSE;md5=1688bcd97b27704f1afcac7336409857 \
	file://inflate.c;startline=7;endline=27;md5=74ed6158b8244dbc4d91afaf8a39bec2 \
	file://utf8.c;startline=2;endline=16;md5=eb9cc57cf60ac24044670bf8dc475579 \
	file://fonts/8859-2.flc;startline=9;endline=23;md5=1cecb984063248f29ffe5c46f5c04f34 \
	file://tests/emboss.tlf;startline=3;endline=10;md5=8e317e9236ffade21fedc39e3496eac2

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
