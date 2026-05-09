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
HOST_PACKAGES-$(PTXCONF_HOST_SYSTEM_PYTHON3_PYMONGO) += host-system-python3-pymongo

#
# Paths and names
#
HOST_SYSTEM_PYTHON3_PYMONGO_VERSION		:= 4.6.2
HOST_SYSTEM_PYTHON3_PYMONGO_SHA256		:= ab7d01ac832a1663dad592ccbd92bb0f0775bc8f98a1923c5e1a7d7fead495af
HOST_SYSTEM_PYTHON3_PYMONGO			:= pymongo-$(HOST_SYSTEM_PYTHON3_PYMONGO_VERSION)
HOST_SYSTEM_PYTHON3_PYMONGO_SUFFIX		:= tar.gz
HOST_SYSTEM_PYTHON3_PYMONGO_URL			:= $(call ptx/mirror-pypi, pymongo, $(HOST_SYSTEM_PYTHON3_PYMONGO).$(HOST_SYSTEM_PYTHON3_PYMONGO_SUFFIX))
HOST_SYSTEM_PYTHON3_PYMONGO_SOURCE		:= $(SRCDIR)/$(HOST_SYSTEM_PYTHON3_PYMONGO).$(HOST_SYSTEM_PYTHON3_PYMONGO_SUFFIX)
HOST_SYSTEM_PYTHON3_PYMONGO_DIR			:= $(HOST_BUILDDIR)/$(HOST_SYSTEM_PYTHON3_PYMONGO)
HOST_SYSTEM_PYTHON3_PYMONGO_LICENSE		:= Apache-2.0
HOST_SYSTEM_PYTHON3_PYMONGO_LICENSE_FILES	:= \
	file://LICENSE;md5=86d3f3a95c324c9479bd8986968f4327

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_SYSTEM_PYTHON3_PYMONGO_CONF_TOOL	:= python3

# vim: syntax=make
