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
PYTHON3_PYCRYPTODOMEX_VERSION	:= 3.10.1
PYTHON3_PYCRYPTODOMEX_MD5	:= 91b86ca7fa80d41179d7735067c7347a
PYTHON3_PYCRYPTODOMEX		:= pycryptodomex-$(PYTHON3_PYCRYPTODOMEX_VERSION)
PYTHON3_PYCRYPTODOMEX_SUFFIX	:= tar.gz
PYTHON3_PYCRYPTODOMEX_URL	:= $(call ptx/mirror-pypi, pycryptodomex, $(PYTHON3_PYCRYPTODOMEX).$(PYTHON3_PYCRYPTODOMEX_SUFFIX))
PYTHON3_PYCRYPTODOMEX_SOURCE	:= $(SRCDIR)/$(PYTHON3_PYCRYPTODOMEX).$(PYTHON3_PYCRYPTODOMEX_SUFFIX)
PYTHON3_PYCRYPTODOMEX_DIR	:= $(BUILDDIR)/$(PYTHON3_PYCRYPTODOMEX)
PYTHON3_PYCRYPTODOMEX_LICENSE	:= Unlicense AND BSD-2-Clause and custom
PYTHON3_PYCRYPTODOMEX_LICENSE_FILES := \
	file://LICENSE.rst;md5=accfa6aeaceb3ba96676edf18e78302c \
	file://Doc/ocb/license1.pdf;md5=e33fa8dcf4d10e5c0d9a9e9291714d3d \
	file://Doc/ocb/license2.pdf;md5=68cfc4690fbbaa0d89d3ea3abcc60b0f \
	file://Doc/ocb/license3.pdf;md5=2124679d48d559681738985e040ae388

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
