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
LIBSLIRP_VERSION	:= 4.9.2
LIBSLIRP_SHA256		:= e3e1fc9f600f06006339823dc7881fbcc02973145fe073bf660a7b3132724ecc
LIBSLIRP		:= libslirp-v$(LIBSLIRP_VERSION)
LIBSLIRP_SUFFIX		:= tar.bz2
LIBSLIRP_URL		:= https://gitlab.freedesktop.org/slirp/libslirp/-/archive/v$(LIBSLIRP_VERSION)/$(LIBSLIRP).$(LIBSLIRP_SUFFIX)
LIBSLIRP_SOURCE		:= $(SRCDIR)/$(LIBSLIRP).$(LIBSLIRP_SUFFIX)
LIBSLIRP_DIR		:= $(BUILDDIR)/$(LIBSLIRP)
LIBSLIRP_LICENSE	:= BSD-3-Clause AND MIT
LIBSLIRP_LICENSE_FILES	:= \
	file://src/main.h;startline=1;endline=4;md5=1e742c49b6e4dd48549742f8727faceb \
	file://src/slirp.c;startline=1;endline=24;md5=1e11fddaa17f36215c1697d4bad0e70a \
	file://COPYRIGHT;md5=f95a9bf4a7e411164fe843697ccda59e

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# meson
#
LIBSLIRP_CONF_TOOL	:= meson
LIBSLIRP_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Dfuzz-reproduce=false \
	-Dllvm-fuzz=false \
	-Doss-fuzz=false \
	-Dstatic=false

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
