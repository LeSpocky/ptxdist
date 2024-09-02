# -*-makefile-*-
#
# Copyright (C) 2020 by Bastian Krause <bst@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_SQLPARSE) += python3-sqlparse

#
# Paths and names
#
PYTHON3_SQLPARSE_VERSION	:= 0.5.1
PYTHON3_SQLPARSE_MD5		:= 969a64f03d7da1144fc74aad390f9db4
PYTHON3_SQLPARSE		:= sqlparse-$(PYTHON3_SQLPARSE_VERSION)
PYTHON3_SQLPARSE_SUFFIX		:= tar.gz
PYTHON3_SQLPARSE_URL		:= $(call ptx/mirror-pypi, sqlparse, $(PYTHON3_SQLPARSE).$(PYTHON3_SQLPARSE_SUFFIX))
PYTHON3_SQLPARSE_SOURCE		:= $(SRCDIR)/$(PYTHON3_SQLPARSE).$(PYTHON3_SQLPARSE_SUFFIX)
PYTHON3_SQLPARSE_DIR		:= $(BUILDDIR)/$(PYTHON3_SQLPARSE)
PYTHON3_SQLPARSE_LICENSE	:= BSD-3-Clause
PYTHON3_SQLPARSE_LICENSE_FILES := \
	file://LICENSE;md5=2b136f573f5386001ea3b7b9016222fc \

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_SQLPARSE_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-sqlparse.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-sqlparse)
	@$(call install_fixup, python3-sqlparse, PRIORITY, optional)
	@$(call install_fixup, python3-sqlparse, SECTION, base)
	@$(call install_fixup, python3-sqlparse, AUTHOR, "Bastian Krause <bst@pengutronix.de>")
	@$(call install_fixup, python3-sqlparse, DESCRIPTION, missing)

	@$(call install_glob, python3-sqlparse, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),, *.py)

	@$(call install_finish, python3-sqlparse)

	@$(call touch)

# vim: syntax=make
