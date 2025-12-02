# -*-makefile-*-
#
# Copyright (C) 2020 by Bastian Krause <bst@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_MARKUPSAFE) += python3-markupsafe

#
# Paths and names
#
PYTHON3_MARKUPSAFE_VERSION	:= 3.0.3
PYTHON3_MARKUPSAFE_MD5		:= 13a73126d25afa72a1ff0daed072f5fe
PYTHON3_MARKUPSAFE		:= markupsafe-$(PYTHON3_MARKUPSAFE_VERSION)
PYTHON3_MARKUPSAFE_SUFFIX	:= tar.gz
PYTHON3_MARKUPSAFE_URL		:= $(call ptx/mirror-pypi, MarkupSafe, $(PYTHON3_MARKUPSAFE).$(PYTHON3_MARKUPSAFE_SUFFIX))
PYTHON3_MARKUPSAFE_SOURCE	:= $(SRCDIR)/$(PYTHON3_MARKUPSAFE).$(PYTHON3_MARKUPSAFE_SUFFIX)
PYTHON3_MARKUPSAFE_DIR		:= $(BUILDDIR)/$(PYTHON3_MARKUPSAFE)
PYTHON3_MARKUPSAFE_LICENSE	:= BSD-3-Clause

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_MARKUPSAFE_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-markupsafe.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-markupsafe)
	@$(call install_fixup, python3-markupsafe, PRIORITY, optional)
	@$(call install_fixup, python3-markupsafe, SECTION, base)
	@$(call install_fixup, python3-markupsafe, AUTHOR, "Bastian Krause <bst@pengutronix.de>")
	@$(call install_fixup, python3-markupsafe, DESCRIPTION, missing)

	@$(call install_glob, python3-markupsafe, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),, *.py)

	@$(call install_finish, python3-markupsafe)

	@$(call touch)

# vim: syntax=make
