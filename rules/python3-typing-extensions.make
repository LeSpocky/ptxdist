# -*-makefile-*-
#
# Copyright (C) 2026 by Lars Pedersen <lapeddk@gmail.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_TYPING_EXTENSIONS) += python3-typing-extensions

#
# Paths and names
#
PYTHON3_TYPING_EXTENSIONS_VERSION	:= 4.15.0
PYTHON3_TYPING_EXTENSIONS_SHA256	:= 0cea48d173cc12fa28ecabc3b837ea3cf6f38c6d1136f85cbaaf598984861466
PYTHON3_TYPING_EXTENSIONS		:= typing_extensions-$(PYTHON3_TYPING_EXTENSIONS_VERSION)
PYTHON3_TYPING_EXTENSIONS_SUFFIX	:= tar.gz
PYTHON3_TYPING_EXTENSIONS_URL		:= $(call ptx/mirror-pypi, typing-extensions, $(PYTHON3_TYPING_EXTENSIONS).$(PYTHON3_TYPING_EXTENSIONS_SUFFIX))
PYTHON3_TYPING_EXTENSIONS_SOURCE	:= $(SRCDIR)/$(PYTHON3_TYPING_EXTENSIONS).$(PYTHON3_TYPING_EXTENSIONS_SUFFIX)
PYTHON3_TYPING_EXTENSIONS_DIR		:= $(BUILDDIR)/$(PYTHON3_TYPING_EXTENSIONS)
PYTHON3_TYPING_EXTENSIONS_LICENSE	:= PSF-2.0
PYTHON3_TYPING_EXTENSIONS_LICENSE_FILES	:= \
	file://LICENSE;md5=fcf6b249c2641540219a727f35d8d2c2

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_TYPING_EXTENSIONS_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-typing-extensions.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-typing-extensions)
	@$(call install_fixup, python3-typing-extensions,PRIORITY,optional)
	@$(call install_fixup, python3-typing-extensions,SECTION,base)
	@$(call install_fixup, python3-typing-extensions,AUTHOR,"Lars Pedersen <lapeddk@gmail.com>")
	@$(call install_fixup, python3-typing-extensions,DESCRIPTION,missing)

	@$(call install_glob, python3-typing-extensions, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),, *.py)

	@$(call install_finish, python3-typing-extensions)

	@$(call touch)

# vim: ft=make
