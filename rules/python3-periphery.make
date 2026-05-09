# -*-makefile-*-
#
# Copyright (C) 2024 by Roland Hieber <rhi@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_PERIPHERY) += python3-periphery

#
# Paths and names
#
PYTHON3_PERIPHERY_VERSION	:= 2.4.1
PYTHON3_PERIPHERY_SHA256	:= 61d461d736982a6f766e878720ab10a68151e2e8c1086600d9389ac47e40e88a
PYTHON3_PERIPHERY		:= python-periphery-$(PYTHON3_PERIPHERY_VERSION)
PYTHON3_PERIPHERY_SUFFIX	:= tar.gz
PYTHON3_PERIPHERY_URL		:= $(call ptx/mirror-pypi, python-periphery, $(PYTHON3_PERIPHERY).$(PYTHON3_PERIPHERY_SUFFIX))
PYTHON3_PERIPHERY_SOURCE	:= $(SRCDIR)/$(PYTHON3_PERIPHERY).$(PYTHON3_PERIPHERY_SUFFIX)
PYTHON3_PERIPHERY_DIR		:= $(BUILDDIR)/$(PYTHON3_PERIPHERY)
PYTHON3_PERIPHERY_LICENSE	:= MIT
PYTHON3_PERIPHERY_LICENSE_FILES	:= \
	file://README.md;startline=202;endline=204;md5=bc9620815782faae308ef7bcf23bcecb \
	file://LICENSE;md5=30fe6f023a80fb33989fb3b9d773fea0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_PERIPHERY_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-periphery.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-periphery)
	@$(call install_fixup, python3-periphery,PRIORITY,optional)
	@$(call install_fixup, python3-periphery,SECTION,base)
	@$(call install_fixup, python3-periphery,AUTHOR,"Roland Hieber <rhi@pengutronix.de>")
	@$(call install_fixup, python3-periphery,DESCRIPTION,missing)

	@$(call install_glob, python3-periphery, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),, *.py)

	@$(call install_finish, python3-periphery)

	@$(call touch)

# vim: syntax=make
