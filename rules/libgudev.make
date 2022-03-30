# -*-makefile-*-
#
# Copyright (C) 2015 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBGUDEV) += libgudev

#
# Paths and names
#
LIBGUDEV_VERSION	:= 237
LIBGUDEV_MD5		:= a7783083cd74957d3a727ddc4737ee84
LIBGUDEV		:= libgudev-$(LIBGUDEV_VERSION)
LIBGUDEV_SUFFIX		:= tar.xz
LIBGUDEV_URL		:= $(call ptx/mirror, GNOME, libgudev/$(LIBGUDEV_VERSION)/$(LIBGUDEV).$(LIBGUDEV_SUFFIX))
LIBGUDEV_SOURCE		:= $(SRCDIR)/$(LIBGUDEV).$(LIBGUDEV_SUFFIX)
LIBGUDEV_DIR		:= $(BUILDDIR)/$(LIBGUDEV)
LIBGUDEV_LICENSE	:= LGPL-2.1-or-later
LIBGUDEV_LICENSE_FILES	:= \
	file://gudev/gudevclient.c;startline=3;endline=17;md5=829bbbdef46b2ae9fc89115aea26f119 \
	file://COPYING;md5=4fbd65380cdd255951079008b364516c

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ifdef PTXCONF_ARCH_PPC
PTXCONF_LIBGUDEV_INTROSPECTION :=
endif

#
# meson
#
LIBGUDEV_CONF_TOOL	:= meson
LIBGUDEV_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Dgtk_doc=false \
	-Dintrospection=$(call ptx/endis, PTXCONF_LIBGUDEV_INTROSPECTION)d \
	-Dtests=disabled \
	-Dvapi=disabled

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libgudev.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libgudev)
	@$(call install_fixup, libgudev,PRIORITY,optional)
	@$(call install_fixup, libgudev,SECTION,base)
	@$(call install_fixup, libgudev,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, libgudev,DESCRIPTION,missing)

	@$(call install_lib, libgudev, 0, 0, 0644, libgudev-1.0)
ifdef PTXCONF_LIBGUDEV_INTROSPECTION
	@$(call install_copy, libgudev, 0, 0, 0644, -, \
		/usr/lib/girepository-1.0/GUdev-1.0.typelib)
endif

	@$(call install_finish, libgudev)

	@$(call touch)

# vim: syntax=make
