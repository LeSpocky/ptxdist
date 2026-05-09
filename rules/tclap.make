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
TCLAP_VERSION	:= 1.2.1
TCLAP_SHA256	:= 9f9f0fe3719e8a89d79b6ca30cf2d16620fba3db5b9610f9b51dd2cd033deebb
TCLAP		:= tclap-$(TCLAP_VERSION)
TCLAP_SUFFIX	:= tar.gz
TCLAP_URL	:= $(call ptx/mirror, SF, tclap/$(TCLAP).$(TCLAP_SUFFIX))
TCLAP_SOURCE	:= $(SRCDIR)/$(TCLAP).$(TCLAP_SUFFIX)
TCLAP_DIR	:= $(BUILDDIR)/$(TCLAP)
TCLAP_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
TCLAP_CONF_TOOL	:= autoconf
TCLAP_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-doxygen

# vim: syntax=make
