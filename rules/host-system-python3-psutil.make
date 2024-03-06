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
HOST_PACKAGES-$(PTXCONF_HOST_SYSTEM_PYTHON3_PSUTIL) += host-system-python3-psutil

#
# Paths and names
#
HOST_SYSTEM_PYTHON3_PSUTIL_VERSION		:= 5.9.8
HOST_SYSTEM_PYTHON3_PSUTIL_MD5			:= 7bb9d4378bd451765b705946a3541393
HOST_SYSTEM_PYTHON3_PSUTIL			:= psutil-$(HOST_SYSTEM_PYTHON3_PSUTIL_VERSION)
HOST_SYSTEM_PYTHON3_PSUTIL_SUFFIX		:= tar.gz
HOST_SYSTEM_PYTHON3_PSUTIL_URL			:= $(call ptx/mirror-pypi, psutil, $(HOST_SYSTEM_PYTHON3_PSUTIL).$(HOST_SYSTEM_PYTHON3_PSUTIL_SUFFIX))
HOST_SYSTEM_PYTHON3_PSUTIL_SOURCE		:= $(SRCDIR)/$(HOST_SYSTEM_PYTHON3_PSUTIL).$(HOST_SYSTEM_PYTHON3_PSUTIL_SUFFIX)
HOST_SYSTEM_PYTHON3_PSUTIL_DIR			:= $(HOST_BUILDDIR)/$(HOST_SYSTEM_PYTHON3_PSUTIL)
HOST_SYSTEM_PYTHON3_PSUTIL_LICENSE		:= BSD-3-Clause
HOST_SYSTEM_PYTHON3_PSUTIL_LICENSE_FILES	:= \
	file://LICENSE;md5=a9c72113a843d0d732a0ac1c200d81b1

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_SYSTEM_PYTHON3_PSUTIL_CONF_TOOL	:= python3

# vim: syntax=make
