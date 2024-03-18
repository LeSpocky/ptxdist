# -*-makefile-*-
#
# Copyright (C) 2009 by Erwin Rol
#               2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBRSVG) += librsvg

#
# Paths and names
#
LIBRSVG_VERSION		:= 2.57.2
LIBRSVG_MD5		:= 2f7db11bc9736c07775cf97f40b01784
LIBRSVG			:= librsvg-$(LIBRSVG_VERSION)
LIBRSVG_SUFFIX		:= tar.xz
LIBRSVG_URL		:= $(call ptx/mirror, GNOME, librsvg/$(basename $(LIBRSVG_VERSION))/$(LIBRSVG).$(LIBRSVG_SUFFIX))
LIBRSVG_SOURCE		:= $(SRCDIR)/$(LIBRSVG).$(LIBRSVG_SUFFIX)
LIBRSVG_DIR		:= $(BUILDDIR)/$(LIBRSVG)
LIBRSVG_CARGO_LOCK	:= Cargo.lock
LIBRSVG_LICENSE		:= LGPL-2.1-or-later AND unknown
LIBRSVG_LICENSE_FILES	:= \
	file://COPYING.LIB;md5=4fbd65380cdd255951079008b364516c

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBRSVG_CONF_ENV	:= \
	$(CROSS_ENV) \
	RUST_TARGET=$(PTXCONF_RUST_TARGET) \
	ac_cv_path_GDK_PIXBUF_QUERYLOADERS=: \
	ac_cv_prog_RST2MAN=no

#
# autoconf
#
LIBRSVG_CONF_TOOL	:= autoconf
LIBRSVG_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-gtk-doc \
	--disable-installed-tests \
	--disable-always-build-tests \
	--$(call ptx/endis, PTXCONF_LIBRSVG_PIXBUF_LOADER)-pixbuf-loader \
	--disable-debug \
	--disable-introspection \
	--disable-vala

LIBRSVG_MAKE_ENV	:= \
	$(CROSS_CARGO_ENV)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/librsvg.targetinstall:
	@$(call targetinfo)

	@$(call install_init, librsvg)
	@$(call install_fixup, librsvg,PRIORITY,optional)
	@$(call install_fixup, librsvg,SECTION,base)
	@$(call install_fixup, librsvg,AUTHOR,"Erwin Rol")
	@$(call install_fixup, librsvg,DESCRIPTION,missing)

	@$(call install_lib, librsvg, 0, 0, 0644, librsvg-2)

	@$(call install_finish, librsvg)

	@$(call touch)

# vim: syntax=make
