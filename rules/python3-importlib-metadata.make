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
PACKAGES-$(PTXCONF_PYTHON3_IMPORTLIB_METADATA) += python3-importlib-metadata

#
# Paths and names
#
PYTHON3_IMPORTLIB_METADATA_VERSION	:= 1.7.0
PYTHON3_IMPORTLIB_METADATA_MD5		:= 4505ea85600cca1e693a4f8f5dd27ba8
PYTHON3_IMPORTLIB_METADATA		:= importlib_metadata-$(PYTHON3_IMPORTLIB_METADATA_VERSION)
PYTHON3_IMPORTLIB_METADATA_SUFFIX	:= tar.gz
PYTHON3_IMPORTLIB_METADATA_URL		:= https://pypi.python.org/packages/source/i/importlib_metadata/$(PYTHON3_IMPORTLIB_METADATA).$(PYTHON3_IMPORTLIB_METADATA_SUFFIX)
PYTHON3_IMPORTLIB_METADATA_SOURCE	:= $(SRCDIR)/$(PYTHON3_IMPORTLIB_METADATA).$(PYTHON3_IMPORTLIB_METADATA_SUFFIX)
PYTHON3_IMPORTLIB_METADATA_DIR		:= $(BUILDDIR)/$(PYTHON3_IMPORTLIB_METADATA)
PYTHON3_IMPORTLIB_METADATA_LICENSE	:= Apache-2.0
PYTHON3_IMPORTLIB_METADATA_LICENSE_FILES := \
	file://LICENSE;md5=e88ae122f3925d8bde8319060f2ddb8e

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_IMPORTLIB_METADATA_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-importlib-metadata.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-importlib-metadata)
	@$(call install_fixup, python3-importlib-metadata, PRIORITY, optional)
	@$(call install_fixup, python3-importlib-metadata, SECTION, base)
	@$(call install_fixup, python3-importlib-metadata, AUTHOR, "Philipp Zabel <p.zabel@pengutronix.de>")
	@$(call install_fixup, python3-importlib-metadata, DESCRIPTION, missing)

	@$(call install_glob, python3-importlib-metadata, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),, *.py)

	@$(call install_finish, python3-importlib-metadata)

	@$(call touch)

# vim: syntax=make
