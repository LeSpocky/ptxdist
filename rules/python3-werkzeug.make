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
PACKAGES-$(PTXCONF_PYTHON3_WERKZEUG) += python3-werkzeug

#
# Paths and names
#
PYTHON3_WERKZEUG_VERSION	:= 3.1.3
PYTHON3_WERKZEUG_MD5		:= b6005d403d01d08b9fe2330a0cfea05a
PYTHON3_WERKZEUG		:= werkzeug-$(PYTHON3_WERKZEUG_VERSION)
PYTHON3_WERKZEUG_SUFFIX		:= tar.gz
PYTHON3_WERKZEUG_URL		:= $(call ptx/mirror-pypi, werkzeug, $(PYTHON3_WERKZEUG).$(PYTHON3_WERKZEUG_SUFFIX))
PYTHON3_WERKZEUG_SOURCE		:= $(SRCDIR)/$(PYTHON3_WERKZEUG).$(PYTHON3_WERKZEUG_SUFFIX)
PYTHON3_WERKZEUG_DIR		:= $(BUILDDIR)/$(PYTHON3_WERKZEUG)
PYTHON3_WERKZEUG_LICENSE	:= BSD-3-Clause
PYTHON3_WERKZEUG_LICENSE_FILES	:= \
	file://docs/license.rst;md5=9c09fd3983d581cb05598a19742ff5df \
	file://pyproject.toml;startline=6;endline=6;md5=b5e378dbc689d60085f38e2fc52fc318 \
	file://LICENSE.txt;md5=5dc88300786f1c214c1e9827a5229462

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_WERKZEUG_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-werkzeug.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-werkzeug)
	@$(call install_fixup, python3-werkzeug,PRIORITY,optional)
	@$(call install_fixup, python3-werkzeug,SECTION,base)
	@$(call install_fixup, python3-werkzeug,AUTHOR,"Markus Heidelberg <m.heidelberg@cab.de>")
	@$(call install_fixup, python3-werkzeug,DESCRIPTION,missing)

	@$(call install_glob, python3-werkzeug, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),, *.py)

	@$(call install_finish, python3-werkzeug)

	@$(call touch)

# vim: syntax=make
