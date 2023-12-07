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
HOST_PACKAGES-$(PTXCONF_HOST_SYSTEM_PYTHON3_INSTALLER) += host-system-python3-installer

#
# Paths and names
#
HOST_SYSTEM_PYTHON3_INSTALLER_VERSION		= $(HOST_PYTHON3_INSTALLER_VERSION)
HOST_SYSTEM_PYTHON3_INSTALLER_MD5		= $(HOST_PYTHON3_INSTALLER_MD5)
HOST_SYSTEM_PYTHON3_INSTALLER			= system-$(HOST_PYTHON3_INSTALLER)
HOST_SYSTEM_PYTHON3_INSTALLER_SUFFIX		= $(HOST_PYTHON3_INSTALLER_SUFFIX)
HOST_SYSTEM_PYTHON3_INSTALLER_URL		= $(HOST_PYTHON3_INSTALLER_URL)
HOST_SYSTEM_PYTHON3_INSTALLER_SOURCE		= $(HOST_PYTHON3_INSTALLER_SOURCE)
HOST_SYSTEM_PYTHON3_INSTALLER_DIR		= $(HOST_BUILDDIR)/$(HOST_SYSTEM_PYTHON3_INSTALLER)
HOST_SYSTEM_PYTHON3_INSTALLER_LICENSE		= $(HOST_PYTHON3_INSTALLER_LICENSE)
HOST_SYSTEM_PYTHON3_INSTALLER_LICENSE_FILES	= $(HOST_PYTHON3_INSTALLER_LICENSE_FILES)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_SYSTEM_PYTHON3_INSTALLER_CONF_TOOL	:= python3

# vim: syntax=make
