# -*-makefile-*-
#
# Copyright (C) 2016 by Florian Scherf <f.scherf@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_PTYPROCESS) += python3-ptyprocess

#
# Paths and names
#
PYTHON3_PTYPROCESS_VERSION	:= 0.6.0
PYTHON3_PTYPROCESS_SHA256	:= 923f299cc5ad920c68f2bc0bc98b75b9f838b93b599941a6b63ddbc2476394c0
PYTHON3_PTYPROCESS		:= ptyprocess-$(PYTHON3_PTYPROCESS_VERSION)
PYTHON3_PTYPROCESS_SUFFIX	:= tar.gz
PYTHON3_PTYPROCESS_URL		:= $(call ptx/mirror-pypi, ptyprocess, $(PYTHON3_PTYPROCESS).$(PYTHON3_PTYPROCESS_SUFFIX))
PYTHON3_PTYPROCESS_SOURCE	:= $(SRCDIR)/$(PYTHON3_PTYPROCESS).$(PYTHON3_PTYPROCESS_SUFFIX)
PYTHON3_PTYPROCESS_DIR		:= $(BUILDDIR)/$(PYTHON3_PTYPROCESS)
PYTHON3_PTYPROCESS_LICENSE	:= ISC

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_PTYPROCESS_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-ptyprocess.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-ptyprocess)
	@$(call install_fixup, python3-ptyprocess, PRIORITY, optional)
	@$(call install_fixup, python3-ptyprocess, SECTION, base)
	@$(call install_fixup, python3-ptyprocess, AUTHOR, "Florian Scherf <f.scherf@pengutronix.de>")
	@$(call install_fixup, python3-ptyprocess, DESCRIPTION, missing)

	@$(call install_glob, python3-ptyprocess, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES)/ptyprocess,, *.py)

	@$(call install_finish, python3-ptyprocess)

	@$(call touch)

# vim: syntax=make
