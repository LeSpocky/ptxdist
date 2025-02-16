# -*-makefile-*-
#
# Copyright (C) 2025 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_PYPERF) += python3-pyperf

#
# Paths and names
#
PYTHON3_PYPERF_VERSION		:= 2.8.1
PYTHON3_PYPERF_MD5		:= 44cee8949ce6591d0282b4646d7843a2
PYTHON3_PYPERF			:= pyperf-$(PYTHON3_PYPERF_VERSION)
PYTHON3_PYPERF_SUFFIX		:= tar.gz
PYTHON3_PYPERF_URL		:= $(call ptx/mirror-pypi, pyperf, $(PYTHON3_PYPERF).$(PYTHON3_PYPERF_SUFFIX))
PYTHON3_PYPERF_SOURCE		:= $(SRCDIR)/$(PYTHON3_PYPERF).$(PYTHON3_PYPERF_SUFFIX)
PYTHON3_PYPERF_DIR		:= $(BUILDDIR)/$(PYTHON3_PYPERF)
PYTHON3_PYPERF_LICENSE		:= MIT
PYTHON3_PYPERF_LICENSE_FILES	:= \
	file://COPYING;md5=78bc2e6e87c8c61272937b879e6dc2f8

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_PYPERF_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-pyperf.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-pyperf)
	@$(call install_fixup, python3-pyperf,PRIORITY,optional)
	@$(call install_fixup, python3-pyperf,SECTION,base)
	@$(call install_fixup, python3-pyperf,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, python3-pyperf,DESCRIPTION,missing)

	@$(call install_glob, python3-pyperf, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),, *.py)

	@$(call install_copy, python3-pyperf, 0, 0, 0755, -, \
		/usr/bin/pyperf)

	@$(call install_finish, python3-pyperf)

	@$(call touch)

# vim: syntax=make
