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
PACKAGES-$(PTXCONF_PYTHON3_PROMPT_TOOLKIT) += python3-prompt-toolkit

#
# Paths and names
#
PYTHON3_PROMPT_TOOLKIT_VERSION		:= 3.0.52
PYTHON3_PROMPT_TOOLKIT_MD5		:= 8d75b89a1478259c17130d4fab6de475
PYTHON3_PROMPT_TOOLKIT			:= prompt_toolkit-$(PYTHON3_PROMPT_TOOLKIT_VERSION)
PYTHON3_PROMPT_TOOLKIT_SUFFIX		:= tar.gz
PYTHON3_PROMPT_TOOLKIT_URL		:= $(call ptx/mirror-pypi, prompt-toolkit, $(PYTHON3_PROMPT_TOOLKIT).$(PYTHON3_PROMPT_TOOLKIT_SUFFIX))
PYTHON3_PROMPT_TOOLKIT_SOURCE		:= $(SRCDIR)/$(PYTHON3_PROMPT_TOOLKIT).$(PYTHON3_PROMPT_TOOLKIT_SUFFIX)
PYTHON3_PROMPT_TOOLKIT_DIR		:= $(BUILDDIR)/$(PYTHON3_PROMPT_TOOLKIT)
PYTHON3_PROMPT_TOOLKIT_LICENSE		:= BSD-3-Clause
PYTHON3_PROMPT_TOOLKIT_LICENSE_FILES	:= file://LICENSE;md5=b2cde7da89f0c1f3e49bf968d00d554f

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_PROMPT_TOOLKIT_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-prompt-toolkit.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-prompt-toolkit)
	@$(call install_fixup, python3-prompt-toolkit,PRIORITY,optional)
	@$(call install_fixup, python3-prompt-toolkit,SECTION,base)
	@$(call install_fixup, python3-prompt-toolkit,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, python3-prompt-toolkit,DESCRIPTION,missing)

	@$(call install_glob, python3-prompt-toolkit, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),, *.py)

	@$(call install_finish, python3-prompt-toolkit)

	@$(call touch)

# vim: ft=make
