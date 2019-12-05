# -*-makefile-*-
#
# Copyright (C) 2014 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GSTREAMER_VAAPI1) += gstreamer-vaapi1

#
# Paths and names
#
GSTREAMER_VAAPI1_VERSION	:= 1.16.2
GSTREAMER_VAAPI1_MD5		:= 13f7cb6a64bde24e67f563377487dcce
GSTREAMER_VAAPI1		:= gstreamer-vaapi-$(GSTREAMER_VAAPI1_VERSION)
GSTREAMER_VAAPI1_SUFFIX		:= tar.xz
GSTREAMER_VAAPI1_URL		:= http://gstreamer.freedesktop.org/src/gstreamer-vaapi/$(GSTREAMER_VAAPI1).$(GSTREAMER_VAAPI1_SUFFIX)
GSTREAMER_VAAPI1_SOURCE		:= $(SRCDIR)/$(GSTREAMER_VAAPI1).$(GSTREAMER_VAAPI1_SUFFIX)
GSTREAMER_VAAPI1_DIR		:= $(BUILDDIR)/$(GSTREAMER_VAAPI1)
GSTREAMER_VAAPI1_LICENSE	:= LGPL-2.0-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# meson
#
GSTREAMER_VAAPI1_CONF_TOOL	:= meson
GSTREAMER_VAAPI1_CONF_OPT	= \
	$(CROSS_MESON_USR) \
	-Dexamples=disabled \
	-Dgtk_doc=disabled \
	-Dwith_drm=yes \
	-Dwith_egl=$(call ptx/yesno, PTXCONF_GSTREAMER_VAAPI1_OPENGL) \
	-Dwith_encoders=yes \
	-Dwith_glx=$(call ptx/yesno, PTXCONF_GSTREAMER_VAAPI1_GLX) \
	-Dwith_wayland=$(call ptx/yesno, PTXCONF_GSTREAMER_VAAPI1_WAYLAND) \
	-Dwith_x11=$(call ptx/yesno, PTXCONF_GSTREAMER_VAAPI1_X11) \

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gstreamer-vaapi1.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gstreamer-vaapi1)
	@$(call install_fixup, gstreamer-vaapi1,PRIORITY,optional)
	@$(call install_fixup, gstreamer-vaapi1,SECTION,base)
	@$(call install_fixup, gstreamer-vaapi1,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, gstreamer-vaapi1,DESCRIPTION,missing)

	@$(call install_lib, gstreamer-vaapi1, 0, 0, 0644, \
		gstreamer-1.0/libgstvaapi)

	@$(call install_finish, gstreamer-vaapi1)

	@$(call touch)

# vim: syntax=make
