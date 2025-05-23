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
PACKAGES-$(PTXCONF_PYTHON3_ITSDANGEROUS) += python3-itsdangerous

#
# Paths and names
#
PYTHON3_ITSDANGEROUS_VERSION		:= 2.2.0
PYTHON3_ITSDANGEROUS_MD5		:= a901babde35694c3577f7655010cd380
PYTHON3_ITSDANGEROUS			:= itsdangerous-$(PYTHON3_ITSDANGEROUS_VERSION)
PYTHON3_ITSDANGEROUS_SUFFIX		:= tar.gz
PYTHON3_ITSDANGEROUS_URL		:= $(call ptx/mirror-pypi, itsdangerous, $(PYTHON3_ITSDANGEROUS).$(PYTHON3_ITSDANGEROUS_SUFFIX))
PYTHON3_ITSDANGEROUS_SOURCE		:= $(SRCDIR)/$(PYTHON3_ITSDANGEROUS).$(PYTHON3_ITSDANGEROUS_SUFFIX)
PYTHON3_ITSDANGEROUS_DIR		:= $(BUILDDIR)/$(PYTHON3_ITSDANGEROUS)
PYTHON3_ITSDANGEROUS_LICENSE		:= BSD-3-Clause
PYTHON3_ITSDANGEROUS_LICENSE_FILES	:= \
	file://docs/license.rst;md5=9c09fd3983d581cb05598a19742ff5df \
	file://pyproject.toml;startline=6;endline=6;md5=0846f03a9beea6f15a2477895e27ac62 \
	file://LICENSE.txt;md5=4cda9a0ebd516714f360b0e9418cfb37

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_ITSDANGEROUS_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-itsdangerous.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-itsdangerous)
	@$(call install_fixup, python3-itsdangerous,PRIORITY,optional)
	@$(call install_fixup, python3-itsdangerous,SECTION,base)
	@$(call install_fixup, python3-itsdangerous,AUTHOR,"Markus Heidelberg <m.heidelberg@cab.de>")
	@$(call install_fixup, python3-itsdangerous,DESCRIPTION,missing)

	@$(call install_glob, python3-itsdangerous, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),, *.py)

	@$(call install_finish, python3-itsdangerous)

	@$(call touch)

# vim: syntax=make
