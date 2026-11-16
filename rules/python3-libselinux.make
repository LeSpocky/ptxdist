# -*-makefile-*-
#
# Copyright (C) 2026 by Ladislav Michl <ladis@triops.cz>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_LIBSELINUX) += python3-libselinux

#
# Paths and names
#
PYTHON3_LIBSELINUX_VERSION	= $(LIBSELINUX_VERSION)
PYTHON3_LIBSELINUX_SHA256	= $(LIBSELINUX_SHA256)
PYTHON3_LIBSELINUX		= python3-libselinux-$(PYTHON3_LIBSELINUX_VERSION)
PYTHON3_LIBSELINUX_SUFFIX	= $(LIBSELINUX_SUFFIX)
PYTHON3_LIBSELINUX_URL		= $(LIBSELINUX_URL)
PYTHON3_LIBSELINUX_SOURCE	= $(LIBSELINUX_SOURCE)
PYTHON3_LIBSELINUX_DIR		= $(BUILDDIR)/$(PYTHON3_LIBSELINUX)
PYTHON3_LIBSELINUX_PATCHES	= $(LIBSELINUX)
PYTHON3_LIBSELINUX_LICENSE	= $(LIBSELINUX_LICENSE)
PYTHON3_LIBSELINUX_LICENSE_FILES	= $(LIBSELINUX_LICENSE_FILES)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_LIBSELINUX_CONF_TOOL	:= python3
PYTHON3_LIBSELINUX_SUBDIR	:= src

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-libselinux.install:
	@$(call targetinfo)
#	# swig generated module is not part of setup.py
	@install -m 644 $(PYTHON3_LIBSELINUX_DIR)/src/selinux.py \
		"$$(echo $(PYTHON3_LIBSELINUX_DIR)/src/build/lib.*/selinux)/__init__.py"
	@$(call world/install, PYTHON3_LIBSELINUX)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-libselinux.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-libselinux)
	@$(call install_fixup, python3-libselinux,PRIORITY,optional)
	@$(call install_fixup, python3-libselinux,SECTION,base)
	@$(call install_fixup, python3-libselinux,AUTHOR,"Ladislav Michl <ladis@triops.cz>")
	@$(call install_fixup, python3-libselinux,DESCRIPTION,missing)

	@$(call install_glob, python3-libselinux, 0, 0, -, $(PYTHON3_SITEPACKAGES),, *.py)

	@$(call install_finish, python3-libselinux)

	@$(call touch)

# vim: syntax=make
