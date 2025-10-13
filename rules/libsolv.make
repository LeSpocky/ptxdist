# -*-makefile-*-
#
# Copyright (C) 2025 by Sven Püschel <s.pueschel@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBSOLV) += libsolv

#
# Paths and names
#
LIBSOLV_VERSION	:= 0.7.35
LIBSOLV_MD5	:= 442f8283a03bae0b0591536a9aac4c29
LIBSOLV		:= libsolv-$(LIBSOLV_VERSION)
LIBSOLV_SUFFIX	:= tar.gz
LIBSOLV_URL	:= https://github.com/openSUSE/libsolv/archive/$(LIBSOLV_VERSION)/$(LIBSOLV).$(LIBSOLV_SUFFIX)
LIBSOLV_SOURCE	:= $(SRCDIR)/$(LIBSOLV).$(LIBSOLV_SUFFIX)
LIBSOLV_DIR	:= $(BUILDDIR)/$(LIBSOLV)
LIBSOLV_LICENSE	:= BSD-3-Clause
LIBSOLV_LICENSE_FILES	:= \
	file://LICENSE.BSD;md5=62272bd11c97396d4aaf1c41bc11f7d8 \
	file://src/solver.c;startline=1;endline=6;md5=25bead0f383354e6ccfb31ebf9ca8be4

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBSOLV_CONF_TOOL	:= cmake
LIBSOLV_CONF_OPT	:= \
	$(CROSS_CMAKE_USR) \
	-DDISABLE_SHARED=OFF \
	-DENABLE_APK=OFF \
	-DENABLE_APPDATA=OFF \
	-DENABLE_ARCHREPO=OFF \
	-DENABLE_BZIP2_COMPRESSION=OFF \
	-DENABLE_COMPS=OFF \
	-DENABLE_CONDA=OFF \
	-DENABLE_CUDFREPO=OFF \
	-DENABLE_DEBIAN=OFF \
	-DENABLE_HAIKU=OFF \
	-DENABLE_HELIXREPO=OFF \
	-DENABLE_LUA=OFF \
	-DENABLE_LZMA_COMPRESSION=OFF \
	-DENABLE_MDKREPO=OFF \
	-DENABLE_PERL=OFF \
	-DENABLE_PUBKEY=OFF \
	-DENABLE_PYTHON=OFF \
	-DENABLE_RPMDB=OFF \
	-DENABLE_RPMDB_BDB=OFF \
	-DENABLE_RPMDB_BYRPMHEADER=OFF \
	-DENABLE_RPMDB_LIBRPM=OFF \
	-DENABLE_RPMMD=OFF \
	-DENABLE_RPMPKG=OFF \
	-DENABLE_RPMPKG_LIBRPM=OFF \
	-DENABLE_RUBY=OFF \
	-DENABLE_STATIC=OFF \
	-DENABLE_STATIC_BINDINGS=OFF \
	-DENABLE_STATIC_TOOLS=OFF \
	-DENABLE_SUSEREPO=OFF \
	-DENABLE_TCL=OFF \
	-DENABLE_ZCHUNK_COMPRESSION=OFF \
	-DENABLE_ZSTD_COMPRESSION=OFF \
	-DMULTI_SEMANTICS=ON \
	-DUSE_VENDORDIRS=OFF \
	-DWITHOUT_COOKIEOPEN=OFF \
	-DWITH_LIBXML2=OFF \
	-DWITH_SYSTEM_ZCHUNK=OFF

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libsolv.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libsolv)
	@$(call install_fixup, libsolv,PRIORITY,optional)
	@$(call install_fixup, libsolv,SECTION,base)
	@$(call install_fixup, libsolv,AUTHOR,"Sven Püschel <s.pueschel@pengutronix.de>")
	@$(call install_fixup, libsolv,DESCRIPTION,missing)

	@$(call install_lib, libsolv, 0, 0, 0644, libsolv)

	@$(call install_finish, libsolv)

	@$(call touch)

# vim: syntax=make
