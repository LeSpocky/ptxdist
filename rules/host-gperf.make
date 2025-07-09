# -*-makefile-*-
#
# Copyright (C) 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_GPERF) += host-gperf

#
# Paths and names
#
HOST_GPERF_VERSION	:= 3.3
HOST_GPERF_MD5		:= 31753b021ea78a21f154bf9eecb8b079
HOST_GPERF		:= gperf-$(HOST_GPERF_VERSION)
HOST_GPERF_SUFFIX	:= tar.gz
HOST_GPERF_URL		:= $(call ptx/mirror, GNU, gperf/$(HOST_GPERF).$(HOST_GPERF_SUFFIX))
HOST_GPERF_SOURCE	:= $(SRCDIR)/$(HOST_GPERF).$(HOST_GPERF_SUFFIX)
HOST_GPERF_DIR		:= $(HOST_BUILDDIR)/$(HOST_GPERF)
HOST_GPERF_LICENSE	:= GPL-3.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_GPERF_CONF_TOOL	:= autoconf

# vim: syntax=make
