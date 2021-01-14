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
PACKAGES-$(PTXCONF_GST_DEVTOOLS1) += gst-devtools1

#
# Paths and names
#
GST_DEVTOOLS1_VERSION	:= 1.18.3
GST_DEVTOOLS1_MD5	:= e03d0925b663db51011395d3df4615b3
GST_DEVTOOLS1		:= gst-devtools-$(GST_DEVTOOLS1_VERSION)
GST_DEVTOOLS1_SUFFIX	:= tar.xz
GST_DEVTOOLS1_URL	:= http://gstreamer.freedesktop.org/data/src/gst-devtools/$(GST_DEVTOOLS1).$(GST_DEVTOOLS1_SUFFIX)
GST_DEVTOOLS1_SOURCE	:= $(SRCDIR)/$(GST_DEVTOOLS1).$(GST_DEVTOOLS1_SUFFIX)
GST_DEVTOOLS1_DIR	:= $(BUILDDIR)/$(GST_DEVTOOLS1)
GST_DEVTOOLS1_LICENSE	:= LGPL-2.1-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# meson
#
GST_DEVTOOLS1_CONF_TOOL	:= meson
GST_DEVTOOLS1_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Ddebug_viewer=disabled \
	-Ddoc=disabled \
	-Dintrospection=$(call ptx/endis,PTXCONF_GSTREAMER1_INTROSPECTION)d \
	-Dnls=disabled \
	-Dtests=disabled \
	-Dvalidate=enabled

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gst-devtools1.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gst-devtools1)
	@$(call install_fixup, gst-devtools1,PRIORITY,optional)
	@$(call install_fixup, gst-devtools1,SECTION,base)
	@$(call install_fixup, gst-devtools1,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, gst-devtools1,DESCRIPTION,missing)

	@$(call install_lib, gst-devtools1, 0, 0, 0644, libgstvalidate-1.0)
	@$(call install_lib, gst-devtools1, 0, 0, 0644, \
		libgstvalidate-default-overrides-1.0)

	@$(call install_lib, gst-devtools1, 0, 0, 0644, \
		gstreamer-1.0/libgstvalidatetracer)

	@$(call install_lib, gst-devtools1, 0, 0, 0644, \
		gstreamer-1.0/validate/libgstvalidatefaultinjection)
	@$(call install_lib, gst-devtools1, 0, 0, 0644, \
		gstreamer-1.0/validate/libgstvalidategapplication)

	@$(call install_copy, gst-devtools1, 0, 0, 0755, -, \
		/usr/bin/gst-validate-1.0)
	@$(call install_copy, gst-devtools1, 0, 0, 0755, -, \
		/usr/bin/gst-validate-media-check-1.0)
	@$(call install_copy, gst-devtools1, 0, 0, 0755, -, \
		/usr/bin/gst-validate-transcoding-1.0)

	@$(call install_tree, gst-devtools1, 0, 0, -, \
		/usr/share/gstreamer-1.0/validate/scenarios)

ifdef PTXCONF_GSTREAMER1_INTROSPECTION
	@$(call install_copy, gst-devtools1, 0, 0, 0644, -, \
		/usr/lib/girepository-1.0/GstValidate-1.0.typelib)
endif

ifdef PTXCONF_GST_DEVTOOLS1_VIDEO
	@$(call install_lib, gst-devtools1, 0, 0, 0644, \
		gstreamer-1.0/validate/libgstvalidatessim)

	@$(call install_copy, gst-devtools1, 0, 0, 0755, -, \
		/usr/bin/gst-validate-images-check-1.0)
endif

ifdef PTXCONF_GST_DEVTOOLS1_VALIDATE_LAUNCHER
	@$(call install_copy, gst-devtools1, 0, 0, 0755, -, \
		/usr/bin/gst-validate-launcher)

	# internal magic is broken when .py files are missing
	$(call install_glob, gst-devtools1, 0, 0, -, \
		/usr/lib/gst-validate-launcher/python,*.py)
endif

	@$(call install_finish, gst-devtools1)

	@$(call touch)

# vim: syntax=make
