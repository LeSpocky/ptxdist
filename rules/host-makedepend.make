# -*-makefile-*-
#
# Copyright (C) 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_MAKEDEPEND) += host-makedepend

#
# Paths and names
#
HOST_MAKEDEPEND_VERSION	:= 1.0.7
HOST_MAKEDEPEND_MD5	:= 8239b4474690663a69888355a35ca6fd
HOST_MAKEDEPEND		:= makedepend-$(HOST_MAKEDEPEND_VERSION)
HOST_MAKEDEPEND_SUFFIX	:= tar.xz
HOST_MAKEDEPEND_URL	:= $(call ptx/mirror, XORG, individual/util/$(HOST_MAKEDEPEND).$(HOST_MAKEDEPEND_SUFFIX))
HOST_MAKEDEPEND_SOURCE	:= $(SRCDIR)/$(HOST_MAKEDEPEND).$(HOST_MAKEDEPEND_SUFFIX)
HOST_MAKEDEPEND_DIR	:= $(HOST_BUILDDIR)/$(HOST_MAKEDEPEND)
HOST_MAKEDEPEND_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_MAKEDEPEND_CONF_TOOL	:= autoconf

# vim: syntax=make
