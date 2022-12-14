# -*-makefile-*-
#
# Copyright (C) 2006-2008 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GTK) += gtk

#
# Paths and names
#
GTK_VERSION	:= 3.24.35
GTK_MD5		:= b258062c7960a57c8401fb431890988a
GTK		:= gtk+-$(GTK_VERSION)
GTK_SUFFIX	:= tar.bz2
GTK_URL		:= https://gitlab.gnome.org/GNOME/gtk/-/archive/$(GTK_VERSION)/$(GTK).$(GTK_SUFFIX)
GTK_SOURCE	:= $(SRCDIR)/$(GTK).$(GTK_SUFFIX)
GTK_DIR		:= $(BUILDDIR)/$(GTK)
GTK_LICENSE	:= LGPL-2.0-or-later
GTK_LICENSE_FILES := \
	file://gtk/gtk.h;startline=1;endline=16;md5=afc4cab684b2381c66b31615c9c5b99c \
	file://COPYING;md5=5f30f0716dfdd0d91eb439ebec522ec2


# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# meson
#
GTK_CONF_TOOL	:= meson
GTK_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Dbroadway_backend=false \
	-Dbuiltin_immodules=yes \
	-Dcloudproviders=false \
	-Dcolord=no \
	-Ddemos=true \
	-Dexamples=false \
	-Dgtk_doc=false \
	-Dinstalled_tests=false \
	-Dintrospection=false \
	-Dman=false \
	-Dprint_backends=file \
	-Dprofiler=false \
	-Dquartz_backend=false \
	-Dtests=false \
	-Dtracker3=false \
	-Dwayland_backend=$(call ptx/truefalse, PTXCONF_GTK_WAYLAND) \
	-Dwin32_backend=false \
	-Dx11_backend=$(call ptx/truefalse, PTXCONF_GTK_X11) \
	-Dxinerama=$(call ptx/yesno, PTXCONF_GTK_XINERAMA)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gtk.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gtk)
	@$(call install_fixup, gtk,PRIORITY,optional)
	@$(call install_fixup, gtk,SECTION,base)
	@$(call install_fixup, gtk,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, gtk,DESCRIPTION,missing)

	@$(call install_lib, gtk, 0, 0, 0644, libgdk-3)
	@$(call install_lib, gtk, 0, 0, 0644, libgtk-3)
	@$(call install_lib, gtk, 0, 0, 0644, libgailutil-3)

	@$(call install_finish, gtk)

	@$(call touch)

# vim: syntax=make
