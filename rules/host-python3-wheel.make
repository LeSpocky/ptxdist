# -*-makefile-*-
#
# Copyright (C) 2023 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_PYTHON3_WHEEL) += host-python3-wheel

#
# Paths and names
#
HOST_PYTHON3_WHEEL_VERSION		:= 0.40.0
HOST_PYTHON3_WHEEL_MD5			:= ec5004c46d1905da98bb5bc1a10ddd21
HOST_PYTHON3_WHEEL			:= wheel-$(HOST_PYTHON3_WHEEL_VERSION)
HOST_PYTHON3_WHEEL_SUFFIX		:= tar.gz
HOST_PYTHON3_WHEEL_URL			:= $(call ptx/mirror-pypi, wheel, $(HOST_PYTHON3_WHEEL).$(HOST_PYTHON3_WHEEL_SUFFIX))
HOST_PYTHON3_WHEEL_SOURCE		:= $(SRCDIR)/$(HOST_PYTHON3_WHEEL).$(HOST_PYTHON3_WHEEL_SUFFIX)
HOST_PYTHON3_WHEEL_DIR			:= $(HOST_BUILDDIR)/$(HOST_PYTHON3_WHEEL)
HOST_PYTHON3_WHEEL_LICENSE		:= MIT
HOST_PYTHON3_WHEEL_LICENSE_FILES	:= \
	file://LICENSE.txt;md5=7ffb0db04527cfe380e4f2726bd05ebf

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_PYTHON3_WHEEL_CONF_TOOL	:= python3

# vim: syntax=make
