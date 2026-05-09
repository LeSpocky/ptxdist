# -*-makefile-*-
#
# Copyright (C) 2016 by Lucas Stach <l.stach@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_RENDERCHECK) += rendercheck

#
# Paths and names
#
RENDERCHECK_VERSION	:= 1.6
RENDERCHECK_SHA256	:= 006a70232b190c8fc035db0b5c033e7d54e7f3442ac0325dbad10b7134c32a01
RENDERCHECK		:= rendercheck-$(RENDERCHECK_VERSION)
RENDERCHECK_SUFFIX	:= tar.xz
RENDERCHECK_URL		:= https://www.x.org/releases/individual/test/$(RENDERCHECK).$(RENDERCHECK_SUFFIX)
RENDERCHECK_SOURCE	:= $(SRCDIR)/$(RENDERCHECK).$(RENDERCHECK_SUFFIX)
RENDERCHECK_DIR		:= $(BUILDDIR)/$(RENDERCHECK)
RENDERCHECK_LICENSE	:= HPND-sell-variant AND GPL-2.0-or-later
RENDERCHECK_LICENSE_FILES := \
	file://COPYING;md5=ff84617f9d8cecf388d25880f32448b0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------
RENDERCHECK_CONF_TOOL	:= meson

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/rendercheck.targetinstall:
	@$(call targetinfo)

	@$(call install_init, rendercheck)
	@$(call install_fixup, rendercheck,PRIORITY,optional)
	@$(call install_fixup, rendercheck,SECTION,base)
	@$(call install_fixup, rendercheck,AUTHOR,"Lucas Stach <l.stach@pengutronix.de>")
	@$(call install_fixup, rendercheck,DESCRIPTION,missing)

	@$(call install_copy, rendercheck, 0, 0, 0755, -, /usr/bin/rendercheck)

	@$(call install_finish, rendercheck)

	@$(call touch)

# vim: syntax=make
