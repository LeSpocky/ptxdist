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
PACKAGES-$(PTXCONF_PYTHON3_BLINKER) += python3-blinker

#
# Paths and names
#
PYTHON3_BLINKER_VERSION		:= 1.9.0
PYTHON3_BLINKER_MD5		:= 1ffce54aca3d568ab18ee921d479274f
PYTHON3_BLINKER			:= blinker-$(PYTHON3_BLINKER_VERSION)
PYTHON3_BLINKER_SUFFIX		:= tar.gz
PYTHON3_BLINKER_URL		:= $(call ptx/mirror-pypi, blinker, $(PYTHON3_BLINKER).$(PYTHON3_BLINKER_SUFFIX))
PYTHON3_BLINKER_SOURCE		:= $(SRCDIR)/$(PYTHON3_BLINKER).$(PYTHON3_BLINKER_SUFFIX)
PYTHON3_BLINKER_DIR		:= $(BUILDDIR)/$(PYTHON3_BLINKER)
PYTHON3_BLINKER_LICENSE		:= MIT
PYTHON3_BLINKER_LICENSE_FILES	:= \
	file://docs/index.rst;startline=25;endline=26;md5=7185d5feb0e90f88de07e481cfdcf5f4 \
	file://pyproject.toml;startline=6;endline=6;md5=0846f03a9beea6f15a2477895e27ac62 \
	file://LICENSE.txt;md5=42cd19c88fc13d1307a4efd64ee90e4e

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_BLINKER_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-blinker.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-blinker)
	@$(call install_fixup, python3-blinker,PRIORITY,optional)
	@$(call install_fixup, python3-blinker,SECTION,base)
	@$(call install_fixup, python3-blinker,AUTHOR,"Markus Heidelberg <m.heidelberg@cab.de>")
	@$(call install_fixup, python3-blinker,DESCRIPTION,missing)

	@$(call install_glob, python3-blinker, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),, *.py)

	@$(call install_finish, python3-blinker)

	@$(call touch)

# vim: syntax=make
