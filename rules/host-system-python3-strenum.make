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
HOST_PACKAGES-$(PTXCONF_HOST_SYSTEM_PYTHON3_STRENUM) += host-system-python3-strenum

#
# Paths and names
#
HOST_SYSTEM_PYTHON3_STRENUM_VERSION		:= 0.4.15
HOST_SYSTEM_PYTHON3_STRENUM_MD5			:= aa5e934c299dac8731c6db4008deab4d
HOST_SYSTEM_PYTHON3_STRENUM			:= StrEnum-$(HOST_SYSTEM_PYTHON3_STRENUM_VERSION)
HOST_SYSTEM_PYTHON3_STRENUM_SUFFIX		:= tar.gz
HOST_SYSTEM_PYTHON3_STRENUM_URL			:= $(call ptx/mirror-pypi, StrEnum, $(HOST_SYSTEM_PYTHON3_STRENUM).$(HOST_SYSTEM_PYTHON3_STRENUM_SUFFIX))
HOST_SYSTEM_PYTHON3_STRENUM_SOURCE		:= $(SRCDIR)/$(HOST_SYSTEM_PYTHON3_STRENUM).$(HOST_SYSTEM_PYTHON3_STRENUM_SUFFIX)
HOST_SYSTEM_PYTHON3_STRENUM_DIR			:= $(HOST_BUILDDIR)/$(HOST_SYSTEM_PYTHON3_STRENUM)
HOST_SYSTEM_PYTHON3_STRENUM_LICENSE		:= MIT
HOST_SYSTEM_PYTHON3_STRENUM_LICENSE_FILES	:= file://LICENSE;md5=ba0eb3de1df70bde0ed48488cfd81269

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_SYSTEM_PYTHON3_STRENUM_CONF_TOOL	:= python3

# vim: ft=make
