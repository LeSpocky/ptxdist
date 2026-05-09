# -*-makefile-*-
#
# Copyright (C) 2014 by Markus Pargmann <mpa@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_CPPZMQ) += cppzmq

#
# Paths and names
#
CPPZMQ_VERSION	:= ee47ae4cddc3
CPPZMQ_SHA256	:= 04b3b180c31f90ad370236ee250e4e28d4dce2a3c82094746185d47d64263e59
CPPZMQ		:= cppzmq-$(CPPZMQ_VERSION)
CPPZMQ_SUFFIX	:= tar.gz
CPPZMQ_URL	:= https://github.com/zeromq/cppzmq.git;tag=$(CPPZMQ_VERSION)
CPPZMQ_SOURCE	:= $(SRCDIR)/$(CPPZMQ).$(CPPZMQ_SUFFIX)
CPPZMQ_DIR	:= $(BUILDDIR)/$(CPPZMQ)
CPPZMQ_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

CPPZMQ_CONF_TOOL	:= NO

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/cppzmq.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/cppzmq.install:
	@$(call targetinfo)
	install -D -m 0644 $(CPPZMQ_DIR)/zmq.hpp $(CPPZMQ_PKGDIR)/usr/include/zmq.hpp
	@$(call touch)

# vim: syntax=make
