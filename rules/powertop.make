# -*-makefile-*-
#
# Copyright (C) 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#		2014 by Alexander Aring <aar@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_POWERTOP) += powertop

#
# Paths and names
#
POWERTOP_VERSION	:= 2.16.1
POWERTOP_SHA256		:= 73d5e96d992ed7f040e17c6c9130deebcf42c38990711840981c7afac6f7832f
POWERTOP		:= powertop-v$(POWERTOP_VERSION)
POWERTOP_SUFFIX		:= tar.gz
POWERTOP_URL		:= https://github.com/fenrus75/powertop/archive/refs/tags/v$(POWERTOP_VERSION).$(POWERTOP_SUFFIX)
POWERTOP_SOURCE		:= $(SRCDIR)/$(POWERTOP).$(POWERTOP_SUFFIX)
POWERTOP_DIR		:= $(BUILDDIR)/$(POWERTOP)
POWERTOP_LICENSE	:= GPL-2.0-only
POWERTOP_LICENSE_FILES	:= \
	file://COPYING;md5=12f884d2ae1ff87c09e5b7ccc2c4ca7e \
	file://src/main.cpp;startline=1;endline=29;md5=6cc786afdc98b8098452aa4f41300d53

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# meson
#
POWERTOP_CONF_TOOL	:= meson
POWERTOP_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Denable-tests=false \
	-Dnls=false \
	-Dtest-framework=false

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/powertop.targetinstall:
	@$(call targetinfo)

	@$(call install_init, powertop)
	@$(call install_fixup, powertop,PRIORITY,optional)
	@$(call install_fixup, powertop,SECTION,base)
	@$(call install_fixup, powertop,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, powertop,DESCRIPTION,missing)

	@$(call install_copy, powertop, 0, 0, 0755, -, /usr/bin/powertop)

	@$(call install_finish, powertop)

	@$(call touch)

# vim: syntax=make
