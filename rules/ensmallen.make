# -*-makefile-*-
#
# Copyright (C) 2023 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ENSMALLEN) += ensmallen

#
# Paths and names
#
ENSMALLEN_VERSION	:= 2.20.0
ENSMALLEN_SHA256	:= 5c7cea756e544795b3861d171f7cc28ba0a0be6297f84026b0b17e1dfc583f24
ENSMALLEN		:= ensmallen-$(ENSMALLEN_VERSION)
ENSMALLEN_SUFFIX	:= tar.gz
ENSMALLEN_URL		:= https://www.ensmallen.org/files/$(ENSMALLEN).$(ENSMALLEN_SUFFIX)
ENSMALLEN_SOURCE	:= $(SRCDIR)/$(ENSMALLEN).$(ENSMALLEN_SUFFIX)
ENSMALLEN_DIR		:= $(BUILDDIR)/$(ENSMALLEN)
ENSMALLEN_LICENSE	:= BSD-3-Clause
ENSMALLEN_LICENSE_FILES	:= \
	file://COPYRIGHT.txt;md5=2f1c587ba8b993d5d929e322d6dbdf72

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# cmake
#
ENSMALLEN_CONF_TOOL	:= cmake
ENSMALLEN_CONF_OPT	:=  \
	$(CROSS_CMAKE_USR) \
	-DUSE_OPENMP=ON

# vim: syntax=make
