# -*-makefile-*-
#
# Copyright (C) 2023 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_JOBLIB) += python3-joblib

#
# Paths and names
#
PYTHON3_JOBLIB_VERSION		:= 1.3.2
PYTHON3_JOBLIB_MD5		:= d3b410f1d0681e5ad48a83b0d692e0fd
PYTHON3_JOBLIB			:= joblib-$(PYTHON3_JOBLIB_VERSION)
PYTHON3_JOBLIB_SUFFIX		:= tar.gz
PYTHON3_JOBLIB_URL		:= $(call ptx/mirror-pypi, joblib, $(PYTHON3_JOBLIB).$(PYTHON3_JOBLIB_SUFFIX))
PYTHON3_JOBLIB_SOURCE		:= $(SRCDIR)/$(PYTHON3_JOBLIB).$(PYTHON3_JOBLIB_SUFFIX)
PYTHON3_JOBLIB_DIR		:= $(BUILDDIR)/$(PYTHON3_JOBLIB)
PYTHON3_JOBLIB_LICENSE		:= BSD-3-Clause
PYTHON3_JOBLIB_LICENSE_FILES	:= file://LICENSE.txt;md5=2e481820abf0a70a18011a30153df066

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_JOBLIB_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-joblib.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-joblib)
	@$(call install_fixup, python3-joblib,PRIORITY,optional)
	@$(call install_fixup, python3-joblib,SECTION,base)
	@$(call install_fixup, python3-joblib,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, python3-joblib,DESCRIPTION,missing)

	@$(call install_glob, python3-joblib, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),, *.py */test/*)

	@$(call install_finish, python3-joblib)

	@$(call touch)

# vim: syntax=make
