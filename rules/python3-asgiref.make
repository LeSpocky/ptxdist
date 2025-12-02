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
PACKAGES-$(PTXCONF_PYTHON3_ASGIREF) += python3-asgiref

#
# Paths and names
#
PYTHON3_ASGIREF_VERSION		:= 3.11.0
PYTHON3_ASGIREF_MD5		:= 554794453502d266a90d2254fcb1f7c3
PYTHON3_ASGIREF			:= asgiref-$(PYTHON3_ASGIREF_VERSION)
PYTHON3_ASGIREF_SUFFIX		:= tar.gz
PYTHON3_ASGIREF_URL		:= $(call ptx/mirror-pypi, asgiref, $(PYTHON3_ASGIREF).$(PYTHON3_ASGIREF_SUFFIX))
PYTHON3_ASGIREF_SOURCE		:= $(SRCDIR)/$(PYTHON3_ASGIREF).$(PYTHON3_ASGIREF_SUFFIX)
PYTHON3_ASGIREF_DIR		:= $(BUILDDIR)/$(PYTHON3_ASGIREF)
PYTHON3_ASGIREF_LICENSE		:= BSD-3-Clause
PYTHON3_ASGIREF_LICENSE_FILES	:= \
	file://setup.cfg;startline=9;endline=9;md5=5add1cb06b7427acea35025b0f8990e9 \
	file://LICENSE;md5=f09eb47206614a4954c51db8a94840fa

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_ASGIREF_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-asgiref.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-asgiref)
	@$(call install_fixup, python3-asgiref,PRIORITY,optional)
	@$(call install_fixup, python3-asgiref,SECTION,base)
	@$(call install_fixup, python3-asgiref,AUTHOR,"Markus Heidelberg <m.heidelberg@cab.de>")
	@$(call install_fixup, python3-asgiref,DESCRIPTION,missing)

	@$(call install_glob, python3-asgiref, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),, *.py)

	@$(call install_finish, python3-asgiref)

	@$(call touch)

# vim: ft=make
