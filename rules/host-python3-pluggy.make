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
HOST_PACKAGES-$(PTXCONF_HOST_PYTHON3_PLUGGY) += host-python3-pluggy

#
# Paths and names
#
HOST_PYTHON3_PLUGGY_VERSION		:= 1.5.0
HOST_PYTHON3_PLUGGY_MD5		:= ac0870be78ba0ee227a5c3955efeba59
HOST_PYTHON3_PLUGGY			:= pluggy-$(HOST_PYTHON3_PLUGGY_VERSION)
HOST_PYTHON3_PLUGGY_SUFFIX		:= tar.gz
HOST_PYTHON3_PLUGGY_URL		:= $(call ptx/mirror-pypi, pluggy, $(HOST_PYTHON3_PLUGGY).$(HOST_PYTHON3_PLUGGY_SUFFIX))
HOST_PYTHON3_PLUGGY_SOURCE		:= $(SRCDIR)/$(HOST_PYTHON3_PLUGGY).$(HOST_PYTHON3_PLUGGY_SUFFIX)
HOST_PYTHON3_PLUGGY_DIR		:= $(HOST_BUILDDIR)/$(HOST_PYTHON3_PLUGGY)
HOST_PYTHON3_PLUGGY_LICENSE		:= MIT
HOST_PYTHON3_PLUGGY_LICENSE_FILES	:= file://LICENSE;md5=1c8206d16fd5cc02fa9b0bb98955e5c2

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_PYTHON3_PLUGGY_CONF_TOOL	:= python3

# vim: syntax=make
