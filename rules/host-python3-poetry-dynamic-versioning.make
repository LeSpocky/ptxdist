# -*-makefile-*-
#
# Copyright (C) 2024 by Roland Hieber <rhi@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_PYTHON3_POETRY_DYNAMIC_VERSIONING) += host-python3-poetry-dynamic-versioning

#
# Paths and names
#
HOST_PYTHON3_POETRY_DYNAMIC_VERSIONING_VERSION		:= 1.3.0
HOST_PYTHON3_POETRY_DYNAMIC_VERSIONING_MD5		:= ae778dd8d8d03b05c30772608edc2e0a
HOST_PYTHON3_POETRY_DYNAMIC_VERSIONING			:= poetry_dynamic_versioning-$(HOST_PYTHON3_POETRY_DYNAMIC_VERSIONING_VERSION)
HOST_PYTHON3_POETRY_DYNAMIC_VERSIONING_SUFFIX		:= tar.gz
HOST_PYTHON3_POETRY_DYNAMIC_VERSIONING_URL		:= $(call ptx/mirror-pypi, poetry_dynamic_versioning, $(HOST_PYTHON3_POETRY_DYNAMIC_VERSIONING).$(HOST_PYTHON3_POETRY_DYNAMIC_VERSIONING_SUFFIX))
HOST_PYTHON3_POETRY_DYNAMIC_VERSIONING_SOURCE		:= $(SRCDIR)/$(HOST_PYTHON3_POETRY_DYNAMIC_VERSIONING).$(HOST_PYTHON3_POETRY_DYNAMIC_VERSIONING_SUFFIX)
HOST_PYTHON3_POETRY_DYNAMIC_VERSIONING_DIR		:= $(HOST_BUILDDIR)/$(HOST_PYTHON3_POETRY_DYNAMIC_VERSIONING)
HOST_PYTHON3_POETRY_DYNAMIC_VERSIONING_LICENSE		:= MIT
HOST_PYTHON3_POETRY_DYNAMIC_VERSIONING_LICENSE_FILES	:= \
	file://pyproject.toml;startline=4;endline=6;md5=7b88e40f0545478aac40c60d6587b134 \
	file://LICENSE;md5=059eed55dbfd3fea022510ea62c95dc1

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_PYTHON3_POETRY_DYNAMIC_VERSIONING_CONF_TOOL	:= python3

# vim: syntax=make
