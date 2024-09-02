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
PACKAGES-$(PTXCONF_PYTHON3_PYCRYPTODOMEX) += python3-pycryptodomex

#
# Paths and names
#
PYTHON3_PYCRYPTODOMEX_VERSION	:= 3.20.0
PYTHON3_PYCRYPTODOMEX_MD5	:= 0dc549942de42494e34e8670126471e9
PYTHON3_PYCRYPTODOMEX		:= pycryptodomex-$(PYTHON3_PYCRYPTODOMEX_VERSION)
PYTHON3_PYCRYPTODOMEX_SUFFIX	:= tar.gz
PYTHON3_PYCRYPTODOMEX_URL	:= $(call ptx/mirror-pypi, pycryptodomex, $(PYTHON3_PYCRYPTODOMEX).$(PYTHON3_PYCRYPTODOMEX_SUFFIX))
PYTHON3_PYCRYPTODOMEX_SOURCE	:= $(SRCDIR)/$(PYTHON3_PYCRYPTODOMEX).$(PYTHON3_PYCRYPTODOMEX_SUFFIX)
PYTHON3_PYCRYPTODOMEX_DIR	:= $(BUILDDIR)/$(PYTHON3_PYCRYPTODOMEX)
PYTHON3_PYCRYPTODOMEX_LICENSE	:= Unlicense AND BSD-2-Clause
PYTHON3_PYCRYPTODOMEX_LICENSE_FILES := \
	file://LICENSE.rst;md5=29242a70410a4eeff488a28164e7ab93

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_PYCRYPTODOMEX_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-pycryptodomex.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-pycryptodomex)
	@$(call install_fixup, python3-pycryptodomex,PRIORITY,optional)
	@$(call install_fixup, python3-pycryptodomex,SECTION,base)
	@$(call install_fixup, python3-pycryptodomex,AUTHOR,"Lars Pedersen <lapeddk@gmail.com>")
	@$(call install_fixup, python3-pycryptodomex,DESCRIPTION,missing)

	@$(call install_glob, python3-pycryptodomex, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),, *.py *SelfTest*)

	@$(call install_finish, python3-pycryptodomex)

	@$(call touch)

# vim: syntax=make
