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
HOST_PACKAGES-$(PTXCONF_HOST_SYSTEM_PYTHON3_WHEEL) += host-system-python3-wheel

#
# Paths and names
#
HOST_SYSTEM_PYTHON3_WHEEL_VERSION		= $(HOST_PYTHON3_WHEEL_VERSION)
HOST_SYSTEM_PYTHON3_WHEEL_MD5			= $(HOST_PYTHON3_WHEEL_MD5)
HOST_SYSTEM_PYTHON3_WHEEL			= system-$(HOST_PYTHON3_WHEEL)
HOST_SYSTEM_PYTHON3_WHEEL_SUFFIX		= $(HOST_PYTHON3_WHEEL_SUFFIX)
HOST_SYSTEM_PYTHON3_WHEEL_URL			= $(HOST_PYTHON3_WHEEL_URL)
HOST_SYSTEM_PYTHON3_WHEEL_SOURCE		= $(HOST_PYTHON3_WHEEL_SOURCE)
HOST_SYSTEM_PYTHON3_WHEEL_DIR			= $(HOST_BUILDDIR)/$(HOST_SYSTEM_PYTHON3_WHEEL)
HOST_SYSTEM_PYTHON3_WHEEL_LICENSE		= $(HOST_PYTHON3_WHEEL_LICENSE)
HOST_SYSTEM_PYTHON3_WHEEL_LICENSE_FILES	= $(HOST_PYTHON3_WHEEL_LICENSE_FILES)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_SYSTEM_PYTHON3_WHEEL_CONF_TOOL	:= python3

# vim: syntax=make
