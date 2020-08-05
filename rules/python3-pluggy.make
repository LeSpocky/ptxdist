# -*-makefile-*-
#
# Copyright (C) 2020 by Philipp Zabel <p.zabel@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_PLUGGY) += python3-pluggy

#
# Paths and names
#
PYTHON3_PLUGGY_VERSION	:= 0.13.1
PYTHON3_PLUGGY_MD5	:= 7f610e28b8b34487336b585a3dfb803d
PYTHON3_PLUGGY		:= pluggy-$(PYTHON3_PLUGGY_VERSION)
PYTHON3_PLUGGY_SUFFIX	:= tar.gz
PYTHON3_PLUGGY_URL	:= https://pypi.python.org/packages/source/p/pluggy/$(PYTHON3_PLUGGY).$(PYTHON3_PLUGGY_SUFFIX)
PYTHON3_PLUGGY_SOURCE	:= $(SRCDIR)/$(PYTHON3_PLUGGY).$(PYTHON3_PLUGGY_SUFFIX)
PYTHON3_PLUGGY_DIR	:= $(BUILDDIR)/$(PYTHON3_PLUGGY)
PYTHON3_PLUGGY_LICENSE	:= MIT
PYTHON3_PLUGGY_LICENSE_FILES := \
	file://LICENSE;md5=1c8206d16fd5cc02fa9b0bb98955e5c2

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_PLUGGY_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-pluggy.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-pluggy)
	@$(call install_fixup, python3-pluggy, PRIORITY, optional)
	@$(call install_fixup, python3-pluggy, SECTION, base)
	@$(call install_fixup, python3-pluggy, AUTHOR, "Philipp Zabel <p.zabel@pengutronix.de>")
	@$(call install_fixup, python3-pluggy, DESCRIPTION, missing)

	@$(call install_glob, python3-pluggy, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),, *.py)

	@$(call install_finish, python3-pluggy)

	@$(call touch)

# vim: syntax=make
