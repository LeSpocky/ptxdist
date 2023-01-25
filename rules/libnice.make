# -*-makefile-*-
#
# Copyright (C) 2019 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBNICE) += libnice

#
# Paths and names
#
LIBNICE_VERSION	:= 0.1.21
LIBNICE_MD5	:= fe43ff9ed4db2ecbb2d480c670bee855
LIBNICE		:= libnice-$(LIBNICE_VERSION)
LIBNICE_SUFFIX	:= tar.gz
LIBNICE_URL	:= https://libnice.freedesktop.org/releases/$(LIBNICE).$(LIBNICE_SUFFIX)
LIBNICE_SOURCE	:= $(SRCDIR)/$(LIBNICE).$(LIBNICE_SUFFIX)
LIBNICE_DIR	:= $(BUILDDIR)/$(LIBNICE)
LIBNICE_LICENSE	:= MPL-1.1 OR LGPL-2.1-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# meson
#
LIBNICE_CONF_TOOL	:= meson
LIBNICE_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Dcrypto-library=openssl \
	-Dexamples=disabled \
	-Dgstreamer=enabled \
	-Dgtk_doc=disabled \
	-Dgupnp=disabled \
	-Dintrospection=disabled \
	-Dtests=disabled

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libnice.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libnice)
	@$(call install_fixup, libnice,PRIORITY,optional)
	@$(call install_fixup, libnice,SECTION,base)
	@$(call install_fixup, libnice,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, libnice,DESCRIPTION,missing)

	@$(call install_lib, libnice, 0, 0, 0644, libnice)
	@$(call install_lib, libnice, 0, 0, 0644, gstreamer-1.0/libgstnice)

	@$(call install_finish, libnice)

	@$(call touch)

# vim: syntax=make
