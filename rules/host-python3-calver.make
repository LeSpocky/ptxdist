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
HOST_PACKAGES-$(PTXCONF_HOST_PYTHON3_CALVER) += host-python3-calver

#
# Paths and names
#
HOST_PYTHON3_CALVER_VERSION		:= 2022.6.26
HOST_PYTHON3_CALVER_MD5			:= e1fd924b9bf953c0b28c49bdfe117d7a
HOST_PYTHON3_CALVER			:= calver-$(HOST_PYTHON3_CALVER_VERSION)
HOST_PYTHON3_CALVER_SUFFIX		:= tar.gz
HOST_PYTHON3_CALVER_URL			:= $(call ptx/mirror-pypi, calver, $(HOST_PYTHON3_CALVER).$(HOST_PYTHON3_CALVER_SUFFIX))
HOST_PYTHON3_CALVER_SOURCE		:= $(SRCDIR)/$(HOST_PYTHON3_CALVER).$(HOST_PYTHON3_CALVER_SUFFIX)
HOST_PYTHON3_CALVER_DIR			:= $(HOST_BUILDDIR)/$(HOST_PYTHON3_CALVER)
HOST_PYTHON3_CALVER_LICENSE		:= Apache-2.0
HOST_PYTHON3_CALVER_LICENSE_FILES	:= file://LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_PYTHON3_CALVER_CONF_TOOL	:= python3

# vim: syntax=make
