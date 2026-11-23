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
CPPZMQ_VERSION	:= 4.11.0
CPPZMQ_SHA256	:= 0fff4ff311a7c88fdb76fceefba0e180232d56984f577db371d505e4d4c91afd
CPPZMQ		:= cppzmq-$(CPPZMQ_VERSION)
CPPZMQ_SUFFIX	:= tar.gz
CPPZMQ_URL	:= https://github.com/zeromq/cppzmq/archive/v$(CPPZMQ_VERSION).$(CPPZMQ_SUFFIX)
CPPZMQ_SOURCE	:= $(SRCDIR)/$(CPPZMQ).$(CPPZMQ_SUFFIX)
CPPZMQ_DIR	:= $(BUILDDIR)/$(CPPZMQ)
CPPZMQ_LICENSE	:= MIT
CPPZMQ_LICENSE_FILES := \
	file://LICENSE;md5=db174eaf7b55a34a7c89551197f66e94 \
	file://zmq.hpp;startline=1;endline=24;md5=6269dcec47c831ac647d58976edd5120

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

CPPZMQ_CONF_TOOL	:= cmake
CPPZMQ_CONF_OPT		:= \
	$(CROSS_CMAKE_USR) \
	-DCPPZMQ_BUILD_TESTS:BOOL=OFF

# vim: syntax=make
