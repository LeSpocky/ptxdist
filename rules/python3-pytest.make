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
PACKAGES-$(PTXCONF_PYTHON3_PYTEST) += python3-pytest

#
# Paths and names
#
PYTHON3_PYTEST_VERSION	:= 5.4.3
PYTHON3_PYTEST_MD5	:= 4b6b06b2818516c7c400d4cafe3b9257
PYTHON3_PYTEST		:= pytest-$(PYTHON3_PYTEST_VERSION)
PYTHON3_PYTEST_SUFFIX	:= tar.gz
PYTHON3_PYTEST_URL	:= https://pypi.python.org/packages/source/p/pytest/$(PYTHON3_PYTEST).$(PYTHON3_PYTEST_SUFFIX)
PYTHON3_PYTEST_SOURCE	:= $(SRCDIR)/$(PYTHON3_PYTEST).$(PYTHON3_PYTEST_SUFFIX)
PYTHON3_PYTEST_DIR	:= $(BUILDDIR)/$(PYTHON3_PYTEST)
PYTHON3_PYTEST_LICENSE	:= MIT
PYTHON3_PYTEST_LICENSE_FILES := \
	file://LICENSE;md5=81eb9f71d006c6b268cf4388e3c98f7b

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_PYTEST_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-pytest.install:
	@$(call targetinfo)
	@$(call world/install, PYTHON3_PYTEST)
	@sed -i 's;#!/.*;#!/usr/bin/python$(PYTHON3_MAJORMINOR);' \
		$(PYTHON3_PYTEST_PKGDIR)/usr/bin/*
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-pytest.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-pytest)
	@$(call install_fixup, python3-pytest, PRIORITY, optional)
	@$(call install_fixup, python3-pytest, SECTION, base)
	@$(call install_fixup, python3-pytest, AUTHOR, "Philipp Zabel <p.zabel@pengutronix.de>")
	@$(call install_fixup, python3-pytest, DESCRIPTION, missing)

	@$(call install_glob, python3-pytest, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES)/,, *.py)
	@$(call install_copy, python3-pytest, 0, 0, 0755, -, /usr/bin/pytest)
	@$(call install_link, python3-pytest, pytest, /usr/bin/py.test)

	@$(call install_finish, python3-pytest)

	@$(call touch)

# vim: syntax=make
