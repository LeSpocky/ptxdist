# -*-makefile-*-
#
# Copyright (C) 2025 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_DULWICH) += python3-dulwich

#
# Paths and names
#
PYTHON3_DULWICH_VERSION		:= 0.22.7
PYTHON3_DULWICH_MD5		:= 02b457c9387d08758b1e06fd5b4a9048
PYTHON3_DULWICH			:= dulwich-$(PYTHON3_DULWICH_VERSION)
PYTHON3_DULWICH_SUFFIX		:= tar.gz
PYTHON3_DULWICH_URL		:= $(call ptx/mirror-pypi, dulwich, $(PYTHON3_DULWICH).$(PYTHON3_DULWICH_SUFFIX))
PYTHON3_DULWICH_SOURCE		:= $(SRCDIR)/$(PYTHON3_DULWICH).$(PYTHON3_DULWICH_SUFFIX)
PYTHON3_DULWICH_DIR		:= $(BUILDDIR)/$(PYTHON3_DULWICH)
PYTHON3_DULWICH_CARGO_LOCK	:= Cargo.lock
PYTHON3_DULWICH_LICENSE		:= (Apache-2.0 OR GPL-2.0-or-later) AND unknown
PYTHON3_DULWICH_LICENSE_FILES	:= \
	file://dulwich/__init__.py;startline=5;endline=9;md5=2f2fcc65667045106cad811e6490283b \
	file://COPYING;md5=d45757cfddbd32c1cd3132cf3b444d4f

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_DULWICH_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-dulwich.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-dulwich)
	@$(call install_fixup, python3-dulwich,PRIORITY,optional)
	@$(call install_fixup, python3-dulwich,SECTION,base)
	@$(call install_fixup, python3-dulwich,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, python3-dulwich,DESCRIPTION,missing)

	@$(call install_glob, python3-dulwich, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),, *.py)

	@$(call install_finish, python3-dulwich)

	@$(call touch)

# vim: syntax=make
