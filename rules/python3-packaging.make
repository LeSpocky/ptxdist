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
PACKAGES-$(PTXCONF_PYTHON3_PACKAGING) += python3-packaging

#
# Paths and names
#
PYTHON3_PACKAGING_VERSION	:= 20.4
PYTHON3_PACKAGING_MD5		:= 3208229da731c5d8e29d4d8941e75005
PYTHON3_PACKAGING		:= packaging-$(PYTHON3_PACKAGING_VERSION)
PYTHON3_PACKAGING_SUFFIX	:= tar.gz
PYTHON3_PACKAGING_URL		:= https://pypi.python.org/packages/source/p/packaging/$(PYTHON3_PACKAGING).$(PYTHON3_PACKAGING_SUFFIX)
PYTHON3_PACKAGING_SOURCE	:= $(SRCDIR)/$(PYTHON3_PACKAGING).$(PYTHON3_PACKAGING_SUFFIX)
PYTHON3_PACKAGING_DIR		:= $(BUILDDIR)/$(PYTHON3_PACKAGING)
PYTHON3_PACKAGING_LICENSE	:= BSD-2-Clause OR Apache-2.0
PYTHON3_PACKAGING_LICENSE_FILES	:= \
	file://LICENSE;md5=faadaedca9251a90b205c9167578ce91

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_PACKAGING_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-packaging.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-packaging)
	@$(call install_fixup, python3-packaging, PRIORITY, optional)
	@$(call install_fixup, python3-packaging, SECTION, base)
	@$(call install_fixup, python3-packaging, AUTHOR, "Philipp Zabel <p.zabel@pengutronix.de>")
	@$(call install_fixup, python3-packaging, DESCRIPTION, missing)

	@$(call install_glob, python3-packaging, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),, *.py)

	@$(call install_finish, python3-packaging)

	@$(call touch)

# vim: syntax=make
