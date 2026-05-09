# -*-makefile-*-
#
# Copyright (C) 2020 by Philipp Zabel <p.zabel@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_PYPARSING) += python3-pyparsing

#
# Paths and names
#
PYTHON3_PYPARSING_VERSION	:= 3.2.5
PYTHON3_PYPARSING_SHA256	:= 2df8d5b7b2802ef88e8d016a2eb9c7aeaa923529cd251ed0fe4608275d4105b6
PYTHON3_PYPARSING		:= pyparsing-$(PYTHON3_PYPARSING_VERSION)
PYTHON3_PYPARSING_SUFFIX	:= tar.gz
PYTHON3_PYPARSING_URL		:= $(call ptx/mirror-pypi, pyparsing, $(PYTHON3_PYPARSING).$(PYTHON3_PYPARSING_SUFFIX))
PYTHON3_PYPARSING_SOURCE	:= $(SRCDIR)/$(PYTHON3_PYPARSING).$(PYTHON3_PYPARSING_SUFFIX)
PYTHON3_PYPARSING_DIR		:= $(BUILDDIR)/$(PYTHON3_PYPARSING)
PYTHON3_PYPARSING_LICENSE	:= MIT
PYTHON3_PYPARSING_LICENSE_FILES	:= \
	file://LICENSE;md5=657a566233888513e1f07ba13e2f47f1

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_PYPARSING_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-pyparsing.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-pyparsing)
	@$(call install_fixup, python3-pyparsing, PRIORITY, optional)
	@$(call install_fixup, python3-pyparsing, SECTION, base)
	@$(call install_fixup, python3-pyparsing, AUTHOR, "Philipp Zabel <p.zabel@pengutronix.de>")
	@$(call install_fixup, python3-pyparsing, DESCRIPTION, missing)

	@$(call install_glob, python3-pyparsing, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),, *.py)

	@$(call install_finish, python3-pyparsing)

	@$(call touch)

# vim: syntax=make
