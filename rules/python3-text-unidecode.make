# -*-makefile-*-
#
# Copyright (C) 2019 by Lars Pedersen <lapeddk@gmail.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_TEXT_UNIDECODE) += python3-text-unidecode

#
# Paths and names
#
PYTHON3_TEXT_UNIDECODE_VERSION	:= 1.3
PYTHON3_TEXT_UNIDECODE_MD5	:= 53a0a6c5aef8f5eb5834e78e0fdf0499
PYTHON3_TEXT_UNIDECODE		:= text-unidecode-$(PYTHON3_TEXT_UNIDECODE_VERSION)
PYTHON3_TEXT_UNIDECODE_SUFFIX	:= tar.gz
PYTHON3_TEXT_UNIDECODE_URL	:= https://files.pythonhosted.org/packages/source/t/text-unidecode/$(PYTHON3_TEXT_UNIDECODE).$(PYTHON3_TEXT_UNIDECODE_SUFFIX)
PYTHON3_TEXT_UNIDECODE_SOURCE	:= $(SRCDIR)/$(PYTHON3_TEXT_UNIDECODE).$(PYTHON3_TEXT_UNIDECODE_SUFFIX)
PYTHON3_TEXT_UNIDECODE_DIR	:= $(BUILDDIR)/$(PYTHON3_TEXT_UNIDECODE)
PYTHON3_TEXT_UNIDECODE_LICENSE	:= ClArtistic
PYTHON3_TEXT_UNIDECODE_LICENSE_FILES	:= \
	file://LICENSE;md5=ccfb8875bc60bc3d6e91e42e5e8f5587

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_TEXT_UNIDECODE_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-text-unidecode.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-text-unidecode)
	@$(call install_fixup, python3-text-unidecode,PRIORITY,optional)
	@$(call install_fixup, python3-text-unidecode,SECTION,base)
	@$(call install_fixup, python3-text-unidecode,AUTHOR,"Lars Pedersen <lapeddk@gmail.com>")
	@$(call install_fixup, python3-text-unidecode,DESCRIPTION,missing)

	@$(call install_glob,python3-text-unidecode, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),*.pyc *.bin, )

	@$(call install_finish, python3-text-unidecode)

	@$(call touch)

# vim: syntax=make
