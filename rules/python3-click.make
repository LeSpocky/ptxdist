# -*-makefile-*-
#
# Copyright (C) 2025 by Markus Heidelberg <m.heidelberg@cab.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_CLICK) += python3-click

#
# Paths and names
#
PYTHON3_CLICK_VERSION		:= 8.1.8
PYTHON3_CLICK_MD5		:= b52ee8e6c33d88a2b4626e6a6002245d
PYTHON3_CLICK			:= click-$(PYTHON3_CLICK_VERSION)
PYTHON3_CLICK_SUFFIX		:= tar.gz
PYTHON3_CLICK_URL		:= $(call ptx/mirror-pypi, click, $(PYTHON3_CLICK).$(PYTHON3_CLICK_SUFFIX))
PYTHON3_CLICK_SOURCE		:= $(SRCDIR)/$(PYTHON3_CLICK).$(PYTHON3_CLICK_SUFFIX)
PYTHON3_CLICK_DIR		:= $(BUILDDIR)/$(PYTHON3_CLICK)
PYTHON3_CLICK_LICENSE		:= BSD-3-Clause
PYTHON3_CLICK_LICENSE_FILES	:= \
	file://docs/license.rst;md5=9c09fd3983d581cb05598a19742ff5df \
	file://pyproject.toml;startline=5;endline=5;md5=b5e378dbc689d60085f38e2fc52fc318 \
	file://LICENSE.txt;md5=1fa98232fd645608937a0fdc82e999b8

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_CLICK_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-click.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-click)
	@$(call install_fixup, python3-click,PRIORITY,optional)
	@$(call install_fixup, python3-click,SECTION,base)
	@$(call install_fixup, python3-click,AUTHOR,"Markus Heidelberg <m.heidelberg@cab.de>")
	@$(call install_fixup, python3-click,DESCRIPTION,missing)

	@$(call install_glob, python3-click, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),, *.py)

	@$(call install_finish, python3-click)

	@$(call touch)

# vim: syntax=make
