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
PACKAGES-$(PTXCONF_PYTHON3_PYSNMP) += python3-pysnmp

#
# Paths and names
#
PYTHON3_PYSNMP_VERSION	:= 4.4.12
PYTHON3_PYSNMP_SHA256	:= 0c3dbef2f958caca96071fe5c19de43e9c1b0484ab02a0cf08b190bcee768ba9
PYTHON3_PYSNMP		:= pysnmp-$(PYTHON3_PYSNMP_VERSION)
PYTHON3_PYSNMP_SUFFIX 	:= tar.gz
PYTHON3_PYSNMP_URL	:= $(call ptx/mirror-pypi, pysnmp, $(PYTHON3_PYSNMP).$(PYTHON3_PYSNMP_SUFFIX))
PYTHON3_PYSNMP_SOURCE	:= $(SRCDIR)/$(PYTHON3_PYSNMP).$(PYTHON3_PYSNMP_SUFFIX)
PYTHON3_PYSNMP_DIR	:= $(BUILDDIR)/$(PYTHON3_PYSNMP)
PYTHON3_PYSNMP_LICENSE	:= BSD-2-Clause
PYTHON3_PYSNMP_LICENSE_FILES := \
	file://LICENSE.rst;md5=b15d29f500f748d1c2a15709769090a8

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_PYSNMP_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-pysnmp.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-pysnmp)
	@$(call install_fixup, python3-pysnmp,PRIORITY,optional)
	@$(call install_fixup, python3-pysnmp,SECTION,base)
	@$(call install_fixup, python3-pysnmp,AUTHOR,"Lars Pedersen <lapeddk@gmail.com>")
	@$(call install_fixup, python3-pysnmp,DESCRIPTION,missing)

	# Install py files instead of pyc because of runtime marshal error
	@$(call install_glob,python3-pysnmp, 0, 0, -, \
		/usr/lib/python$(PYTHON3_MAJORMINOR)/site-packages,, *.pyc)

	@$(call install_finish, python3-pysnmp)

	@$(call touch)

# vim: syntax=make
