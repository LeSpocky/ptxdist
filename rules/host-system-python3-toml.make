# -*-makefile-*-
#
# Copyright (C) 2024 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_SYSTEM_PYTHON3_TOML) += host-system-python3-toml

#
# Paths and names
#
HOST_SYSTEM_PYTHON3_TOML_VERSION	= $(HOST_PYTHON3_TOML_VERSION)
HOST_SYSTEM_PYTHON3_TOML_MD5		= $(HOST_PYTHON3_TOML_MD5)
HOST_SYSTEM_PYTHON3_TOML		= system-$(HOST_PYTHON3_TOML)
HOST_SYSTEM_PYTHON3_TOML_SUFFIX		= $(HOST_PYTHON3_TOML_SUFFIX)
HOST_SYSTEM_PYTHON3_TOML_URL		= $(HOST_PYTHON3_TOML_URL)
HOST_SYSTEM_PYTHON3_TOML_SOURCE		= $(HOST_PYTHON3_TOML_SOURCE)
HOST_SYSTEM_PYTHON3_TOML_DIR		= $(HOST_BUILDDIR)/$(HOST_SYSTEM_PYTHON3_TOML)
HOST_SYSTEM_PYTHON3_TOML_LICENSE	= $(HOST_PYTHON3_TOML_LICENSE)
HOST_SYSTEM_PYTHON3_TOML_LICENSE_FILES	= $(HOST_PYTHON3_TOML_LICENSE_FILES)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_SYSTEM_PYTHON3_TOML_CONF_TOOL	:= python3

# vim: syntax=make
