# -*-makefile-*-
#
# Copyright (C) 2010 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBICAL) += libical

#
# Paths and names
#
LIBICAL_VERSION	:= 3.0.20
LIBICAL_MD5	:= 539a8a293d344e7aa8ccf3740494a46d
LIBICAL		:= libical-$(LIBICAL_VERSION)
LIBICAL_SUFFIX	:= tar.gz
LIBICAL_URL	:= https://github.com/libical/libical/releases/download/v$(LIBICAL_VERSION)/$(LIBICAL).$(LIBICAL_SUFFIX)
LIBICAL_SOURCE	:= $(SRCDIR)/$(LIBICAL).$(LIBICAL_SUFFIX)
LIBICAL_DIR	:= $(BUILDDIR)/$(LIBICAL)
LIBICAL_LICENSE	:= LGPL-2.1-only OR MPL-2.0
LIBICAL_LICENSE_FILES := \
	file://LICENSE;md5=1910a2a76ddf6a9ba369182494170d87 \
	file://LICENSE.LGPL21.txt;md5=8f690bb538f4b301d931374a6eb864d0 \
	file://LICENSE.MPL2.txt;md5=f75d2927d3c1ed2414ef72048f5ad640

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------
#
# cmake
#
LIBICAL_CONF_TOOL := cmake
LIBICAL_CONF_OPT := \
	$(CROSS_CMAKE_USR) \
	-DGOBJECT_INTROSPECTION=OFF \
	-DICAL_ALLOW_EMPTY_PROPERTIES=OFF \
	-DICAL_BUILD_DOCS=OFF \
	-DICAL_ERRORS_ARE_FATAL=OFF \
	-DICAL_GLIB=OFF \
	-DICAL_GLIB_VAPI=OFF \
	-DLIBICAL_BUILD_TESTING=OFF \
	-DSHARED_ONLY=ON \
	-DSTATIC_ONLY=OFF \
	-DWITH_CXX_BINDINGS=$(call ptx/onoff,PTXCONF_LIBICAL_CXX) \
	\
	-DCMAKE_DISABLE_FIND_PACKAGE_BerkeleyDB=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_ICU=ON

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libical.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libical)
	@$(call install_fixup, libical,PRIORITY,optional)
	@$(call install_fixup, libical,SECTION,base)
	@$(call install_fixup, libical,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libical,DESCRIPTION,missing)

	@$(call install_lib, libical, 0, 0, 0644, libical)
	@$(call install_lib, libical, 0, 0, 0644, libicalss)
	@$(call install_lib, libical, 0, 0, 0644, libicalvcal)

ifdef PTXCONF_LIBICAL_CXX
	@$(call install_lib, libical, 0, 0, 0644, libical_cxx)
	@$(call install_lib, libical, 0, 0, 0644, libicalss_cxx)
endif
	@$(call install_finish, libical)

	@$(call touch)

# vim: syntax=make
