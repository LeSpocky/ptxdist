# -*-makefile-*-
#
# Copyright (C) 2015 by Robin van der Gracht <robin@protonic.nl>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_PLY) += python3-ply

#
# Paths and names
#
PYTHON3_PLY_VERSION	:= 3.11
PYTHON3_PLY_MD5		:= 6465f602e656455affcd7c5734c638f8
PYTHON3_PLY		:= ply-$(PYTHON3_PLY_VERSION)
PYTHON3_PLY_SUFFIX	:= tar.gz
PYTHON3_PLY_URL		:= $(call ptx/mirror-pypi, ply, $(PYTHON3_PLY).$(PYTHON3_PLY_SUFFIX))
PYTHON3_PLY_SOURCE	:= $(SRCDIR)/$(PYTHON3_PLY).$(PYTHON3_PLY_SUFFIX)
PYTHON3_PLY_DIR		:= $(BUILDDIR)/$(PYTHON3_PLY)
PYTHON3_PLY_LICENSE	:= BSD-3-Clause
PYTHON3_PLY_LICENSE_FILES := file://ply/lex.py;startline=4;endline=31;md5=cf04500ef735e52b5bb9d6793a18085d

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_PLY_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-ply.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-ply)
	@$(call install_fixup, python3-ply, PRIORITY, optional)
	@$(call install_fixup, python3-ply, SECTION, base)
	@$(call install_fixup, python3-ply, AUTHOR, "Robin van der Gracht <robin@protonic.nl>")
	@$(call install_fixup, python3-ply, DESCRIPTION, missing)

	@$(call install_glob, python3-ply, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES)/ply,, *.py)

	@$(call install_finish, python3-ply)

	@$(call touch)

# vim: syntax=make
