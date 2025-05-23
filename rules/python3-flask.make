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
PACKAGES-$(PTXCONF_PYTHON3_FLASK) += python3-flask

#
# Paths and names
#
PYTHON3_FLASK_VERSION		:= 3.1.0
PYTHON3_FLASK_MD5		:= c95d81666442bf04f7de7db7edbe2aff
PYTHON3_FLASK			:= flask-$(PYTHON3_FLASK_VERSION)
PYTHON3_FLASK_SUFFIX		:= tar.gz
PYTHON3_FLASK_URL		:= $(call ptx/mirror-pypi, flask, $(PYTHON3_FLASK).$(PYTHON3_FLASK_SUFFIX))
PYTHON3_FLASK_SOURCE		:= $(SRCDIR)/$(PYTHON3_FLASK).$(PYTHON3_FLASK_SUFFIX)
PYTHON3_FLASK_DIR		:= $(BUILDDIR)/$(PYTHON3_FLASK)
PYTHON3_FLASK_LICENSE		:= BSD-3-Clause
PYTHON3_FLASK_LICENSE_FILES	:= \
	file://docs/license.rst;md5=9c09fd3983d581cb05598a19742ff5df \
	file://pyproject.toml;startline=6;endline=6;md5=b5e378dbc689d60085f38e2fc52fc318 \
	file://LICENSE.txt;md5=ffeffa59c90c9c4a033c7574f8f3fb75

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_FLASK_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-flask.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-flask)
	@$(call install_fixup, python3-flask,PRIORITY,optional)
	@$(call install_fixup, python3-flask,SECTION,base)
	@$(call install_fixup, python3-flask,AUTHOR,"Markus Heidelberg <m.heidelberg@cab.de>")
	@$(call install_fixup, python3-flask,DESCRIPTION,missing)

	@$(call install_glob, python3-flask, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),, *.py)

	@$(call install_copy, python3-flask, 0, 0, 0755, -, /usr/bin/flask)

	@$(call install_finish, python3-flask)

	@$(call touch)

# vim: syntax=make
