# -*-makefile-*-
#
# Copyright (C) 2019 by Denis Osterland <Denis.Osterland@diehl.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_PYTHON3_SCONS) += host-python3-scons

#
# Paths and names
#
HOST_PYTHON3_SCONS_VERSION		:= 4.6.0
HOST_PYTHON3_SCONS_MD5			:= 30dcc2563af408c04812a8de88ce2c2e
HOST_PYTHON3_SCONS			:= SCons-$(HOST_PYTHON3_SCONS_VERSION)
HOST_PYTHON3_SCONS_SUFFIX		:= tar.gz
HOST_PYTHON3_SCONS_URL			:= $(call ptx/mirror-pypi, SCons, $(HOST_PYTHON3_SCONS).$(HOST_PYTHON3_SCONS_SUFFIX))
HOST_PYTHON3_SCONS_SOURCE		:= $(SRCDIR)/$(HOST_PYTHON3_SCONS).$(HOST_PYTHON3_SCONS_SUFFIX)
HOST_PYTHON3_SCONS_DIR			:= $(HOST_BUILDDIR)/$(HOST_PYTHON3_SCONS)
HOST_PYTHON3_SCONS_LICENSE		:= MIT
HOST_PYTHON3_SCONS_LICENSE_FILES	:= file://LICENSE;md5=d903b0b8027f461402bac9b5169b36f7

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_PYTHON3_SCONS_CONF_TOOL	:= python3

# vim: syntax=make
