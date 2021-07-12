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
PACKAGES-$(PTXCONF_PYTHON3_PYASN1) += python3-pyasn1

#
# Paths and names
#
PYTHON3_PYASN1_VERSION	:= 0.4.8
PYTHON3_PYASN1_MD5	:= dffae4ff9f997a83324b3f33fe62be54
PYTHON3_PYASN1		:= pyasn1-$(PYTHON3_PYASN1_VERSION)
PYTHON3_PYASN1_SUFFIX	:= tar.gz
PYTHON3_PYASN1_URL	:= $(call ptx/mirror-pypi, pyasn1, $(PYTHON3_PYASN1).$(PYTHON3_PYASN1_SUFFIX))
PYTHON3_PYASN1_SOURCE	:= $(SRCDIR)/$(PYTHON3_PYASN1).$(PYTHON3_PYASN1_SUFFIX)
PYTHON3_PYASN1_DIR	:= $(BUILDDIR)/$(PYTHON3_PYASN1)
PYTHON3_PYASN1_LICENSE	:= BSD-2-Clause
PYTHON3_PYASN1_LICENSE_FILES := \
	file://LICENSE.rst;md5=a14482d15c2249de3b6f0e8a47e021fd

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_PYASN1_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------
$(STATEDIR)/python3-pyasn1.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-pyasn1)
	@$(call install_fixup, python3-pyasn1,PRIORITY,optional)
	@$(call install_fixup, python3-pyasn1,SECTION,base)
	@$(call install_fixup, python3-pyasn1,AUTHOR,"Lars Pedersen <lapeddk@gmail.com>")
	@$(call install_fixup, python3-pyasn1,DESCRIPTION,missing)

	@$(call install_glob,python3-pyasn1, 0, 0, -, \
		/usr/lib/python$(PYTHON3_MAJORMINOR)/site-packages,, *.py)

	@$(call install_finish, python3-pyasn1)

	@$(call touch)

# vim: syntax=make
