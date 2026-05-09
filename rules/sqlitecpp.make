# -*-makefile-*-
#
# Copyright (C) 2019 by Chetan Dayananda <chetan.dayananda@in.bosch.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SQLITECPP) += sqlitecpp

#
# Paths and names
#
SQLITECPP_VERSION	:= 2.4.0
SQLITECPP_SHA256	:= 16bf963619786652a60533bcdc71a0412cad1ce132cd09ce43344af6ed7463d9
SQLITECPP		:= sqlitecpp-$(SQLITECPP_VERSION)
SQLITECPP_SUFFIX	:= tar.gz
SQLITECPP_URL		:= https://github.com/SRombauts/SQLiteCpp/archive/$(SQLITECPP_VERSION).$(SQLITECPP_SUFFIX)
SQLITECPP_SOURCE	:= $(SRCDIR)/$(SQLITECPP).tar.gz
SQLITECPP_DIR		:= $(BUILDDIR)/$(SQLITECPP)
SQLITECPP_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SQLITECPP_CONF_TOOL := cmake
SQLITECPP_CONF_OPT  := $(CROSS_CMAKE_USR) -DSQLITECPP_INTERNAL_SQLITE=OFF

#
# No Target-Install stage because the package only builds a static lib.
#

# vim: syntax=make
