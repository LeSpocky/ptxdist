# -*-makefile-*-
#
# Copyright (C) 2025 by Markus Heidelberg <m.heidelberg@cab.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_STATEMACHINE) += python3-statemachine

#
# Paths and names
#
PYTHON3_STATEMACHINE_VERSION		:= 2.5.0
PYTHON3_STATEMACHINE_MD5		:= 04598d34159bedc13a4998e6a045f0d0
PYTHON3_STATEMACHINE			:= python_statemachine-$(PYTHON3_STATEMACHINE_VERSION)
PYTHON3_STATEMACHINE_SUFFIX		:= tar.gz
PYTHON3_STATEMACHINE_URL		:= $(call ptx/mirror-pypi, python-statemachine, $(PYTHON3_STATEMACHINE).$(PYTHON3_STATEMACHINE_SUFFIX))
PYTHON3_STATEMACHINE_SOURCE		:= $(SRCDIR)/$(PYTHON3_STATEMACHINE).$(PYTHON3_STATEMACHINE_SUFFIX)
PYTHON3_STATEMACHINE_DIR		:= $(BUILDDIR)/$(PYTHON3_STATEMACHINE)
PYTHON3_STATEMACHINE_LICENSE		:= MIT
PYTHON3_STATEMACHINE_LICENSE_FILES	:= \
	file://pyproject.toml;startline=7;endline=7;md5=623437efa8fb3f31009255ea0c4227b4 \
	file://LICENSE;md5=18e79b33e7b579ebf7950c6d066248ff

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_STATEMACHINE_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-statemachine.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-statemachine)
	@$(call install_fixup, python3-statemachine,PRIORITY,optional)
	@$(call install_fixup, python3-statemachine,SECTION,base)
	@$(call install_fixup, python3-statemachine,AUTHOR,"Markus Heidelberg <m.heidelberg@cab.de>")
	@$(call install_fixup, python3-statemachine,DESCRIPTION,missing)

	@$(call install_glob, python3-statemachine, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),, *.py)

	@$(call install_finish, python3-statemachine)

	@$(call touch)

# vim: ft=make
