# -*-makefile-*-
#
# Copyright (C) 2011 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_FLUP6) += flup6

#
# Paths and names
#
FLUP6_VERSION	:= 1.1
FLUP6_SHA256	:= 858a2d95dc1468f29a0e165dce33111d564d8241131e7e63779c46e68f2a2f77
FLUP6		:= flup6-$(FLUP6_VERSION)
FLUP6_SUFFIX	:= tar.gz
FLUP6_URL	:= $(call ptx/mirror-pypi, flup6, $(FLUP6).$(FLUP6_SUFFIX))
FLUP6_SOURCE	:= $(SRCDIR)/$(FLUP6).$(FLUP6_SUFFIX)
FLUP6_DIR	:= $(BUILDDIR)/$(FLUP6)
FLUP6_LICENSE	:= BSD AND MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

FLUP6_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/flup6.targetinstall:
	@$(call targetinfo)

	@$(call install_init, flup6)
	@$(call install_fixup, flup6,PRIORITY,optional)
	@$(call install_fixup, flup6,SECTION,base)
	@$(call install_fixup, flup6,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, flup6,DESCRIPTION,missing)

	@$(call install_copy, flup6, 0, 0, 0755, $(PYTHON_SITEPACKAGES))
	@$(call install_copy, flup6, 0, 0, 0755, $(PYTHON_SITEPACKAGES)/flup6)
	@$(call install_copy, flup6, 0, 0, 0755, $(PYTHON_SITEPACKAGES)/flup6/client)
	@$(call install_copy, flup6, 0, 0, 0755, $(PYTHON_SITEPACKAGES)/flup6/server)

	@$(call install_glob, flup6, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES)/flup,, *.py)

	@$(call install_finish, flup6)

	@$(call touch)

# vim: syntax=make
