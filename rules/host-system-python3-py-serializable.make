# -*-makefile-*-
#
# Copyright (C) 2025 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_SYSTEM_PYTHON3_PY_SERIALIZABLE) += host-system-python3-py-serializable

#
# Paths and names
#
HOST_SYSTEM_PYTHON3_PY_SERIALIZABLE_VERSION		:= 1.1.2
HOST_SYSTEM_PYTHON3_PY_SERIALIZABLE_SHA256		:= 89af30bc319047d4aa0d8708af412f6ce73835e18bacf1a080028bb9e2f42bdb
HOST_SYSTEM_PYTHON3_PY_SERIALIZABLE			:= py_serializable-$(HOST_SYSTEM_PYTHON3_PY_SERIALIZABLE_VERSION)
HOST_SYSTEM_PYTHON3_PY_SERIALIZABLE_SUFFIX		:= tar.gz
HOST_SYSTEM_PYTHON3_PY_SERIALIZABLE_URL			:= $(call ptx/mirror-pypi, py-serializable, $(HOST_SYSTEM_PYTHON3_PY_SERIALIZABLE).$(HOST_SYSTEM_PYTHON3_PY_SERIALIZABLE_SUFFIX))
HOST_SYSTEM_PYTHON3_PY_SERIALIZABLE_SOURCE		:= $(SRCDIR)/$(HOST_SYSTEM_PYTHON3_PY_SERIALIZABLE).$(HOST_SYSTEM_PYTHON3_PY_SERIALIZABLE_SUFFIX)
HOST_SYSTEM_PYTHON3_PY_SERIALIZABLE_DIR			:= $(HOST_BUILDDIR)/system-$(HOST_SYSTEM_PYTHON3_PY_SERIALIZABLE)
HOST_SYSTEM_PYTHON3_PY_SERIALIZABLE_LICENSE		:= Apache-2.0
HOST_SYSTEM_PYTHON3_PY_SERIALIZABLE_LICENSE_FILES	:= file://LICENSE;md5=86d3f3a95c324c9479bd8986968f4327

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_SYSTEM_PYTHON3_PY_SERIALIZABLE_CONF_TOOL	:= python3

# vim: syntax=make
