# -*-makefile-*-
#
# Copyright (C) 2024 by Lars Pedersen <lapeddk@gmail.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_PYTHON3_HATCHLING) += host-python3-hatchling

#
# Paths and names
#
HOST_PYTHON3_HATCHLING_VERSION		:= 1.25.0
HOST_PYTHON3_HATCHLING_SHA256		:= 7064631a512610b52250a4d3ff1bd81551d6d1431c4eb7b72e734df6c74f4262
HOST_PYTHON3_HATCHLING			:= hatchling-$(HOST_PYTHON3_HATCHLING_VERSION)
HOST_PYTHON3_HATCHLING_SUFFIX		:= tar.gz
HOST_PYTHON3_HATCHLING_URL		:= $(call ptx/mirror-pypi, hatchling, $(HOST_PYTHON3_HATCHLING).$(HOST_PYTHON3_HATCHLING_SUFFIX))
HOST_PYTHON3_HATCHLING_SOURCE		:= $(SRCDIR)/$(HOST_PYTHON3_HATCHLING).$(HOST_PYTHON3_HATCHLING_SUFFIX)
HOST_PYTHON3_HATCHLING_DIR		:= $(HOST_BUILDDIR)/$(HOST_PYTHON3_HATCHLING)
HOST_PYTHON3_HATCHLING_LICENSE		:= MIT
HOST_PYTHON3_HATCHLING_LICENSE_FILES	:= file://LICENSE.txt;md5=cbe2fd33fc9297692812fc94b7d27fd9

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_PYTHON3_HATCHLING_CONF_TOOL	:= python3

# vim: syntax=make
