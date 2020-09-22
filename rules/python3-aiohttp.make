# -*-makefile-*-
#
# Copyright (C) 2015 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_AIOHTTP) += python3-aiohttp

#
# Paths and names
#
PYTHON3_AIOHTTP_VERSION	:= 3.6.2
PYTHON3_AIOHTTP_MD5	:= ca40144c199a09fc1a141960cf6295f0
PYTHON3_AIOHTTP		:= aiohttp-$(PYTHON3_AIOHTTP_VERSION)
PYTHON3_AIOHTTP_SUFFIX	:= tar.gz
PYTHON3_AIOHTTP_URL	:= $(call ptx/mirror-pypi, aiohttp, $(PYTHON3_AIOHTTP).$(PYTHON3_AIOHTTP_SUFFIX))
PYTHON3_AIOHTTP_SOURCE	:= $(SRCDIR)/$(PYTHON3_AIOHTTP).$(PYTHON3_AIOHTTP_SUFFIX)
PYTHON3_AIOHTTP_DIR	:= $(BUILDDIR)/$(PYTHON3_AIOHTTP)
PYTHON3_AIOHTTP_LICENSE	:= Apache-2.0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_AIOHTTP_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-aiohttp.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-aiohttp)
	@$(call install_fixup, python3-aiohttp,PRIORITY,optional)
	@$(call install_fixup, python3-aiohttp,SECTION,base)
	@$(call install_fixup, python3-aiohttp,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, python3-aiohttp,DESCRIPTION,missing)

	@$(call install_glob, python3-aiohttp, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES)/aiohttp,, *.py)

	@$(call install_finish, python3-aiohttp)

	@$(call touch)

# vim: syntax=make
