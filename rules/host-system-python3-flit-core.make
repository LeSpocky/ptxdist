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
HOST_PACKAGES-$(PTXCONF_HOST_SYSTEM_PYTHON3_FLIT_CORE) += host-system-python3-flit-core

#
# Paths and names
#
HOST_SYSTEM_PYTHON3_FLIT_CORE_VERSION		= $(HOST_PYTHON3_FLIT_CORE_VERSION)
HOST_SYSTEM_PYTHON3_FLIT_CORE_MD5		= $(HOST_PYTHON3_FLIT_CORE_MD5)
HOST_SYSTEM_PYTHON3_FLIT_CORE			= system-$(HOST_PYTHON3_FLIT_CORE)
HOST_SYSTEM_PYTHON3_FLIT_CORE_SUFFIX		= $(HOST_PYTHON3_FLIT_CORE_SUFFIX)
HOST_SYSTEM_PYTHON3_FLIT_CORE_URL		= $(HOST_PYTHON3_FLIT_CORE_URL)
HOST_SYSTEM_PYTHON3_FLIT_CORE_SOURCE		= $(HOST_PYTHON3_FLIT_CORE_SOURCE)
HOST_SYSTEM_PYTHON3_FLIT_CORE_DIR		= $(HOST_BUILDDIR)/$(HOST_SYSTEM_PYTHON3_FLIT_CORE)
HOST_SYSTEM_PYTHON3_FLIT_CORE_LICENSE		= $(HOST_PYTHON3_FLIT_CORE_LICENSE)
HOST_SYSTEM_PYTHON3_FLIT_CORE_LICENSE_FILES	= $(HOST_PYTHON3_FLIT_CORE_LICENSE_FILES)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_SYSTEM_PYTHON3_FLIT_CORE_CONF_TOOL	:= python3

# vim: syntax=make
