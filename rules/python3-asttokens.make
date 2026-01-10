# -*-makefile-*-
#
# Copyright (C) 2026 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_ASTTOKENS) += python3-asttokens

#
# Paths and names
#
PYTHON3_ASTTOKENS_VERSION	:= 3.0.1
PYTHON3_ASTTOKENS_MD5		:= 50670141dde921f807d8257be4a5df9c
PYTHON3_ASTTOKENS		:= asttokens-$(PYTHON3_ASTTOKENS_VERSION)
PYTHON3_ASTTOKENS_SUFFIX	:= tar.gz
PYTHON3_ASTTOKENS_URL		:= $(call ptx/mirror-pypi, asttokens, $(PYTHON3_ASTTOKENS).$(PYTHON3_ASTTOKENS_SUFFIX))
PYTHON3_ASTTOKENS_SOURCE	:= $(SRCDIR)/$(PYTHON3_ASTTOKENS).$(PYTHON3_ASTTOKENS_SUFFIX)
PYTHON3_ASTTOKENS_DIR		:= $(BUILDDIR)/$(PYTHON3_ASTTOKENS)
PYTHON3_ASTTOKENS_LICENSE	:= Apache-2.0
PYTHON3_ASTTOKENS_LICENSE_FILES	:= file://LICENSE;md5=3d9b931fa23ab1cacd0087f9e2ee12c0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_ASTTOKENS_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-asttokens.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-asttokens)
	@$(call install_fixup, python3-asttokens,PRIORITY,optional)
	@$(call install_fixup, python3-asttokens,SECTION,base)
	@$(call install_fixup, python3-asttokens,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, python3-asttokens,DESCRIPTION,missing)

	@$(call install_glob, python3-asttokens, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),, *.py)

	@$(call install_finish, python3-asttokens)

	@$(call touch)

# vim: ft=make
