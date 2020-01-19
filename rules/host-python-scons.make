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
HOST_PACKAGES-$(PTXCONF_HOST_PYTHON_SCONS) += host-python-scons

#
# Paths and names
#
HOST_PYTHON_SCONS_VERSION	:= 3.1.2
HOST_PYTHON_SCONS_MD5		:= 77b2f8ac2661b7a4fad51c17cb7f1b25
HOST_PYTHON_SCONS		:= python-scons-$(HOST_PYTHON_SCONS_VERSION)
HOST_PYTHON_SCONS_SUFFIX	:= tar.gz
HOST_PYTHON_SCONS_URL		:= $(call ptx/mirror, SF, scons/scons-$(HOST_PYTHON_SCONS_VERSION).$(HOST_PYTHON_SCONS_SUFFIX))
HOST_PYTHON_SCONS_SOURCE	:= $(SRCDIR)/$(HOST_PYTHON_SCONS).$(HOST_PYTHON_SCONS_SUFFIX)
HOST_PYTHON_SCONS_DIR		:= $(HOST_BUILDDIR)/$(HOST_PYTHON_SCONS)
HOST_PYTHON_SCONS_LICENSE	:= MIT
HOST_PYTHON_SCONS_LICENSE_FILES	:= file://LICENSE.txt;md5=e14e1b33428df24a40a782ae142785d0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_PYTHON_SCONS_CONF_TOOL	:= python

# vim: syntax=make
