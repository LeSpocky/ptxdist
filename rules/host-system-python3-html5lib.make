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
HOST_PACKAGES-$(PTXCONF_HOST_SYSTEM_PYTHON3_HTML5LIB) += host-system-python3-html5lib

#
# Paths and names
#
HOST_SYSTEM_PYTHON3_HTML5LIB_VERSION		:= 1.1
HOST_SYSTEM_PYTHON3_HTML5LIB_MD5		:= 6748742e2ec4cb99287a6bc82bcfe2b0
HOST_SYSTEM_PYTHON3_HTML5LIB			:= html5lib-$(HOST_SYSTEM_PYTHON3_HTML5LIB_VERSION)
HOST_SYSTEM_PYTHON3_HTML5LIB_SUFFIX		:= tar.gz
HOST_SYSTEM_PYTHON3_HTML5LIB_URL		:= $(call ptx/mirror-pypi, html5lib, $(HOST_SYSTEM_PYTHON3_HTML5LIB).$(HOST_SYSTEM_PYTHON3_HTML5LIB_SUFFIX))
HOST_SYSTEM_PYTHON3_HTML5LIB_SOURCE		:= $(SRCDIR)/$(HOST_SYSTEM_PYTHON3_HTML5LIB).$(HOST_SYSTEM_PYTHON3_HTML5LIB_SUFFIX)
HOST_SYSTEM_PYTHON3_HTML5LIB_DIR		:= $(HOST_BUILDDIR)/$(HOST_SYSTEM_PYTHON3_HTML5LIB)
HOST_SYSTEM_PYTHON3_HTML5LIB_LICENSE		:= MIT
HOST_SYSTEM_PYTHON3_HTML5LIB_LICENSE_FILES	:= \
	file://LICENSE;md5=1ba5ada9e6fead1fdc32f43c9f10ba7c

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_SYSTEM_PYTHON3_HTML5LIB_CONF_TOOL	:= python3

# vim: syntax=make
