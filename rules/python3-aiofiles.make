# -*-makefile-*-
#
# Copyright (C) 2018 by Bastian Stender <bst@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_AIOFILES) += python3-aiofiles

#
# Paths and names
#
PYTHON3_AIOFILES_VERSION	:= 0.8.0
PYTHON3_AIOFILES_MD5		:= 697deeb4fdcb620c45f114f173ed7c0d
PYTHON3_AIOFILES		:= aiofiles-$(PYTHON3_AIOFILES_VERSION)
PYTHON3_AIOFILES_SUFFIX		:= tar.gz
PYTHON3_AIOFILES_URL		:= $(call ptx/mirror-pypi, aiofiles, $(PYTHON3_AIOFILES).$(PYTHON3_AIOFILES_SUFFIX))
PYTHON3_AIOFILES_SOURCE		:= $(SRCDIR)/$(PYTHON3_AIOFILES).$(PYTHON3_AIOFILES_SUFFIX)
PYTHON3_AIOFILES_DIR		:= $(BUILDDIR)/$(PYTHON3_AIOFILES)
PYTHON3_AIOFILES_LICENSE	:= Apache-2.0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_AIOFILES_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-aiofiles.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-aiofiles)
	@$(call install_fixup, python3-aiofiles, PRIORITY, optional)
	@$(call install_fixup, python3-aiofiles, SECTION, base)
	@$(call install_fixup, python3-aiofiles, AUTHOR, "Bastian Stender <bst@pengutronix.de>")
	@$(call install_fixup, python3-aiofiles, DESCRIPTION, missing)

	@$(call install_glob, python3-aiofiles, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES)/aiofiles,, *.py)

	@$(call install_finish, python3-aiofiles)

	@$(call touch)

# vim: syntax=make
