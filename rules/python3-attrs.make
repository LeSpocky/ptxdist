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
PYTHON3_ATTRS_VERSION	:= 19.3.0
PYTHON3_ATTRS_MD5	:= 5b2db50fcc31be34d32798183c9bd062
PYTHON3_ATTRS		:= attrs-$(PYTHON3_ATTRS_VERSION)
PYTHON3_ATTRS_SUFFIX	:= tar.gz
PYTHON3_ATTRS_URL	:= https://pypi.python.org/packages/source/a/attrs/$(PYTHON3_ATTRS).$(PYTHON3_ATTRS_SUFFIX)
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
		/usr/lib/python$(PYTHON3_MAJORMINOR)/site-packages,, *.py)

	@$(call install_finish, python3-attrs)

	@$(call touch)

# vim: syntax=make
