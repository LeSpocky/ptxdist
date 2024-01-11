# -*-makefile-*-
#
# Copyright (C) 2012 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBSOUP) += libsoup

#
# Paths and names
#
LIBSOUP_VERSION	:= 3.4.4
LIBSOUP_MD5	:= a63ea04a9686e9e4470b127ffe1eb96b
LIBSOUP		:= libsoup-$(LIBSOUP_VERSION)
LIBSOUP_SUFFIX	:= tar.xz
LIBSOUP_URL	:= $(call ptx/mirror, GNOME, libsoup/$(basename $(LIBSOUP_VERSION))/$(LIBSOUP).$(LIBSOUP_SUFFIX))
LIBSOUP_SOURCE	:= $(SRCDIR)/$(LIBSOUP).$(LIBSOUP_SUFFIX)
LIBSOUP_DIR	:= $(BUILDDIR)/$(LIBSOUP)
LIBSOUP_LICENSE	:= LGPL-2.1-only
LIBSOUP_LICENSE_FILES := \
	file://COPYING;md5=5f30f0716dfdd0d91eb439ebec522ec2

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# meson
#
LIBSOUP_CONF_TOOL := meson
LIBSOUP_CONF_OPT := \
	$(CROSS_MESON_USR) \
	-Dautobahn=disabled \
	-Dbrotli=disabled \
	-Ddoc_tests=false \
	-Ddocs=disabled \
	-Dfuzzing=disabled \
	-Dgssapi=disabled \
	-Dinstalled_tests=false \
	-Dintrospection=$(call ptx/endis, PTXCONF_LIBSOUP_INTROSPECTION)d \
	-Dkrb5_config= \
	-Dntlm=disabled \
	-Dntlm_auth=ntlm_auth \
	-Dpkcs11_tests=disabled \
	-Dsysprof=disabled \
	-Dtests=false \
	-Dtls_check=false \
	-Dvapi=disabled

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libsoup.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libsoup)
	@$(call install_fixup, libsoup,PRIORITY,optional)
	@$(call install_fixup, libsoup,SECTION,base)
	@$(call install_fixup, libsoup,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, libsoup,DESCRIPTION,missing)

	@$(call install_lib, libsoup, 0, 0, 0644, libsoup-3.0)
ifdef PTXCONF_LIBSOUP_INTROSPECTION
	@$(call install_copy, libsoup, 0, 0, 0644, -, \
		/usr/lib/girepository-1.0/Soup-3.0.typelib)
endif

	@$(call install_finish, libsoup)

	@$(call touch)

# vim: syntax=make
