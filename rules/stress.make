# -*-makefile-*-
#
# Copyright (C) 2017 by Roland Hieber <r.hieber@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_STRESS) += stress

#
# Paths and names
#
STRESS_VERSION	:= 1.0.7
STRESS_MD5	:= 4104cf194d249d8064683b6c28f374a3
STRESS		:= stress-$(STRESS_VERSION)
STRESS_SUFFIX	:= tar.gz
STRESS_URL	:= https://github.com/resurrecting-open-source-projects/stress/archive/$(STRESS_VERSION).$(STRESS_SUFFIX)
STRESS_SOURCE	:= $(SRCDIR)/$(STRESS).$(STRESS_SUFFIX)
STRESS_DIR	:= $(BUILDDIR)/$(STRESS)
STRESS_LICENSE	:= GPL-2.0-or-later
STRESS_LICENSE_FILES	:= \
	file://COPYING;md5=b234ee4d69f5fce4486a80fdaf4a4263 \
	file://src/stress.c;startline=3;endline=20;md5=a4bb41767da83c0d96e9bf23ba6422b8

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# prevent errors when building the documentation, which is not installed anyways
STRESS_CONF_ENV	:= \
	$(CROSS_ENV) \
	MAKEINFO=:

#
# autoconf
#
STRESS_CONF_TOOL	:= autoconf
STRESS_CONF_OPT		:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-dependency-tracking

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/stress.targetinstall:
	@$(call targetinfo)

	@$(call install_init, stress)
	@$(call install_fixup, stress,PRIORITY,optional)
	@$(call install_fixup, stress,SECTION,base)
	@$(call install_fixup, stress,AUTHOR,"Roland Hieber <r.hieber@pengutronix.de>")
	@$(call install_fixup, stress,DESCRIPTION,missing)

	@$(call install_copy, stress, 0, 0, 0755, -, /usr/bin/stress)

	@$(call install_finish, stress)

	@$(call touch)

# vim: syntax=make
