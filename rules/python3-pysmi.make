# -*-makefile-*-
#
# Copyright (C) 2021 by Lars Pedersen <lapeddk@gmail.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_PYSMI) += python3-pysmi

#
# Paths and names
#
PYTHON3_PYSMI_VERSION	:= 0.3.4
PYTHON3_PYSMI_MD5	:= 10a9dd140ad512eed9f37344df83ce9d
PYTHON3_PYSMI		:= pysmi-$(PYTHON3_PYSMI_VERSION)
PYTHON3_PYSMI_SUFFIX	:= tar.gz
PYTHON3_PYSMI_URL	:= $(call ptx/mirror-pypi, pysmi, $(PYTHON3_PYSMI).$(PYTHON3_PYSMI_SUFFIX))
PYTHON3_PYSMI_SOURCE	:= $(SRCDIR)/$(PYTHON3_PYSMI).$(PYTHON3_PYSMI_SUFFIX)
PYTHON3_PYSMI_DIR	:= $(BUILDDIR)/$(PYTHON3_PYSMI)
PYTHON3_PYSMI_LICENSE	:= BSD-2-Clause
PYTHON3_PYSMI_LICENSE_FILES := \
	file://LICENSE.rst;md5=a088b5c72b59d51a5368ad3b18e219bf

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_PYSMI_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-pysmi.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-pysmi)
	@$(call install_fixup, python3-pysmi,PRIORITY,optional)
	@$(call install_fixup, python3-pysmi,SECTION,base)
	@$(call install_fixup, python3-pysmi,AUTHOR,"Lars Pedersen <lapeddk@gmail.com>")
	@$(call install_fixup, python3-pysmi,DESCRIPTION,missing)

	@$(call install_glob, python3-pysmi, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),, *.py)

	@$(call install_finish, python3-pysmi)

	@$(call touch)

# vim: syntax=make
