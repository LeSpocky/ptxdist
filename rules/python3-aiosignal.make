# -*-makefile-*-
#
# Copyright (C) 2022 by Enrico Jorns <e.joern@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_AIOSIGNAL) += python3-aiosignal

#
# Paths and names
#
PYTHON3_AIOSIGNAL_VERSION	:= 1.2.0
PYTHON3_AIOSIGNAL_MD5		:= 011700c3acc576a3a38deade6a4860cb
PYTHON3_AIOSIGNAL		:= aiosignal-$(PYTHON3_AIOSIGNAL_VERSION)
PYTHON3_AIOSIGNAL_SUFFIX	:= tar.gz
PYTHON3_AIOSIGNAL_URL		:= $(call ptx/mirror-pypi, aiosignal, $(PYTHON3_AIOSIGNAL).$(PYTHON3_AIOSIGNAL_SUFFIX))
PYTHON3_AIOSIGNAL_SOURCE	:= $(SRCDIR)/$(PYTHON3_AIOSIGNAL).$(PYTHON3_AIOSIGNAL_SUFFIX)
PYTHON3_AIOSIGNAL_DIR		:= $(BUILDDIR)/$(PYTHON3_AIOSIGNAL)
PYTHON3_AIOSIGNAL_LICENSE	:= Apache-2.0
PYTHON3_AIOSIGNAL_LICENSE_FILES	:= \
	file://LICENSE;md5=cf056e8e7a0a5477451af18b7b5aa98c

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_AIOSIGNAL_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-aiosignal.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-aiosignal)
	@$(call install_fixup, python3-aiosignal,PRIORITY,optional)
	@$(call install_fixup, python3-aiosignal,SECTION,base)
	@$(call install_fixup, python3-aiosignal,AUTHOR,"Enrico Jorns <e.joern@pengutronix.de>")
	@$(call install_fixup, python3-aiosignal,DESCRIPTION,"A project to manage callbacks in asyncio projects")

	@$(call install_glob, python3-aiosignal, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),, *.py)

	@$(call install_finish, python3-aiosignal)

	@$(call touch)

# vim: syntax=make
