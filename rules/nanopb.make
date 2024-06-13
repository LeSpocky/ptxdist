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
PACKAGES-$(PTXCONF_NANOPB) += nanopb

#
# Paths and names
#
NANOPB_VERSION		:= 0.4.8
NANOPB_MD5		:= 7c5305add7bf70b915c6eb1dc50cc20f
NANOPB			:= nanopb-$(NANOPB_VERSION)
NANOPB_SUFFIX		:= tar.gz
NANOPB_URL		:= https://jpa.kapsi.fi/nanopb/download/$(NANOPB).$(NANOPB_SUFFIX)
NANOPB_SOURCE		:= $(SRCDIR)/$(NANOPB).$(NANOPB_SUFFIX)
NANOPB_DIR		:= $(BUILDDIR)/$(NANOPB)
NANOPB_LICENSE		:= Zlib
NANOPB_LICENSE_FILES	:= file://LICENSE.txt;md5=9db4b73a55a3994384112efcdb37c01f

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# cmake
#
NANOPB_CONF_TOOL	:= cmake
NANOPB_CONF_OPT		:= \
	$(CROSS_CMAKE_USR)

# Note: the package installs only headers, generators, and static libraries, so
# no targetinstall stage is needed.

# vim: syntax=make
