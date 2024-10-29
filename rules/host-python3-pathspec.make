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
HOST_PACKAGES-$(PTXCONF_HOST_PYTHON3_PATHSPEC) += host-python3-pathspec

#
# Paths and names
#
HOST_PYTHON3_PATHSPEC_VERSION		:= 0.12.1
HOST_PYTHON3_PATHSPEC_MD5		:= 2b26ad1981bfa23748e115f00085624c
HOST_PYTHON3_PATHSPEC			:= pathspec-$(HOST_PYTHON3_PATHSPEC_VERSION)
HOST_PYTHON3_PATHSPEC_SUFFIX		:= tar.gz
HOST_PYTHON3_PATHSPEC_URL		:= $(call ptx/mirror-pypi, pathspec, $(HOST_PYTHON3_PATHSPEC).$(HOST_PYTHON3_PATHSPEC_SUFFIX))
HOST_PYTHON3_PATHSPEC_SOURCE		:= $(SRCDIR)/$(HOST_PYTHON3_PATHSPEC).$(HOST_PYTHON3_PATHSPEC_SUFFIX)
HOST_PYTHON3_PATHSPEC_DIR		:= $(HOST_BUILDDIR)/$(HOST_PYTHON3_PATHSPEC)
HOST_PYTHON3_PATHSPEC_LICENSE		:= MPL-2.0
HOST_PYTHON3_PATHSPEC_LICENSE_FILES	:= file://LICENSE;md5=815ca599c9df247a0c7f619bab123dad

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_PYTHON3_PATHSPEC_CONF_TOOL	:= python3

# vim: syntax=make
