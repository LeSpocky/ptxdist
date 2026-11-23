# -*-makefile-*-
#
# Copyright (C) 2005 by Robert Schwebel
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_DBENCH) += dbench

#
# Paths and names
#
DBENCH_VERSION	:= 5.00
DBENCH_SHA256	:= 03f1a1d8aa153c197bf3293b9ce0b85dce39485be43abeba9f7f1c811c5f5b3d
DBENCH		:= dbench-$(DBENCH_VERSION)
DBENCH_SUFFIX	:= tar.gz
DBENCH_URL	:= https://github.com/sahlberg/dbench/archive/refs/tags/$(DBENCH).$(DBENCH_SUFFIX)
DBENCH_SOURCE	:= $(SRCDIR)/$(DBENCH).$(DBENCH_SUFFIX)
DBENCH_DIR	:= $(BUILDDIR)/$(DBENCH)
DBENCH_LICENSE	:= GPL-3.0-or-later
DBENCH_LICENSE_FILES	:= \
	file://README;startline=9;endline=10;md5=5e2bd5d1c70a0f9968596c783d0ffae4 \
	file://dbench.c;startline=1;endline=17;md5=c61c6ed20832a9655fd37f38823e3205 \
	file://COPYING;md5=d32239bcb673463ab874e80d47fae504

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
DBENCH_CONF_TOOL	:= autoconf
DBENCH_CONF_OPT		:= $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/dbench.targetinstall:
	@$(call targetinfo)

	@$(call install_init, dbench)
	@$(call install_fixup, dbench,PRIORITY,optional)
	@$(call install_fixup, dbench,SECTION,base)
	@$(call install_fixup, dbench,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, dbench,DESCRIPTION,missing)

ifdef PTXCONF_DBENCH_DBENCH
	@$(call install_copy, dbench, 0, 0, 0755, -, /usr/bin/dbench)
endif
ifdef PTXCONF_DBENCH_TBENCH_SERVER
	@$(call install_copy, dbench, 0, 0, 0755, -, /usr/bin/tbench_srv)
endif
	@$(call install_finish, dbench)

	@$(call touch)

# vim: syntax=make
