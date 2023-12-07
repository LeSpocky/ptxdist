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
HOST_PACKAGES-$(PTXCONF_HOST_SYSTEM_PYTHON3_PYBUILD) += host-system-python3-pybuild

#
# Paths and names
#
HOST_SYSTEM_PYTHON3_PYBUILD_VERSION		= $(HOST_PYTHON3_PYBUILD_VERSION)
HOST_SYSTEM_PYTHON3_PYBUILD_MD5		= $(HOST_PYTHON3_PYBUILD_MD5)
HOST_SYSTEM_PYTHON3_PYBUILD			= system-$(HOST_PYTHON3_PYBUILD)
HOST_SYSTEM_PYTHON3_PYBUILD_SUFFIX		= $(HOST_PYTHON3_PYBUILD_SUFFIX)
HOST_SYSTEM_PYTHON3_PYBUILD_URL		= $(HOST_PYTHON3_PYBUILD_URL)
HOST_SYSTEM_PYTHON3_PYBUILD_SOURCE		= $(HOST_PYTHON3_PYBUILD_SOURCE)
HOST_SYSTEM_PYTHON3_PYBUILD_DIR		= $(HOST_BUILDDIR)/$(HOST_SYSTEM_PYTHON3_PYBUILD)
HOST_SYSTEM_PYTHON3_PYBUILD_LICENSE		= $(HOST_PYTHON3_PYBUILD_LICENSE)
HOST_SYSTEM_PYTHON3_PYBUILD_LICENSE_FILES	= $(HOST_PYTHON3_PYBUILD_LICENSE_FILES)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_SYSTEM_PYTHON3_PYBUILD_CONF_TOOL	:= python3

# vim: syntax=make
