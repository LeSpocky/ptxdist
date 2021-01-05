# -*-makefile-*-
#
# Copyright (C) 2016 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_PYTHON3_SETUPTOOLS_SCM) += host-python3-setuptools-scm

#
# Paths and names
#
HOST_PYTHON3_SETUPTOOLS_SCM_VERSION	:= 4.1.2
HOST_PYTHON3_SETUPTOOLS_SCM_MD5		:= e6c9fad17c90516d640868eb833d5150
HOST_PYTHON3_SETUPTOOLS_SCM		:= setuptools_scm-$(HOST_PYTHON3_SETUPTOOLS_SCM_VERSION)
HOST_PYTHON3_SETUPTOOLS_SCM_SUFFIX	:= tar.gz
HOST_PYTHON3_SETUPTOOLS_SCM_URL		:= $(call ptx/mirror-pypi, setuptools_scm, $(HOST_PYTHON3_SETUPTOOLS_SCM).$(HOST_PYTHON3_SETUPTOOLS_SCM_SUFFIX))
HOST_PYTHON3_SETUPTOOLS_SCM_SOURCE	:= $(SRCDIR)/$(HOST_PYTHON3_SETUPTOOLS_SCM).$(HOST_PYTHON3_SETUPTOOLS_SCM_SUFFIX)
HOST_PYTHON3_SETUPTOOLS_SCM_DIR		:= $(HOST_BUILDDIR)/$(HOST_PYTHON3_SETUPTOOLS_SCM)
HOST_PYTHON3_SETUPTOOLS_SCM_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_PYTHON3_SETUPTOOLS_SCM_CONF_TOOL	:= python3

# vim: syntax=make
