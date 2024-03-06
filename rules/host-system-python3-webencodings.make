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
HOST_SYSTEM_PYTHON3_WEBENCODINGS_MD5		:= 32f6e261d52e57bf7e1c4d41546d15b8
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
