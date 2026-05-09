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
HOST_PACKAGES-$(PTXCONF_HOST_SYSTEM_PYTHON3_BOOLEAN_PY) += host-system-python3-boolean-py

#
# Paths and names
#
HOST_SYSTEM_PYTHON3_BOOLEAN_PY_VERSION		:= 4.0
HOST_SYSTEM_PYTHON3_BOOLEAN_PY_SHA256		:= 17b9a181630e43dde1851d42bef546d616d5d9b4480357514597e78b203d06e4
HOST_SYSTEM_PYTHON3_BOOLEAN_PY			:= boolean.py-$(HOST_SYSTEM_PYTHON3_BOOLEAN_PY_VERSION)
HOST_SYSTEM_PYTHON3_BOOLEAN_PY_SUFFIX		:= tar.gz
HOST_SYSTEM_PYTHON3_BOOLEAN_PY_URL		:= $(call ptx/mirror-pypi, boolean-py, $(HOST_SYSTEM_PYTHON3_BOOLEAN_PY).$(HOST_SYSTEM_PYTHON3_BOOLEAN_PY_SUFFIX))
HOST_SYSTEM_PYTHON3_BOOLEAN_PY_SOURCE		:= $(SRCDIR)/$(HOST_SYSTEM_PYTHON3_BOOLEAN_PY).$(HOST_SYSTEM_PYTHON3_BOOLEAN_PY_SUFFIX)
HOST_SYSTEM_PYTHON3_BOOLEAN_PY_DIR		:= $(HOST_BUILDDIR)/system-$(HOST_SYSTEM_PYTHON3_BOOLEAN_PY)
HOST_SYSTEM_PYTHON3_BOOLEAN_PY_LICENSE		:= BSD-2-Clause
HOST_SYSTEM_PYTHON3_BOOLEAN_PY_LICENSE_FILES	:= file://LICENSE.txt;md5=d118b5feceee598ebeca76e13395c2bd

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_SYSTEM_PYTHON3_BOOLEAN_PY_CONF_TOOL	:= python3

# vim: syntax=make
