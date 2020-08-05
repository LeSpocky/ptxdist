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
PYTHON3_PYPARSING_VERSION	:= 2.4.7
PYTHON3_PYPARSING_MD5		:= f0953e47a0112f7a65aec2305ffdf7b4
PYTHON3_PYPARSING		:= pyparsing-$(PYTHON3_PYPARSING_VERSION)
PYTHON3_PYPARSING_SUFFIX	:= tar.gz
PYTHON3_PYPARSING_URL		:= https://pypi.python.org/packages/source/p/pyparsing/$(PYTHON3_PYPARSING).$(PYTHON3_PYPARSING_SUFFIX)
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
