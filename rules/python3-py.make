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
PACKAGES-$(PTXCONF_PYTHON3_PY) += python3-py

#
# Paths and names
#
PYTHON3_PY_VERSION	:= 1.9.0
PYTHON3_PY_MD5		:= b80db4e61eef724f49feb4d20b649e62
PYTHON3_PY		:= py-$(PYTHON3_PY_VERSION)
PYTHON3_PY_SUFFIX	:= tar.gz
PYTHON3_PY_URL		:= https://pypi.python.org/packages/source/p/py/$(PYTHON3_PY).$(PYTHON3_PY_SUFFIX)
PYTHON3_PY_SOURCE	:= $(SRCDIR)/$(PYTHON3_PY).$(PYTHON3_PY_SUFFIX)
PYTHON3_PY_DIR		:= $(BUILDDIR)/$(PYTHON3_PY)
PYTHON3_PY_LICENSE	:= MIT
PYTHON3_PY_LICENSE_FILES := \
	file://LICENSE;md5=a6bb0320b04a0a503f12f69fea479de9

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_PY_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-py.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-py)
	@$(call install_fixup, python3-py, PRIORITY, optional)
	@$(call install_fixup, python3-py, SECTION, base)
	@$(call install_fixup, python3-py, AUTHOR, "Philipp Zabel <p.zabel@pengutronix.de>")
	@$(call install_fixup, python3-py, DESCRIPTION, missing)

	@$(call install_glob, python3-py, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),, *.py)

	@$(call install_finish, python3-py)

	@$(call touch)

# vim: syntax=make
