# -*-makefile-*-
#
# Copyright (C) 2008 by Robert Schwebel
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_DASH) += dash

#
# Paths and names
#
DASH_VERSION	:= 0.5.5.1
DASH_MD5	:= 7ac832b440b91f5a52cf8eb68e172616
DASH		:= dash-$(DASH_VERSION)
DASH_SUFFIX	:= tar.gz
DASH_URL	:= http://gondor.apana.org.au/~herbert/dash/files/$(DASH).$(DASH_SUFFIX)
DASH_SOURCE	:= $(SRCDIR)/$(DASH).$(DASH_SUFFIX)
DASH_DIR	:= $(BUILDDIR)/$(DASH)
DASH_LICENSE	:= BSD-3-Clause AND GPL-2.0-or-later
DASH_LICENSE_FILES	:= \
	file://COPYING;md5=b5262b4a1a1bff72b48e935531976d2e \
	file://src/mksignames.c;md5=dd8284728a2e2bfce248e44901a05467;startline=4;endline=20

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

DASH_PATH	:= PATH=$(CROSS_PATH)
DASH_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
DASH_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-libedit=no

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/dash.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  dash)
	@$(call install_fixup, dash,PRIORITY,optional)
	@$(call install_fixup, dash,SECTION,base)
	@$(call install_fixup, dash,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, dash,DESCRIPTION,missing)

	@$(call install_copy, dash, 0, 0, 0755, -, /usr/bin/dash)

ifdef PTXCONF_DASH_LINK_SH
	@$(call install_link, dash, dash, /usr/bin/sh)
endif

	@$(call install_finish, dash)

	@$(call touch)

# vim: syntax=make
