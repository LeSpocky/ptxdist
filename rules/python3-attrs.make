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
PACKAGES-$(PTXCONF_PYTHON3_ATTRS) += python3-attrs

#
# Paths and names
#
PYTHON3_ATTRS_VERSION	:= 20.2.0
PYTHON3_ATTRS_MD5	:= 7be95e1b35e9385d71a0017a48217efc
PYTHON3_ATTRS		:= attrs-$(PYTHON3_ATTRS_VERSION)
PYTHON3_ATTRS_SUFFIX	:= tar.gz
PYTHON3_ATTRS_URL	:= $(call ptx/mirror-pypi, attrs, $(PYTHON3_ATTRS).$(PYTHON3_ATTRS_SUFFIX))
PYTHON3_ATTRS_SOURCE	:= $(SRCDIR)/$(PYTHON3_ATTRS).$(PYTHON3_ATTRS_SUFFIX)
PYTHON3_ATTRS_DIR	:= $(BUILDDIR)/$(PYTHON3_ATTRS)
PYTHON3_ATTRS_LICENSE	:= MIT
PYTHON3_ATTRS_LICENSE_FILES := \
	file://LICENSE;md5=d4ab25949a73fe7d4fdee93bcbdbf8ff

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_ATTRS_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-attrs.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-attrs)
	@$(call install_fixup, python3-attrs, PRIORITY, optional)
	@$(call install_fixup, python3-attrs, SECTION, base)
	@$(call install_fixup, python3-attrs, AUTHOR, "Philipp Zabel <p.zabel@pengutronix.de>")
	@$(call install_fixup, python3-attrs, DESCRIPTION, missing)

	@$(call install_glob, python3-attrs, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),, *.py)

	@$(call install_finish, python3-attrs)

	@$(call touch)

# vim: syntax=make
