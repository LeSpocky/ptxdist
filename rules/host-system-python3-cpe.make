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
HOST_PACKAGES-$(PTXCONF_HOST_SYSTEM_PYTHON3_CPE) += host-system-python3-cpe

#
# Paths and names
#
HOST_SYSTEM_PYTHON3_CPE_VERSION		:= 1.3.1
HOST_SYSTEM_PYTHON3_CPE_MD5		:= 482238ed1786c4dfec0d4885c214e851
HOST_SYSTEM_PYTHON3_CPE			:= cpe-$(HOST_SYSTEM_PYTHON3_CPE_VERSION)
HOST_SYSTEM_PYTHON3_CPE_SUFFIX		:= tar.gz
HOST_SYSTEM_PYTHON3_CPE_URL		:= $(call ptx/mirror-pypi, cpe, $(HOST_SYSTEM_PYTHON3_CPE).$(HOST_SYSTEM_PYTHON3_CPE_SUFFIX))
HOST_SYSTEM_PYTHON3_CPE_SOURCE		:= $(SRCDIR)/$(HOST_SYSTEM_PYTHON3_CPE).$(HOST_SYSTEM_PYTHON3_CPE_SUFFIX)
HOST_SYSTEM_PYTHON3_CPE_DIR		:= $(HOST_BUILDDIR)/system-$(HOST_SYSTEM_PYTHON3_CPE)
HOST_SYSTEM_PYTHON3_CPE_LICENSE		:= LGPL-3.0-or-later
HOST_SYSTEM_PYTHON3_CPE_LICENSE_FILES	:= file://LICENSE;md5=e6a600fd5e1d9cbde2d983680233ad02

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_SYSTEM_PYTHON3_CPE_CONF_TOOL	:= python3

# vim: syntax=make
