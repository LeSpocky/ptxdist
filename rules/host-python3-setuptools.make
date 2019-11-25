# -*-makefile-*-
#
# Copyright (C) 2014 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_PYTHON3_SETUPTOOLS) += host-python3-setuptools

#
# Paths and names
#
HOST_PYTHON3_SETUPTOOLS_VERSION	:= 41.6.0
HOST_PYTHON3_SETUPTOOLS_MD5	:= 5585a55bfc28474ef13cc0b1819c5a46
HOST_PYTHON3_SETUPTOOLS		:= setuptools-$(HOST_PYTHON3_SETUPTOOLS_VERSION)
HOST_PYTHON3_SETUPTOOLS_SUFFIX	:= zip
HOST_PYTHON3_SETUPTOOLS_URL	:= https://pypi.io/packages/source/s/setuptools/$(HOST_PYTHON3_SETUPTOOLS).$(HOST_PYTHON3_SETUPTOOLS_SUFFIX)
HOST_PYTHON3_SETUPTOOLS_SOURCE	:= $(SRCDIR)/$(HOST_PYTHON3_SETUPTOOLS).$(HOST_PYTHON3_SETUPTOOLS_SUFFIX)
HOST_PYTHON3_SETUPTOOLS_DIR	:= $(HOST_BUILDDIR)/$(HOST_PYTHON3_SETUPTOOLS)
HOST_PYTHON3_SETUPTOOLS_LICENSE	:= MIT
HOST_PYTHON3_SETUPTOOLS_LICENSE_FILES := \
	file://LICENSE;md5=9a33897f1bca1160d7aad3835152e158

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_PYTHON3_SETUPTOOLS_CONF_TOOL	:= python3

# vim: syntax=make
