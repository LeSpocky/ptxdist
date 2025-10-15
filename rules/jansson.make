# -*-makefile-*-
#
# Copyright (C) 2014 by Christian Gieseler <cg@eks-engel.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_JANSSON) += jansson

#
# Paths and names
#
JANSSON_VERSION	:= 2.14.1
JANSSON_MD5	:= 6a4307413fedc78342b5555cec9474a0
JANSSON		:= jansson-$(JANSSON_VERSION)
JANSSON_SUFFIX	:= tar.gz
JANSSON_URL	:= https://github.com/akheron/jansson/archive/refs/tags/v$(JANSSON_VERSION).$(JANSSON_SUFFIX)
JANSSON_SOURCE	:= $(SRCDIR)/$(JANSSON).$(JANSSON_SUFFIX)
JANSSON_DIR	:= $(BUILDDIR)/lib$(JANSSON)
JANSSON_LICENSE	:= MIT AND dtoa
JANSSON_LICENSE_FILES := \
	file://LICENSE;md5=d9911525d4128bee234ee2d3ccaa2537 \
	file://src/jansson.h;startline=1;endline=6;md5=46863262fe45ff28360cdf0aecc2264e \
	file://src/dtoa.c;startline=2;endline=19;md5=0893720de1a2e17053089dc16f743e11

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

JANSSON_CONF_TOOL	:= cmake
JANSSON_CONF_OPT	:= \
	$(CROSS_CMAKE_USR) \
	-DJANSSON_BUILD_DOCS=OFF \
	-DJANSSON_BUILD_SHARED_LIBS=ON \
	-DJANSSON_COVERAGE=OFF \
	-DJANSSON_EXAMPLES=OFF \
	-DJANSSON_INSTALL=ON \
	-DJANSSON_WITHOUT_TESTS=ON \
	-DUSE_DTOA=ON \
	-DUSE_URANDOM=ON

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/jansson.targetinstall:
	@$(call targetinfo)

	@$(call install_init, jansson)
	@$(call install_fixup, jansson,PRIORITY,optional)
	@$(call install_fixup, jansson,SECTION,base)
	@$(call install_fixup, jansson,AUTHOR,"Christian Gieseler <cg@eks-engel.de>")
	@$(call install_fixup, jansson,DESCRIPTION,missing)

	@$(call install_lib, jansson, 0, 0, 0644, libjansson)

	@$(call install_finish, jansson)

	@$(call touch)

# vim: syntax=make
