# -*-makefile-*-
#
# Copyright (C) 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_XZ) += host-xz

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_XZ_CONF_TOOL	:= cmake
HOST_XZ_CONF_OPT	:= \
	$(HOST_CMAKE_OPT) \
	-DBUILD_SHARED_LIBS=ON \
	-DBUILD_TESTING=OFF \
	-DTUKLIB_USE_UNSAFE_TYPE_PUNNING=OFF \
	-DXZ_DOC=OFF \
	-DXZ_DOXYGEN=OFF \
	-DXZ_EXTERNAL_SHA256=OFF \
	-DXZ_LZIP_DECODER=OFF \
	-DXZ_MICROLZMA_DECODER=OFF \
	-DXZ_MICROLZMA_ENCODER=OFF \
	-DXZ_NLS=OFF \
	-DXZ_SANDBOX=no \
	-DXZ_SMALL=OFF \
	-DXZ_SYMBOL_VERSIONING=linux \
	-DXZ_THREADS=yes \
	-DXZ_TOOL_LZMADEC=OFF \
	-DXZ_TOOL_LZMAINFO=OFF \
	-DXZ_TOOL_SCRIPTS=OFF \
	-DXZ_TOOL_SYMLINKS=OFF \
	-DXZ_TOOL_SYMLINKS_LZMA=OFF \
	-DXZ_TOOL_XZ=ON \
	-DXZ_TOOL_XZDEC=OFF

# vim: syntax=make
