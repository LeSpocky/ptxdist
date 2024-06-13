# -*-makefile-*-
#
# Copyright (C) 2024 by Roland Hieber <rhi@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_PROTOBUF) += python3-protobuf

#
# Paths and names
#
PYTHON3_PROTOBUF_VERSION	:= 5.26.1
PYTHON3_PROTOBUF_MD5		:= 8360a781926b9dac954678a823835d23
PYTHON3_PROTOBUF		:= protobuf-$(PYTHON3_PROTOBUF_VERSION)
PYTHON3_PROTOBUF_SUFFIX		:= tar.gz
PYTHON3_PROTOBUF_URL		:= $(call ptx/mirror-pypi, protobuf, $(PYTHON3_PROTOBUF).$(PYTHON3_PROTOBUF_SUFFIX))
PYTHON3_PROTOBUF_SOURCE		:= $(SRCDIR)/$(PYTHON3_PROTOBUF).$(PYTHON3_PROTOBUF_SUFFIX)
PYTHON3_PROTOBUF_DIR		:= $(BUILDDIR)/$(PYTHON3_PROTOBUF)
PYTHON3_PROTOBUF_LICENSE	:= BSD-3-Clause AND custom-exception
PYTHON3_PROTOBUF_LICENSE_FILES	:= \
	file://PKG-INFO;startline=7;endline=9;md5=b2e1494c98b3b7127af75dfb2edf369e \
	file://LICENSE;md5=37b5762e07f0af8c74ce80a8bda4266b

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_PROTOBUF_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-protobuf.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-protobuf)
	@$(call install_fixup, python3-protobuf,PRIORITY,optional)
	@$(call install_fixup, python3-protobuf,SECTION,base)
	@$(call install_fixup, python3-protobuf,AUTHOR,"Roland Hieber <rhi@pengutronix.de>")
	@$(call install_fixup, python3-protobuf,DESCRIPTION,missing)

	@$(call install_glob, python3-protobuf, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),, *.py)

	@$(call install_finish, python3-protobuf)

	@$(call touch)

# vim: syntax=make
