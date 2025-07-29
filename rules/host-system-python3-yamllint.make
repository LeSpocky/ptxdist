# -*-makefile-*-
#
# Copyright (C) 2025 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_SYSTEM_PYTHON3_YAMLLINT) += host-system-python3-yamllint

#
# Paths and names
#
HOST_SYSTEM_PYTHON3_YAMLLINT_VERSION		:= 1.37.1
HOST_SYSTEM_PYTHON3_YAMLLINT_MD5		:= cebe1728fdf28a44bae7896edbf48635
HOST_SYSTEM_PYTHON3_YAMLLINT			:= yamllint-$(HOST_SYSTEM_PYTHON3_YAMLLINT_VERSION)
HOST_SYSTEM_PYTHON3_YAMLLINT_SUFFIX		:= tar.gz
HOST_SYSTEM_PYTHON3_YAMLLINT_URL		:= $(call ptx/mirror-pypi, yamllint, $(HOST_SYSTEM_PYTHON3_YAMLLINT).$(HOST_SYSTEM_PYTHON3_YAMLLINT_SUFFIX))
HOST_SYSTEM_PYTHON3_YAMLLINT_SOURCE		:= $(SRCDIR)/$(HOST_SYSTEM_PYTHON3_YAMLLINT).$(HOST_SYSTEM_PYTHON3_YAMLLINT_SUFFIX)
HOST_SYSTEM_PYTHON3_YAMLLINT_DIR		:= $(HOST_BUILDDIR)/$(HOST_SYSTEM_PYTHON3_YAMLLINT)
HOST_SYSTEM_PYTHON3_YAMLLINT_LICENSE		:= GPL-3.0-or-later
HOST_SYSTEM_PYTHON3_YAMLLINT_LICENSE_FILES	:= \
	file://LICENSE;md5=1ebbd3e34237af26da5dc08a4e440464


# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_SYSTEM_PYTHON3_YAMLLINT_CONF_TOOL	:= python3

# vim: syntax=make
