# -*-makefile-*-
#
# Copyright (C) 2025 by Markus Heidelberg <m.heidelberg@cab.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_TELNETLIB3) += python3-telnetlib3

#
# Paths and names
#
PYTHON3_TELNETLIB3_VERSION		:= 2.0.8
PYTHON3_TELNETLIB3_MD5			:= effe967417ede0c7dadcc3ccd3263d5f
PYTHON3_TELNETLIB3			:= telnetlib3-$(PYTHON3_TELNETLIB3_VERSION)
PYTHON3_TELNETLIB3_SUFFIX		:= tar.gz
PYTHON3_TELNETLIB3_URL			:= $(call ptx/mirror-pypi, telnetlib3, $(PYTHON3_TELNETLIB3).$(PYTHON3_TELNETLIB3_SUFFIX))
PYTHON3_TELNETLIB3_SOURCE		:= $(SRCDIR)/$(PYTHON3_TELNETLIB3).$(PYTHON3_TELNETLIB3_SUFFIX)
PYTHON3_TELNETLIB3_DIR			:= $(BUILDDIR)/$(PYTHON3_TELNETLIB3)
PYTHON3_TELNETLIB3_LICENSE		:= ISC AND Python-2.0
PYTHON3_TELNETLIB3_LICENSE_FILES	:= \
	file://setup.py;startline=19;endline=19;md5=de8d023adf0e761ff2f374af7aa71a4a \
	file://LICENSE.txt;md5=b2cbfe1ec99d8830fa20d62c8f21d0e8

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_TELNETLIB3_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-telnetlib3.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-telnetlib3)
	@$(call install_fixup, python3-telnetlib3,PRIORITY,optional)
	@$(call install_fixup, python3-telnetlib3,SECTION,base)
	@$(call install_fixup, python3-telnetlib3,AUTHOR,"Markus Heidelberg <m.heidelberg@cab.de>")
	@$(call install_fixup, python3-telnetlib3,DESCRIPTION,missing)

	@$(call install_glob, python3-telnetlib3, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),, *.py)

	@$(call install_finish, python3-telnetlib3)

	@$(call touch)

# vim: ft=make
