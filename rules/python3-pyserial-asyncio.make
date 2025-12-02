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
PACKAGES-$(PTXCONF_PYTHON3_PYSERIAL_ASYNCIO) += python3-pyserial-asyncio

#
# Paths and names
#
PYTHON3_PYSERIAL_ASYNCIO_VERSION	:= 0.6
PYTHON3_PYSERIAL_ASYNCIO_MD5		:= 409f32a35a3b530e6b2224e2a5b367da
PYTHON3_PYSERIAL_ASYNCIO		:= pyserial-asyncio-$(PYTHON3_PYSERIAL_ASYNCIO_VERSION)
PYTHON3_PYSERIAL_ASYNCIO_SUFFIX		:= tar.gz
PYTHON3_PYSERIAL_ASYNCIO_URL		:= $(call ptx/mirror-pypi, pyserial-asyncio, $(PYTHON3_PYSERIAL_ASYNCIO).$(PYTHON3_PYSERIAL_ASYNCIO_SUFFIX))
PYTHON3_PYSERIAL_ASYNCIO_SOURCE		:= $(SRCDIR)/$(PYTHON3_PYSERIAL_ASYNCIO).$(PYTHON3_PYSERIAL_ASYNCIO_SUFFIX)
PYTHON3_PYSERIAL_ASYNCIO_DIR		:= $(BUILDDIR)/$(PYTHON3_PYSERIAL_ASYNCIO)
PYTHON3_PYSERIAL_ASYNCIO_LICENSE	:= BSD-3-Clause
PYTHON3_PYSERIAL_ASYNCIO_LICENSE_FILES	:= \
	file://serial_asyncio/__init__.py;startline=6;endline=9;md5=61bcbf6ef10a905e8c7a091e7a5d19c0 \
	file://LICENSE.txt;md5=9a79418f241689e78034391d51162d24

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_PYSERIAL_ASYNCIO_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-pyserial-asyncio.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-pyserial-asyncio)
	@$(call install_fixup, python3-pyserial-asyncio,PRIORITY,optional)
	@$(call install_fixup, python3-pyserial-asyncio,SECTION,base)
	@$(call install_fixup, python3-pyserial-asyncio,AUTHOR,"Markus Heidelberg <m.heidelberg@cab.de>")
	@$(call install_fixup, python3-pyserial-asyncio,DESCRIPTION,missing)

	@$(call install_glob, python3-pyserial-asyncio, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),, *.py)

	@$(call install_finish, python3-pyserial-asyncio)

	@$(call touch)

# vim: ft=make
