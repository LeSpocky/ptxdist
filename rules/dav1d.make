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
DAV1D_VERSION		:= 1.5.4
DAV1D_SHA256		:= 2abfb0c89212e6e4733a54e0ae509ec00a5b845a6360946f918806e14aedb011
DAV1D			:= dav1d-$(DAV1D_VERSION)
DAV1D_SUFFIX		:= tar.bz2
DAV1D_URL		:= https://code.videolan.org/videolan/dav1d/-/archive/$(DAV1D_VERSION)/$(DAV1D).$(DAV1D_SUFFIX)
DAV1D_SOURCE		:= $(SRCDIR)/$(DAV1D).$(DAV1D_SUFFIX)
DAV1D_DIR		:= $(BUILDDIR)/$(DAV1D)
DAV1D_LICENSE		:= BSD-2-Clause
DAV1D_LICENSE_FILES	:= \
	file://COPYING;md5=48d9210a87a24f62609b5a4f777d8dfe

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# meson
#
DAV1D_CONF_TOOL	:= meson
DAV1D_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Denable_docs=false \
	-Denable_examples=false \
	-Denable_tests=false \
	-Denable_tools=false

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
