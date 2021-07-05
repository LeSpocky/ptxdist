# -*-makefile-*-
#
# Copyright (C) 2021 by Lars Pedersen <lapeddk@gmail.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_TABULATE) += python3-tabulate

#
# Paths and names
#
PYTHON3_TABULATE_VERSION	:= 0.8.9
PYTHON3_TABULATE_MD5		:= 71e6f214512ceda2892be47767156754
PYTHON3_TABULATE		:= tabulate-$(PYTHON3_TABULATE_VERSION)
PYTHON3_TABULATE_SUFFIX		:= tar.gz
PYTHON3_TABULATE_URL		:= $(call ptx/mirror-pypi, tabulate, $(PYTHON3_TABULATE).$(PYTHON3_TABULATE_SUFFIX))
PYTHON3_TABULATE_SOURCE		:= $(SRCDIR)/$(PYTHON3_TABULATE).$(PYTHON3_TABULATE_SUFFIX)
PYTHON3_TABULATE_DIR		:= $(BUILDDIR)/$(PYTHON3_TABULATE)
PYTHON3_TABULATE_LICENSE	:= MIT
PYTHON3_TABULATE_LICENSE_FILES := \
	file://LICENSE;md5=fad5a39bdfe452b13775adda41023ba7

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_TABULATE_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-tabulate.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-tabulate)
	@$(call install_fixup, python3-tabulate,PRIORITY,optional)
	@$(call install_fixup, python3-tabulate,SECTION,base)
	@$(call install_fixup, python3-tabulate,AUTHOR,"Lars Pedersen <lapeddk@gmail.com>")
	@$(call install_fixup, python3-tabulate,DESCRIPTION,missing)

	@$(call install_glob, python3-tabulate, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),, *.py)

	@$(call install_finish, python3-tabulate)

	@$(call touch)

# vim: syntax=make
