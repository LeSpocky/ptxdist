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
PACKAGES-$(PTXCONF_PYTHON3_IDNA) += python3-idna

#
# Paths and names
#
PYTHON3_IDNA_VERSION	:= 2.10
PYTHON3_IDNA_MD5	:= 7a910c706db30d758f377db2762c0f9a
PYTHON3_IDNA		:= idna-$(PYTHON3_IDNA_VERSION)
PYTHON3_IDNA_SUFFIX	:= tar.gz
PYTHON3_IDNA_URL	:= $(call ptx/mirror-pypi, idna, $(PYTHON3_IDNA).$(PYTHON3_IDNA_SUFFIX))
PYTHON3_IDNA_SOURCE	:= $(SRCDIR)/$(PYTHON3_IDNA).$(PYTHON3_IDNA_SUFFIX)
PYTHON3_IDNA_DIR	:= $(BUILDDIR)/$(PYTHON3_IDNA)
PYTHON3_IDNA_LICENSE	:= BSD-3-Clause

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_IDNA_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-idna.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-idna)
	@$(call install_fixup, python3-idna, PRIORITY, optional)
	@$(call install_fixup, python3-idna, SECTION, base)
	@$(call install_fixup, python3-idna, AUTHOR, "Bastian Krause <bst@pengutronix.de>")
	@$(call install_fixup, python3-idna, DESCRIPTION, missing)

	@$(call install_glob, python3-idna, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),, *.py)

	@$(call install_finish, python3-idna)

	@$(call touch)

# vim: syntax=make
