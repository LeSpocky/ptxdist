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
HOST_PACKAGES-$(PTXCONF_HOST_PYTHON_SETUPTOOLS) += host-python-setuptools

#
# Paths and names
#
HOST_PYTHON_SETUPTOOLS_VERSION	:= 41.2.0
HOST_PYTHON_SETUPTOOLS_MD5	:= a3470ce184da33f0fa6c9f44f6221bc0
HOST_PYTHON_SETUPTOOLS		:= python-setuptools-$(HOST_PYTHON_SETUPTOOLS_VERSION)
HOST_PYTHON_SETUPTOOLS_SUFFIX	:= zip
HOST_PYTHON_SETUPTOOLS_URL	:= https://pypi.python.org/packages/source/s/setuptools/setuptools-$(HOST_PYTHON_SETUPTOOLS_VERSION).$(HOST_PYTHON_SETUPTOOLS_SUFFIX)
HOST_PYTHON_SETUPTOOLS_SOURCE	:= $(SRCDIR)/$(HOST_PYTHON_SETUPTOOLS).$(HOST_PYTHON_SETUPTOOLS_SUFFIX)
HOST_PYTHON_SETUPTOOLS_DIR	:= $(HOST_BUILDDIR)/$(HOST_PYTHON_SETUPTOOLS)
HOST_PYTHON_SETUPTOOLS_LICENSE	:= PSF AND ZPL

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_PYTHON_SETUPTOOLS_CONF_TOOL	:= python

# vim: syntax=make
