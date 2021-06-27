# -*-makefile-*-
#
# Copyright (C) 2018 by Artur Wiebe <artur@4wiebe.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_DATEUTIL) += python3-dateutil

PYTHON3_DATEUTIL_VERSION	:= 2.7.3
PYTHON3_DATEUTIL_MD5		:= 175b7c1a3cc0cb01151eced07c61c0b8
PYTHON3_DATEUTIL		:= python-dateutil-$(PYTHON3_DATEUTIL_VERSION)
PYTHON3_DATEUTIL_SUFFIX		:= tar.gz
PYTHON3_DATEUTIL_URL		:= $(call ptx/mirror-pypi, python-dateutil, $(PYTHON3_DATEUTIL).$(PYTHON3_DATEUTIL_SUFFIX))
PYTHON3_DATEUTIL_SOURCE		:= $(SRCDIR)/$(PYTHON3_DATEUTIL).$(PYTHON3_DATEUTIL_SUFFIX)
PYTHON3_DATEUTIL_DIR		:= $(BUILDDIR)/$(PYTHON3_DATEUTIL)
PYTHON3_DATEUTIL_LICENSE	:= Apache-2.0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_DATEUTIL_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-dateutil.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-dateutil)
	@$(call install_fixup,python3-dateutil,PRIORITY,optional)
	@$(call install_fixup,python3-dateutil,SECTION,base)
	@$(call install_fixup,python3-dateutil,AUTHOR,"Artur Wiebe <artur@4wiebe.de>")
	@$(call install_fixup,python3-dateutil,DESCRIPTION,missing)

	@$(call install_glob, python3-dateutil, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES)/dateutil,, *.py)

	@$(call install_finish,python3-dateutil)

	@$(call touch)

# vim: syntax=make
