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
LIBICAL_VERSION	:= 4.0.7
LIBICAL_SHA256	:= 47c05bc96e41416578cf1803bb2ba3f8d292cb17d5ac2fca539dee922bae8a94
LIBICAL		:= libical-$(LIBICAL_VERSION)
LIBICAL_SUFFIX	:= tar.gz
LIBICAL_URL	:= https://github.com/libical/libical/releases/download/v$(LIBICAL_VERSION)/$(LIBICAL).$(LIBICAL_SUFFIX)
LIBICAL_SOURCE	:= $(SRCDIR)/$(LIBICAL).$(LIBICAL_SUFFIX)
LIBICAL_DIR	:= $(BUILDDIR)/$(LIBICAL)
LIBICAL_LICENSE	:= LGPL-2.1-only OR MPL-2.0
LIBICAL_LICENSE_FILES := \
	file://README.md;startline=28;endline=45;md5=c80c40d23d93ff0522c5541a03c97758 \
	file://LICENSES/LGPL-2.1-only.txt;md5=41890f71f740302b785c27661123bff5 \
	file://LICENSES/MPL-2.0.txt;md5=f75d2927d3c1ed2414ef72048f5ad640

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------
#
# cmake
#
LIBICAL_CONF_TOOL := cmake
LIBICAL_CONF_OPT := \
	$(CROSS_CMAKE_USR) \
	-DLIBICAL_BUILD_DOCS=OFF \
	-DLIBICAL_BUILD_EXAMPLES=OFF \
	-DLIBICAL_BUILD_TESTING=OFF \
	-DLIBICAL_BUILD_VZIC=OFF \
	-DLIBICAL_CXX_BINDINGS=$(call ptx/onoff,PTXCONF_LIBICAL_CXX) \
	-DLIBICAL_DEVMODE=OFF \
	-DLIBICAL_ENABLE_64BIT_ICALTIME_T=$(call ptx/onoff, PTXDIST_Y2038) \
	-DLIBICAL_GLIB=OFF \
	-DLIBICAL_GLIB_VAPI=OFF \
	-DLIBICAL_GOBJECT_INTROSPECTION=OFF \
	-DLIBICAL_JAVA_BINDINGS=OFF \
	-DLIBICAL_STATIC=OFF \
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
