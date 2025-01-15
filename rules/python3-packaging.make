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
PYTHON3_PACKAGING_VERSION	:= 23.1
PYTHON3_PACKAGING_MD5		:= f7d5c39c6f92cc2dfa1293ba8f6c097c
PYTHON3_PACKAGING		:= packaging-$(PYTHON3_PACKAGING_VERSION)
PYTHON3_PACKAGING_SUFFIX	:= tar.gz
PYTHON3_PACKAGING_URL		:= $(call ptx/mirror-pypi, packaging, $(PYTHON3_PACKAGING).$(PYTHON3_PACKAGING_SUFFIX))
PYTHON3_PACKAGING_SOURCE	:= $(SRCDIR)/$(PYTHON3_PACKAGING).$(PYTHON3_PACKAGING_SUFFIX)
PYTHON3_PACKAGING_DIR		:= $(BUILDDIR)/$(PYTHON3_PACKAGING)
PYTHON3_PACKAGING_LICENSE	:= BSD-2-Clause OR Apache-2.0
PYTHON3_PACKAGING_LICENSE_FILES	:= \
	file://LICENSE;md5=faadaedca9251a90b205c9167578ce91 \
	file://LICENSE.APACHE;md5=2ee41112a44fe7014dce33e26468ba93 \
	file://LICENSE.BSD;md5=7bef9bf4a8e4263634d0597e7ba100b8

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
