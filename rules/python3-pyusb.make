# -*-makefile-*-
#
# Copyright (C) 2023 by Jan Luebbe <jlu@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_PYUSB) += python3-pyusb

#
# Paths and names
#
PYTHON3_PYUSB_VERSION		:= 1.2.1
PYTHON3_PYUSB_MD5		:= 880008dff32dac8f58076b4e534492d9
PYTHON3_PYUSB			:= pyusb-$(PYTHON3_PYUSB_VERSION)
PYTHON3_PYUSB_SUFFIX		:= tar.gz
PYTHON3_PYUSB_URL		:= $(call ptx/mirror-pypi, pyusb, $(PYTHON3_PYUSB).$(PYTHON3_PYUSB_SUFFIX))
PYTHON3_PYUSB_SOURCE		:= $(SRCDIR)/$(PYTHON3_PYUSB).$(PYTHON3_PYUSB_SUFFIX)
PYTHON3_PYUSB_DIR		:= $(BUILDDIR)/$(PYTHON3_PYUSB)
PYTHON3_PYUSB_LICENSE		:= BSD-3-Clause
PYTHON3_PYUSB_LICENSE_FILES	:= \
	file://LICENSE;md5=e64a29fcd3c3dd356a24e235dfcb3905

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_PYUSB_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-pyusb.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-pyusb)
	@$(call install_fixup, python3-pyusb,PRIORITY,optional)
	@$(call install_fixup, python3-pyusb,SECTION,base)
	@$(call install_fixup, python3-pyusb,AUTHOR,"Jan Luebbe <jlu@pengutronix.de>")
	@$(call install_fixup, python3-pyusb,DESCRIPTION,missing)

	@$(call install_glob, python3-pyusb, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),, *.py)

	@$(call install_finish, python3-pyusb)

	@$(call touch)

# vim: syntax=make
