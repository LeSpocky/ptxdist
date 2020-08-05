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
PACKAGES-$(PTXCONF_PYTHON3_INIHERIT) += python3-iniherit

#
# Paths and names
#
PYTHON3_INIHERIT_VERSION	:= 0.3.9
PYTHON3_INIHERIT_MD5		:= 0e501d38a1ad7c9bde7bff9387d4a582
PYTHON3_INIHERIT		:= iniherit-$(PYTHON3_INIHERIT_VERSION)
PYTHON3_INIHERIT_SUFFIX		:= tar.gz
PYTHON3_INIHERIT_URL		:= https://files.pythonhosted.org/packages/source/i/iniherit/$(PYTHON3_INIHERIT).$(PYTHON3_INIHERIT_SUFFIX)
PYTHON3_INIHERIT_SOURCE		:= $(SRCDIR)/$(PYTHON3_INIHERIT).$(PYTHON3_INIHERIT_SUFFIX)
PYTHON3_INIHERIT_DIR		:= $(BUILDDIR)/$(PYTHON3_INIHERIT)
PYTHON3_INIHERIT_LICENSE	:= MIT
PYTHON3_INIHERIT_LICENSE_FILES	:= \
	file://LICENSE.txt;md5=ccfdd023b4e59440af77d101a05dc5ed

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_INIHERIT_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-iniherit.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-iniherit)
	@$(call install_fixup, python3-iniherit,PRIORITY,optional)
	@$(call install_fixup, python3-iniherit,SECTION,base)
	@$(call install_fixup, python3-iniherit,AUTHOR,"Lars Pedersen <lapeddk@gmail.com>")
	@$(call install_fixup, python3-iniherit,DESCRIPTION,missing)

	@$(call install_glob,python3-iniherit, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),*.pyc,)

	@$(call install_finish, python3-iniherit)

	@$(call touch)

# vim: syntax=make
