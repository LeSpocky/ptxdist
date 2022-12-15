# -*-makefile-*-
#
# Copyright (C) 2003-2009 Robert Schwebel <r.schwebel@pengutronix.de>
#                         Pengutronix <info@pengutronix.de>, Germany
#                         Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PANGO) += pango

#
# Paths and names
#
PANGO_VERSION	:= 1.50.12
PANGO_MD5	:= fd4b0b23915d6a0255317f811bea4215
PANGO		:= pango-$(PANGO_VERSION)
PANGO_SUFFIX	:= tar.xz
PANGO_URL	:= $(call ptx/mirror, GNOME, pango/$(basename $(PANGO_VERSION))/$(PANGO).$(PANGO_SUFFIX))
PANGO_SOURCE	:= $(SRCDIR)/$(PANGO).$(PANGO_SUFFIX)
PANGO_DIR	:= $(BUILDDIR)/$(PANGO)
PANGO_LICENSE	:= LGPL-2.0-or-later
PANGO_LICENSE_FILES := \
	file://pango/pango.h;startline=4;endline=19;md5=c77448008291979d480c86aa699c1f13 \
	file://COPYING;md5=3bf50002aefd002f49e7bb854063f7e7

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PANGO_CONF_TOOL	:= meson
PANGO_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Dcairo=enabled \
	-Dfontconfig=enabled \
	-Dfreetype=enabled \
	-Dgtk_doc=false \
	-Dinstall-tests=false \
	-Dintrospection=$(call ptx/endis,PTXCONF_PANGO_INTROSPECTION)d \
	-Dlibthai=disabled \
	-Dsysprof=disabled \
	-Dxft=disabled

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/pango.targetinstall:
	@$(call targetinfo)

	@$(call install_init, pango)
	@$(call install_fixup, pango,PRIORITY,optional)
	@$(call install_fixup, pango,SECTION,base)
	@$(call install_fixup, pango,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, pango,DESCRIPTION,missing)

	@$(call install_lib, pango, 0, 0, 0644, libpango-1.0)
	@$(call install_lib, pango, 0, 0, 0644, libpangoft2-1.0)
	@$(call install_lib, pango, 0, 0, 0644, libpangocairo-1.0)
ifdef PTXCONF_PANGO_INTROSPECTION
	@$(call install_copy, pango, 0, 0, 0644, -, \
		/usr/lib/girepository-1.0/Pango-1.0.typelib)
endif

	@$(call install_finish, pango)

	@$(call touch)

# vim: syntax=make
