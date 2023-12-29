# -*-makefile-*-
#
# Copyright (C) 2023 by Ladislav Michl <ladis@linux-mips.org>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_DAV1D) += dav1d

#
# Paths and names
#
DAV1D_VERSION		:= 1.3.0
DAV1D_MD5		:= c8381f8346525dcd4205e9b50d80c5f4
DAV1D			:= dav1d-$(DAV1D_VERSION)
DAV1D_SUFFIX		:= tar.bz2
DAV1D_URL		:= https://code.videolan.org/videolan/dav1d/-/archive/$(DAV1D_VERSION)/$(DAV1D).$(DAV1D_SUFFIX) 
DAV1D_SOURCE		:= $(SRCDIR)/$(DAV1D).$(DAV1D_SUFFIX)
DAV1D_DIR		:= $(BUILDDIR)/$(DAV1D)
DAV1D_LICENSE		:= BSD-2-Clause
DAV1D_LICENSE_FILES	:= \
	file://COPYING;md5=c8055cfe7548dfdaa3a6dc45d8793669

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# meson
#
DAV1D_CONF_TOOL	:= meson
DAV1D_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Denable_tools=false \
	-Denable_examples=false \
	-Denable_tests=false \
	-Denable_docs=false

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/dav1d.targetinstall:
	@$(call targetinfo)

	@$(call install_init, dav1d)
	@$(call install_fixup, dav1d,PRIORITY,optional)
	@$(call install_fixup, dav1d,SECTION,base)
	@$(call install_fixup, dav1d,AUTHOR,"Ladislav Michl <ladis@linux-mips.org>")
	@$(call install_fixup, dav1d,DESCRIPTION,missing)

	@$(call install_lib, dav1d, 0, 0, 0644, libdav1d)

	@$(call install_finish, dav1d)

	@$(call touch)

# vim: syntax=make
