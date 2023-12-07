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
HOST_PACKAGES-$(PTXCONF_HOST_SYSTEM_PYTHON3_PACKAGING) += host-system-python3-packaging

#
# Paths and names
#
HOST_SYSTEM_PYTHON3_PACKAGING_VERSION		= $(HOST_PYTHON3_PACKAGING_VERSION)
HOST_SYSTEM_PYTHON3_PACKAGING_MD5		= $(HOST_PYTHON3_PACKAGING_MD5)
HOST_SYSTEM_PYTHON3_PACKAGING			= system-$(HOST_PYTHON3_PACKAGING)
HOST_SYSTEM_PYTHON3_PACKAGING_SUFFIX		= $(HOST_PYTHON3_PACKAGING_SUFFIX)
HOST_SYSTEM_PYTHON3_PACKAGING_URL		= $(HOST_PYTHON3_PACKAGING_URL)
HOST_SYSTEM_PYTHON3_PACKAGING_SOURCE		= $(HOST_PYTHON3_PACKAGING_SOURCE)
HOST_SYSTEM_PYTHON3_PACKAGING_DIR		= $(HOST_BUILDDIR)/$(HOST_SYSTEM_PYTHON3_PACKAGING)
HOST_SYSTEM_PYTHON3_PACKAGING_LICENSE		= $(HOST_PYTHON3_PACKAGING_LICENSE)
HOST_SYSTEM_PYTHON3_PACKAGING_LICENSE_FILES	= $(HOST_PYTHON3_PACKAGING_LICENSE_FILES)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_SYSTEM_PYTHON3_PACKAGING_CONF_TOOL	:= python3

# vim: syntax=make
