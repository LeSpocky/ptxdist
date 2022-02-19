# -*-makefile-*-
#
# Copyright (C) 2016 by Bastian Stender <bst@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_JSON_GLIB) += json-glib

#
# Paths and names
#
JSON_GLIB_VERSION	:= 1.6.6
JSON_GLIB_MD5		:= 9c40fcd8cdbf484dd1704480afefae14
JSON_GLIB		:= json-glib-$(JSON_GLIB_VERSION)
JSON_GLIB_SUFFIX	:= tar.xz
JSON_GLIB_URL		:= $(call ptx/mirror, GNOME, json-glib/$(basename $(JSON_GLIB_VERSION))/$(JSON_GLIB).$(JSON_GLIB_SUFFIX))
JSON_GLIB_SOURCE	:= $(SRCDIR)/$(JSON_GLIB).$(JSON_GLIB_SUFFIX)
JSON_GLIB_DIR		:= $(BUILDDIR)/$(JSON_GLIB)
JSON_GLIB_LICENSE	:= LGPL-2.1-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# meson
#
JSON_GLIB_CONF_TOOL	:= meson
JSON_GLIB_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Dintrospection=$(call ptx/endis, PTXCONF_JSON_GLIB_INTROSPECTION)d \
	-Dgtk_doc=disabled \
	-Dman=false \
	-Dtests=false

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/json-glib.targetinstall:
	@$(call targetinfo)

	@$(call install_init, json-glib)
	@$(call install_fixup, json-glib, PRIORITY, optional)
	@$(call install_fixup, json-glib, SECTION, base)
	@$(call install_fixup, json-glib, AUTHOR, "Bastian Stender <bst@pengutronix.de>")
	@$(call install_fixup, json-glib, DESCRIPTION, \
		"A library providing (de)serialization support for the JSON format.")

	@$(call install_lib, json-glib, 0, 0, 0644, libjson-glib-1.0)
ifdef PTXCONF_JSON_GLIB_INTROSPECTION
	@$(call install_copy, json-glib, 0, 0, 0644, -, \
		/usr/lib/girepository-1.0/Json-1.0.typelib)
endif

	@$(call install_finish, json-glib)

	@$(call touch)

# vim: syntax=make
