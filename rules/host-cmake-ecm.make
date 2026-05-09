# -*-makefile-*-
#
# Copyright (C) 2019 by Lucas Stach <l.stach@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_CMAKE_ECM) += host-cmake-ecm

#
# Paths and names
#
HOST_CMAKE_ECM_VERSION		:= 5.56.0
HOST_CMAKE_ECM_SHA256		:= 913ce70cd64c5a35586f1ecdac5d6417cb128a9d3829ded7bb95e602d0ecb528
HOST_CMAKE_ECM			:= extra-cmake-modules-$(HOST_CMAKE_ECM_VERSION)
HOST_CMAKE_ECM_SUFFIX		:= tar.xz
HOST_CMAKE_ECM_URL		:= \
	https://download.kde.org/stable/frameworks/$(basename $(HOST_CMAKE_ECM_VERSION))/$(HOST_CMAKE_ECM).$(HOST_CMAKE_ECM_SUFFIX) \
	https://download.kde.org/Attic/frameworks/$(basename $(HOST_CMAKE_ECM_VERSION))/$(HOST_CMAKE_ECM).$(HOST_CMAKE_ECM_SUFFIX)
HOST_CMAKE_ECM_SOURCE		:= $(SRCDIR)/$(HOST_CMAKE_ECM).$(HOST_CMAKE_ECM_SUFFIX)
HOST_CMAKE_ECM_DIR		:= $(HOST_BUILDDIR)/$(HOST_CMAKE_ECM)
HOST_CMAKE_ECM_LICENSE		:= BSD-3-Clause

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_CMAKE_ECM_CONF_TOOL	:= cmake
HOST_CMAKE_ECM_CONF_OPT		:= \
	$(HOST_CMAKE_OPT) \
	-DBUILD_HTML_DOCS=OFF \
	-DBUILD_MAN_DOCS=OFF \
	-DBUILD_QTHELP_DOCS=OFF \
	-DBUILD_TESTING=OFF

# vim: syntax=make
