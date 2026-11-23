# -*-makefile-*-
#
# Copyright (C) 2014 by Bernhard Walle <bernhard@bwalle.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_TCLAP) += tclap

#
# Paths and names
#
TCLAP_VERSION	:= 1.4.0
TCLAP_SHA256	:= 413014a7e68740d9aa972a058532e3e9959b4af7509d6ae7b11a8c1828378567
TCLAP		:= tclap-$(TCLAP_VERSION)
TCLAP_SUFFIX	:= tar.gz
TCLAP_URL	:= $(call ptx/mirror, SF, tclap/v$(TCLAP_VERSION)/$(TCLAP).$(TCLAP_SUFFIX))
TCLAP_SOURCE	:= $(SRCDIR)/$(TCLAP).$(TCLAP_SUFFIX)
TCLAP_DIR	:= $(BUILDDIR)/$(TCLAP)
TCLAP_LICENSE	:= MIT
TCLAP_LICENSE_FILES := \
	file://COPYING;md5=79e4a7d0162e3a5de4c399b35829ca01 \
	file://include/tclap/CmdLine.h;startline=3;endline=22;md5=9789a59561e2f1feb3835122ccfa6a3c

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

TCLAP_CONF_TOOL	:= cmake
TCLAP_CONF_OPT	:= \
	$(CROSS_CMAKE_USR) \
	-DBUILD_DOC:BOOL=OFF \
	-DBUILD_EXAMPLES:BOOL=OFF \
	-DBUILD_FUZZERS:BOOL=OFF \
	-DBUILD_FUZZ_REGRESSION:BOOL=OFF \
	-DBUILD_TESTING:BOOL=OFF \
	-DBUILD_UNITTESTS:BOOL=OFF

# vim: syntax=make
