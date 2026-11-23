# -*-makefile-*-
#
# Copyright (C) 2014 by Guillaume Gourat <guillaume.gourat@nexvision.fr>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GFLAGS) += gflags

#
# Paths and names
#
GFLAGS_VERSION	:= 2.3.1
GFLAGS_SHA256	:= 1b5e0648d7b94021895086e65479b4eaca7935eecfffd7dd9512eb576181c53d
GFLAGS		:= gflags-$(GFLAGS_VERSION)
GFLAGS_SUFFIX	:= tar.gz
GFLAGS_URL	:= https://github.com/gflags/gflags/archive/v$(GFLAGS_VERSION).$(GFLAGS_SUFFIX)
GFLAGS_SOURCE	:= $(SRCDIR)/$(GFLAGS).$(GFLAGS_SUFFIX)
GFLAGS_DIR	:= $(BUILDDIR)/$(GFLAGS)
GFLAGS_LICENSE	:= BSD-3-Clause
GFLAGS_LICENSE_FILES := \
	file://COPYING.txt;md5=c80d1a3b623f72bb85a4c75b556551df \
	file://src/gflags.cc;startline=1;endline=28;md5=b448aec288355ab09537d530d8ef87ef

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GFLAGS_CONF_TOOL	:= cmake
GFLAGS_CONF_OPT		:= \
	$(CROSS_CMAKE_USR) \
	-DBUILD_PACKAGING:BOOL=OFF \
	-DBUILD_SHARED_LIBS:BOOL=ON \
	-DBUILD_STATIC_LIBS:BOOL=OFF \
	-DBUILD_TESTING:BOOL=OFF \
	-DBUILD_gflags_LIB:BOOL=ON \
	-DBUILD_gflags_nothreads_LIB:BOOL=OFF \
	-DEXPORT_NAMESPACE_SET:BOOL=ON \
	-DEXPORT_NONAMESPACE_SET:BOOL=ON \
	-DREGISTER_BUILD_DIR:BOOL=OFF \
	-DREGISTER_INSTALL_PREFIX:BOOL=OFF

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gflags.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gflags)
	@$(call install_fixup, gflags,PRIORITY,optional)
	@$(call install_fixup, gflags,SECTION,base)
	@$(call install_fixup, gflags,AUTHOR,"Guillaume Gourat <guillaume.gourat@nexvision.fr>")
	@$(call install_fixup, gflags,DESCRIPTION,missing)

	@$(call install_lib, gflags, 0, 0, 0644, libgflags)

	@$(call install_finish, gflags)

	@$(call touch)

# vim: syntax=make
