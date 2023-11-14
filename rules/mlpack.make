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
PACKAGES-$(PTXCONF_MLPACK) += mlpack

#
# Paths and names
#
MLPACK_VERSION		:= 4.2.1
MLPACK_MD5		:= e1211d743ae36ec997393ee37da8bd47
MLPACK			:= mlpack-$(MLPACK_VERSION)
MLPACK_SUFFIX		:= tar.gz
MLPACK_URL		:= http://mlpack.org/files/$(MLPACK).$(MLPACK_SUFFIX)
MLPACK_SOURCE		:= $(SRCDIR)/$(MLPACK).$(MLPACK_SUFFIX)
MLPACK_DIR		:= $(BUILDDIR)/$(MLPACK)
MLPACK_LICENSE		:= BSD-3-Clause
MLPACK_LICENSE_FILES	:= \
	file://COPYRIGHT.txt;md5=da8e2867343cf541d8497084c566817e

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# cmake
#
MLPACK_CONF_TOOL	:= cmake
MLPACK_CONF_OPT	:=  \
	$(CROSS_CMAKE_USR) \
	-G Ninja \
	-DARMA_EXTRA_DEBUG=OFF \
	-DBOARD_NAME=ptx \
	-DBUILD_CLI_EXECUTABLES=ON \
	-DBUILD_GO_BINDINGS=OFF \
	-DBUILD_GO_SHLIB=OFF \
	-DBUILD_JULIA_BINDINGS=OFF \
	-DBUILD_MARKDOWN_BINDINGS=OFF \
	-DBUILD_PYTHON_BINDINGS=OFF \
	-DBUILD_R_BINDINGS=OFF \
	-DBUILD_SHARED_LIBS=ON \
	-DBUILD_TESTS=OFF \
	-DCOTIRE_DEBUG=OFF \
	-DCOTIRE_VERBOSE=OFF \
	-DDEBUG=OFF \
	-DDOWNLOAD_DEPENDENCIES=OFF \
	-DMATHJAX=OFF \
	-DPROFILE=OFF \
	-DTEST_VERBOSE=OFF \
	-DUSE_OPENMP=ON

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/mlpack.targetinstall:
	@$(call targetinfo)

	@$(call install_init, mlpack)
	@$(call install_fixup, mlpack,PRIORITY,optional)
	@$(call install_fixup, mlpack,SECTION,base)
	@$(call install_fixup, mlpack,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, mlpack,DESCRIPTION,missing)

ifdef PTXCONF_MLPACK_TOOLS
	@$(call install_tree, mlpack, 0, 0, -, /usr/bin)
endif

	@$(call install_finish, mlpack)

	@$(call touch)

# vim: syntax=make
