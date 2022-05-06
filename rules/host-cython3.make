# -*-makefile-*-
#
# Copyright (C) 2018 by Bastian Stender <bst@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_CYTHON3) += host-cython3

#
# Paths and names
#
HOST_CYTHON3_VERSION	:= 0.29.28
HOST_CYTHON3_MD5	:= 0e98543dca816300a27e7d76146a6280
HOST_CYTHON3		:= Cython-$(HOST_CYTHON3_VERSION)
HOST_CYTHON3_SUFFIX	:= tar.gz
HOST_CYTHON3_URL	:= $(call ptx/mirror-pypi, cython, $(HOST_CYTHON3).$(HOST_CYTHON3_SUFFIX))
HOST_CYTHON3_SOURCE	:= $(SRCDIR)/$(HOST_CYTHON3).$(HOST_CYTHON3_SUFFIX)
HOST_CYTHON3_DIR	:= $(HOST_BUILDDIR)/$(HOST_CYTHON3)
HOST_CYTHON3_LICENSE	:= Apache-2.0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_CYTHON3_CONF_TOOL	:= python3

# vim: syntax=make
