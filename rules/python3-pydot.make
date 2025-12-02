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
PACKAGES-$(PTXCONF_PYTHON3_PYDOT) += python3-pydot

#
# Paths and names
#
PYTHON3_PYDOT_VERSION		:= 4.0.1
PYTHON3_PYDOT_MD5		:= ca020739825a4d6cc3bfcb57dba08460
PYTHON3_PYDOT			:= pydot-$(PYTHON3_PYDOT_VERSION)
PYTHON3_PYDOT_SUFFIX		:= tar.gz
PYTHON3_PYDOT_URL		:= $(call ptx/mirror-pypi, pydot, $(PYTHON3_PYDOT).$(PYTHON3_PYDOT_SUFFIX))
PYTHON3_PYDOT_SOURCE		:= $(SRCDIR)/$(PYTHON3_PYDOT).$(PYTHON3_PYDOT_SUFFIX)
PYTHON3_PYDOT_DIR		:= $(BUILDDIR)/$(PYTHON3_PYDOT)
PYTHON3_PYDOT_LICENSE		:= MIT AND Python-2.0
PYTHON3_PYDOT_LICENSE_FILES	:= \
	file://README.md;startline=252;endline=260;md5=77506fc37df43b60adaca86e24e2e819 \
	file://pyproject.toml;startline=13;endline=16;md5=856135553b53b2a31192376e7eb8be91 \
	file://LICENSES/MIT.txt;md5=7dda4e90ded66ab88b86f76169f28663 \
	file://LICENSES/Python-2.0.txt;md5=a13a605eb35c59f1295e7ad38386132e

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_PYDOT_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-pydot.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-pydot)
	@$(call install_fixup, python3-pydot,PRIORITY,optional)
	@$(call install_fixup, python3-pydot,SECTION,base)
	@$(call install_fixup, python3-pydot,AUTHOR,"Markus Heidelberg <m.heidelberg@cab.de>")
	@$(call install_fixup, python3-pydot,DESCRIPTION,missing)

	@$(call install_glob, python3-pydot, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),, *.py)

	@$(call install_finish, python3-pydot)

	@$(call touch)

# vim: ft=make
