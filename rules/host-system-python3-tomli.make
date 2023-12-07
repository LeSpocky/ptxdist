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
HOST_PACKAGES-$(PTXCONF_HOST_SYSTEM_PYTHON3_TOMLI) += host-system-python3-tomli

#
# Paths and names
#
HOST_SYSTEM_PYTHON3_TOMLI_VERSION		= $(HOST_PYTHON3_TOMLI_VERSION)
HOST_SYSTEM_PYTHON3_TOMLI_MD5			= $(HOST_PYTHON3_TOMLI_MD5)
HOST_SYSTEM_PYTHON3_TOMLI			= system-$(HOST_PYTHON3_TOMLI)
HOST_SYSTEM_PYTHON3_TOMLI_SUFFIX		= $(HOST_PYTHON3_TOMLI_SUFFIX)
HOST_SYSTEM_PYTHON3_TOMLI_URL			= $(HOST_PYTHON3_TOMLI_URL)
HOST_SYSTEM_PYTHON3_TOMLI_SOURCE		= $(HOST_PYTHON3_TOMLI_SOURCE)
HOST_SYSTEM_PYTHON3_TOMLI_DIR			= $(HOST_BUILDDIR)/$(HOST_SYSTEM_PYTHON3_TOMLI)
HOST_SYSTEM_PYTHON3_TOMLI_LICENSE		= $(HOST_PYTHON3_TOMLI_LICENSE)
HOST_SYSTEM_PYTHON3_TOMLI_LICENSE_FILES	= $(HOST_PYTHON3_TOMLI_LICENSE_FILES)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_SYSTEM_PYTHON3_TOMLI_CONF_TOOL	:= python3

# vim: syntax=make
