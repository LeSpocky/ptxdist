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
HOST_PACKAGES-$(PTXCONF_HOST_SYSTEM_PYTHON3_PACKAGEURL_PYTHON) += host-system-python3-packageurl-python

#
# Paths and names
#
HOST_SYSTEM_PYTHON3_PACKAGEURL_PYTHON_VERSION		:= 0.16.0
HOST_SYSTEM_PYTHON3_PACKAGEURL_PYTHON_SHA256		:= 69e3bf8a3932fe9c2400f56aaeb9f86911ecee2f9398dbe1b58ec34340be365d
HOST_SYSTEM_PYTHON3_PACKAGEURL_PYTHON			:= packageurl_python-$(HOST_SYSTEM_PYTHON3_PACKAGEURL_PYTHON_VERSION)
HOST_SYSTEM_PYTHON3_PACKAGEURL_PYTHON_SUFFIX		:= tar.gz
HOST_SYSTEM_PYTHON3_PACKAGEURL_PYTHON_URL		:= $(call ptx/mirror-pypi, packageurl-python, $(HOST_SYSTEM_PYTHON3_PACKAGEURL_PYTHON).$(HOST_SYSTEM_PYTHON3_PACKAGEURL_PYTHON_SUFFIX))
HOST_SYSTEM_PYTHON3_PACKAGEURL_PYTHON_SOURCE		:= $(SRCDIR)/$(HOST_SYSTEM_PYTHON3_PACKAGEURL_PYTHON).$(HOST_SYSTEM_PYTHON3_PACKAGEURL_PYTHON_SUFFIX)
HOST_SYSTEM_PYTHON3_PACKAGEURL_PYTHON_DIR		:= $(HOST_BUILDDIR)/system-$(HOST_SYSTEM_PYTHON3_PACKAGEURL_PYTHON)
HOST_SYSTEM_PYTHON3_PACKAGEURL_PYTHON_LICENSE		:= MIT
HOST_SYSTEM_PYTHON3_PACKAGEURL_PYTHON_LICENSE_FILES	:= file://mit.LICENSE;md5=ec425c78d8beabdb209b01c5fbcd38e0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_SYSTEM_PYTHON3_PACKAGEURL_PYTHON_CONF_TOOL	:= python3

# vim: syntax=make
