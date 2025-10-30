# -*-makefile-*-
#
# Copyright (C) 2019 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ARCH_X86)-$(PTXCONF_INTEL_GMMLIB) += intel-gmmlib

#
# Paths and names
#
INTEL_GMMLIB_VERSION	:= 22.8.2
INTEL_GMMLIB_MD5	:= e43198dee270a7accad3d39e2385ed9b
INTEL_GMMLIB		:= intel-gmmlib-$(INTEL_GMMLIB_VERSION)
INTEL_GMMLIB_SUFFIX	:= tar.gz
INTEL_GMMLIB_URL	:= https://github.com/intel/gmmlib/archive/$(INTEL_GMMLIB).$(INTEL_GMMLIB_SUFFIX)
INTEL_GMMLIB_SOURCE	:= $(SRCDIR)/$(INTEL_GMMLIB).$(INTEL_GMMLIB_SUFFIX)
INTEL_GMMLIB_DIR	:= $(BUILDDIR)/$(INTEL_GMMLIB)
INTEL_GMMLIB_LICENSE	:= MIT AND BSD-3-Clause
INTEL_GMMLIB_LICENSE_FILES := \
	file://LICENSE.md;md5=465fe90caea3edd6a2cecb3f0c28a654

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# cmake
#
INTEL_GMMLIB_CONF_TOOL	:= cmake
INTEL_GMMLIB_CONF_OPT	:= \
	$(CROSS_CMAKE_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/intel-gmmlib.targetinstall:
	@$(call targetinfo)

	@$(call install_init, intel-gmmlib)
	@$(call install_fixup, intel-gmmlib,PRIORITY,optional)
	@$(call install_fixup, intel-gmmlib,SECTION,base)
	@$(call install_fixup, intel-gmmlib,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, intel-gmmlib,DESCRIPTION,missing)

	@$(call install_lib, intel-gmmlib, 0, 0, 0644, libigdgmm)

	@$(call install_finish, intel-gmmlib)

	@$(call touch)

# vim: syntax=make
