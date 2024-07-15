# -*-makefile-*-
#
# Copyright (C) 2023 by Roland Hieber <rhi@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBSLIRP) += libslirp

#
# Paths and names
#
LIBSLIRP_VERSION	:= 4.8.0
LIBSLIRP_MD5		:= 4f701d26a46fe9bf6db302aef6ed467f
LIBSLIRP		:= libslirp-v$(LIBSLIRP_VERSION)
LIBSLIRP_SUFFIX		:= tar.bz2
LIBSLIRP_URL		:= https://gitlab.freedesktop.org/slirp/libslirp/-/archive/v4.7.0/$(LIBSLIRP).$(LIBSLIRP_SUFFIX)
LIBSLIRP_SOURCE		:= $(SRCDIR)/$(LIBSLIRP).$(LIBSLIRP_SUFFIX)
LIBSLIRP_DIR		:= $(BUILDDIR)/$(LIBSLIRP)
LIBSLIRP_LICENSE	:= BSD-3-Clause AND MIT
LIBSLIRP_LICENSE_FILES	:= \
	file://src/main.h;startline=1;endline=4;md5=1e742c49b6e4dd48549742f8727faceb \
	file://src/slirp.c;startline=1;endline=24;md5=1e11fddaa17f36215c1697d4bad0e70a \
	file://COPYRIGHT;md5=bca0186b14e6b05e338e729f106db727

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# meson
#
LIBSLIRP_CONF_TOOL	:= meson

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libslirp.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libslirp)
	@$(call install_fixup, libslirp,PRIORITY,optional)
	@$(call install_fixup, libslirp,SECTION,base)
	@$(call install_fixup, libslirp,AUTHOR,"Roland Hieber <rhi@pengutronix.de>")
	@$(call install_fixup, libslirp,DESCRIPTION,missing)

	@$(call install_lib, libslirp, 0, 0, 0644, libslirp)

	@$(call install_finish, libslirp)

	@$(call touch)

# vim: syntax=make
