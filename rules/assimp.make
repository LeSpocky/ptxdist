# -*-makefile-*-
#
# Copyright (C) 2020 by Philipp Zabel <p.zabel@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ASSIMP) += assimp

#
# Paths and names
#
ASSIMP_VERSION	:= 5.4.3
ASSIMP_MD5	:= fd64a9a57a3d81940ba7fc4a3a946502
ASSIMP		:= assimp-$(ASSIMP_VERSION)
ASSIMP_SUFFIX	:= tar.gz
ASSIMP_URL	:= https://github.com/assimp/assimp/archive/refs/tags/v$(ASSIMP_VERSION).$(ASSIMP_SUFFIX)
ASSIMP_SOURCE	:= $(SRCDIR)/$(ASSIMP).$(ASSIMP_SUFFIX)
ASSIMP_DIR	:= $(BUILDDIR)/$(ASSIMP)
ASSIMP_LICENSE	:= Open Asset Import Library (assimp)
ASSIMP_LICENSE_FILES := file://LICENSE;md5=d9d5275cab4fb13ae624d42ce64865de

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ASSIMP_CONF_TOOL := cmake

ASSIMP_CONF_OPT := \
	$(CROSS_CMAKE_USR) \
	-DASSIMP_ANDROID_JNIIOSYSTEM=OFF \
	-DASSIMP_ASAN=OFF \
	-DASSIMP_BUILD_ALL_IMPORTERS_BY_DEFAULT=OFF \
	-DASSIMP_BUILD_3DS_IMPORTER=ON \
	-DASSIMP_BUILD_PLY_IMPORTER=ON \
	-DASSIMP_BUILD_ASSIMP_TOOLS=OFF \
	-DASSIMP_BUILD_DOCS=OFF \
	-DASSIMP_BUILD_DRACO=OFF \
	-DASSIMP_BUILD_FRAMEWORK=OFF \
	-DASSIMP_BUILD_NONFREE_C4D_IMPORTER=OFF \
	-DASSIMP_BUILD_SAMPLES=OFF \
	-DASSIMP_BUILD_TESTS=OFF \
	-DASSIMP_BUILD_USD_IMPORTER=OFF \
	-DASSIMP_BUILD_USD_VERBOSE_LOGS=OFF \
	-DASSIMP_BUILD_USE_CCACHE=OFF \
	-DASSIMP_BUILD_ZLIB=OFF \
	-DASSIMP_COVERALLS=OFF \
	-DASSIMP_DOUBLE_PRECISION=OFF \
	-DASSIMP_HUNTER_ENABLED=OFF \
	-DASSIMP_IGNORE_GIT_HASH=OFF \
	-DASSIMP_INJECT_DEBUG_POSTFIX=OFF \
	-DASSIMP_INSTALL=ON \
	-DASSIMP_LIBRARY_SUFFIX= \
	-DASSIMP_NO_EXPORT=ON \
	-DASSIMP_OPT_BUILD_PACKAGES=OFF \
	-DASSIMP_PACKAGE_VERSION=0 \
	-DASSIMP_RAPIDJSON_NO_MEMBER_ITERATOR=ON \
	-DASSIMP_UBSAN=OFF \
	-DASSIMP_WARNINGS_AS_ERRORS=OFF \
	-DBUILD_SHARED_LIBS=ON \
	-DCMAKE_DEBUG_POSTFIX=

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/assimp.targetinstall:
	@$(call targetinfo)

	@$(call install_init, assimp)
	@$(call install_fixup, assimp, PRIORITY, optional)
	@$(call install_fixup, assimp, SECTION, base)
	@$(call install_fixup, assimp, AUTHOR, "Philipp Zabel <p.zabel@pengutronix.de>")
	@$(call install_fixup, assimp, DESCRIPTION, missing)

	$(call install_lib, assimp, 0, 0, 0644, libassimp)

	@$(call install_finish, assimp)

	@$(call touch)

# vim: syntax=make
