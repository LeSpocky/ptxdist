# -*-makefile-*-
#
# Copyright (C) 2023 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_PYTHON3_PYPROJECT_HOOKS) += host-python3-pyproject-hooks

#
# Paths and names
#
HOST_PYTHON3_PYPROJECT_HOOKS_VERSION		:= 1.0.0
HOST_PYTHON3_PYPROJECT_HOOKS_MD5		:= 69b0b6de189bc04c3f9e304281765741
HOST_PYTHON3_PYPROJECT_HOOKS			:= pyproject_hooks-$(HOST_PYTHON3_PYPROJECT_HOOKS_VERSION)
HOST_PYTHON3_PYPROJECT_HOOKS_SUFFIX		:= tar.gz
HOST_PYTHON3_PYPROJECT_HOOKS_URL		:= $(call ptx/mirror-pypi, pyproject_hooks, $(HOST_PYTHON3_PYPROJECT_HOOKS).$(HOST_PYTHON3_PYPROJECT_HOOKS_SUFFIX))
HOST_PYTHON3_PYPROJECT_HOOKS_SOURCE		:= $(SRCDIR)/$(HOST_PYTHON3_PYPROJECT_HOOKS).$(HOST_PYTHON3_PYPROJECT_HOOKS_SUFFIX)
HOST_PYTHON3_PYPROJECT_HOOKS_DIR		:= $(HOST_BUILDDIR)/$(HOST_PYTHON3_PYPROJECT_HOOKS)
HOST_PYTHON3_PYPROJECT_HOOKS_LICENSE		:= MIT
HOST_PYTHON3_PYPROJECT_HOOKS_LICENSE_FILES	:= \
	file://LICENSE;md5=aad69c93f605003e3342b174d9b0708c

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_PYTHON3_PYPROJECT_HOOKS_CONF_TOOL	:= python3

# vim: syntax=make
