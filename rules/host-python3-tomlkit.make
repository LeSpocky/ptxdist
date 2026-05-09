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
HOST_PACKAGES-$(PTXCONF_HOST_PYTHON3_TOMLKIT) += host-python3-tomlkit

#
# Paths and names
#
HOST_PYTHON3_TOMLKIT_VERSION		:= 0.12.5
HOST_PYTHON3_TOMLKIT_SHA256		:= eef34fba39834d4d6b73c9ba7f3e4d1c417a4e56f89a7e96e090dd0d24b8fb3c
HOST_PYTHON3_TOMLKIT			:= tomlkit-$(HOST_PYTHON3_TOMLKIT_VERSION)
HOST_PYTHON3_TOMLKIT_SUFFIX		:= tar.gz
HOST_PYTHON3_TOMLKIT_URL		:= $(call ptx/mirror-pypi, tomlkit, $(HOST_PYTHON3_TOMLKIT).$(HOST_PYTHON3_TOMLKIT_SUFFIX))
HOST_PYTHON3_TOMLKIT_SOURCE		:= $(SRCDIR)/$(HOST_PYTHON3_TOMLKIT).$(HOST_PYTHON3_TOMLKIT_SUFFIX)
HOST_PYTHON3_TOMLKIT_DIR		:= $(HOST_BUILDDIR)/$(HOST_PYTHON3_TOMLKIT)
HOST_PYTHON3_TOMLKIT_LICENSE		:= MIT
HOST_PYTHON3_TOMLKIT_LICENSE_FILES	:= \
	file://PKG-INFO;startline=6;endline=8;md5=93de1ab1482b195e9522a07e75c2759e \
	file://LICENSE;md5=31aac0dbc1babd278d5386dadb7f8e82

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_PYTHON3_TOMLKIT_CONF_TOOL	:= python3

# vim: syntax=make
