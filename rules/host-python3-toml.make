# -*-makefile-*-
#
# Copyright (C) 2020 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_PYTHON3_TOML) += host-python3-toml

#
# Paths and names
#
HOST_PYTHON3_TOML_VERSION	:= 0.10.2
HOST_PYTHON3_TOML_MD5		:= 59bce5d8d67e858735ec3f399ec90253
HOST_PYTHON3_TOML		:= toml-$(HOST_PYTHON3_TOML_VERSION)
HOST_PYTHON3_TOML_SUFFIX	:= tar.gz
HOST_PYTHON3_TOML_URL		:= $(call ptx/mirror-pypi, toml, $(HOST_PYTHON3_TOML).$(HOST_PYTHON3_TOML_SUFFIX))
HOST_PYTHON3_TOML_SOURCE	:= $(SRCDIR)/$(HOST_PYTHON3_TOML).$(HOST_PYTHON3_TOML_SUFFIX)
HOST_PYTHON3_TOML_DIR		:= $(HOST_BUILDDIR)/$(HOST_PYTHON3_TOML)
HOST_PYTHON3_TOML_LICENSE	:= MIT
HOST_PYTHON3_TOML_LICENSE_FILES	:= file://LICENSE;md5=16c77b2b1050d2f03cb9c2ed0edaf4f0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_PYTHON3_TOML_CONF_TOOL	:= python3

# vim: syntax=make
