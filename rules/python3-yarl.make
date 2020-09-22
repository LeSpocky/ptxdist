# -*-makefile-*-
#
# Copyright (C) 2017 by Pim Klanke <pim@protonic.nl>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_YARL) += python3-yarl

#
# Paths and names
#
PYTHON3_YARL_VERSION	:= 1.5.1
PYTHON3_YARL_MD5	:= a9b20bf0b8a6962e1101b28908a67bf8
PYTHON3_YARL		:= yarl-$(PYTHON3_YARL_VERSION)
PYTHON3_YARL_SUFFIX	:= tar.gz
PYTHON3_YARL_URL	:= $(call ptx/mirror-pypi, yarl, $(PYTHON3_YARL).$(PYTHON3_YARL_SUFFIX))
PYTHON3_YARL_SOURCE	:= $(SRCDIR)/$(PYTHON3_YARL).$(PYTHON3_YARL_SUFFIX)
PYTHON3_YARL_DIR	:= $(BUILDDIR)/$(PYTHON3_YARL)
PYTHON3_YARL_LICENSE	:= Apache-2.0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_YARL_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-yarl.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-yarl)
	@$(call install_fixup, python3-yarl, PRIORITY, optional)
	@$(call install_fixup, python3-yarl, SECTION, base)
	@$(call install_fixup, python3-yarl, AUTHOR, "Pim Klanke <pim@protonic.nl>")
	@$(call install_fixup, python3-yarl, DESCRIPTION, missing)

	@$(call install_glob, python3-yarl, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES)/yarl,, *.py)

	@$(call install_finish, python3-yarl)

	@$(call touch)

# vim: syntax=make
