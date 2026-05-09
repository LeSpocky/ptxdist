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
HOST_PACKAGES-$(PTXCONF_HOST_SYSTEM_PYTHON3_WEBENCODINGS) += host-system-python3-webencodings

#
# Paths and names
#
HOST_SYSTEM_PYTHON3_WEBENCODINGS_VERSION	:= 0.5.1
HOST_SYSTEM_PYTHON3_WEBENCODINGS_SHA256		:= b36a1c245f2d304965eb4e0a82848379241dc04b865afcc4aab16748587e1923
HOST_SYSTEM_PYTHON3_WEBENCODINGS		:= webencodings-$(HOST_SYSTEM_PYTHON3_WEBENCODINGS_VERSION)
HOST_SYSTEM_PYTHON3_WEBENCODINGS_SUFFIX		:= tar.gz
HOST_SYSTEM_PYTHON3_WEBENCODINGS_URL		:= $(call ptx/mirror-pypi, webencodings, $(HOST_SYSTEM_PYTHON3_WEBENCODINGS).$(HOST_SYSTEM_PYTHON3_WEBENCODINGS_SUFFIX))
HOST_SYSTEM_PYTHON3_WEBENCODINGS_SOURCE		:= $(SRCDIR)/$(HOST_SYSTEM_PYTHON3_WEBENCODINGS).$(HOST_SYSTEM_PYTHON3_WEBENCODINGS_SUFFIX)
HOST_SYSTEM_PYTHON3_WEBENCODINGS_DIR		:= $(HOST_BUILDDIR)/$(HOST_SYSTEM_PYTHON3_WEBENCODINGS)
HOST_SYSTEM_PYTHON3_WEBENCODINGS_LICENSE	:= BSD-3-Clause

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_SYSTEM_PYTHON3_WEBENCODINGS_CONF_TOOL	:= python3

# vim: syntax=make
