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
GTK_VERSION	:= 3.24.21
GTK_MD5		:= 95afed6c860d27de827db66434d681da
GTK		:= gtk+-$(GTK_VERSION)
GTK_SUFFIX	:= tar.xz
GTK_URL		:= $(call ptx/mirror, GNOME, gtk+/$(basename $(GTK_VERSION))/$(GTK).$(GTK_SUFFIX))
GTK_SOURCE	:= $(SRCDIR)/$(GTK).$(GTK_SUFFIX)
GTK_DIR		:= $(BUILDDIR)/$(GTK)
GTK_LICENSE	:= LGPL-2.0-or-later

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
