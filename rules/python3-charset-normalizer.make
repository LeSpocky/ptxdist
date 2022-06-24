# -*-makefile-*-
#
# Copyright (C) 2022 by Enrico Jorns <e.joerns@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_CHARSET_NORMALIZER) += python3-charset-normalizer

#
# Paths and names
#
PYTHON3_CHARSET_NORMALIZER_VERSION	:= 2.0.12
PYTHON3_CHARSET_NORMALIZER_MD5		:= f6664e0e90dbb3cc9cfc154a980f9864
PYTHON3_CHARSET_NORMALIZER		:= charset-normalizer-$(PYTHON3_CHARSET_NORMALIZER_VERSION)
PYTHON3_CHARSET_NORMALIZER_SUFFIX	:= tar.gz
PYTHON3_CHARSET_NORMALIZER_URL		:= $(call ptx/mirror-pypi, charset-normalizer, $(PYTHON3_CHARSET_NORMALIZER).$(PYTHON3_CHARSET_NORMALIZER_SUFFIX))
PYTHON3_CHARSET_NORMALIZER_SOURCE	:= $(SRCDIR)/$(PYTHON3_CHARSET_NORMALIZER).$(PYTHON3_CHARSET_NORMALIZER_SUFFIX)
PYTHON3_CHARSET_NORMALIZER_DIR		:= $(BUILDDIR)/$(PYTHON3_CHARSET_NORMALIZER)
PYTHON3_CHARSET_NORMALIZER_LICENSE	:= MIT
PYTHON3_CHARSET_NORMALIZER_LICENSE_FILES	:= file://LICENSE;md5=0974a390827087287db39928f7c524b5

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_CHARSET_NORMALIZER_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-charset-normalizer.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-charset-normalizer)
	@$(call install_fixup, python3-charset-normalizer,PRIORITY,optional)
	@$(call install_fixup, python3-charset-normalizer,SECTION,base)
	@$(call install_fixup, python3-charset-normalizer,AUTHOR,"Enrico Jorns <e.joerns@pengutronix.de>")
	@$(call install_fixup, python3-charset-normalizer,DESCRIPTION,"Truly universal encoding detector in pure Python")

	@$(call install_glob, python3-charset-normalizer, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),, *.py)

	@$(call install_finish, python3-charset-normalizer)

	@$(call touch)

# vim: syntax=make
