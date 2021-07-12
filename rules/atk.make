# -*-makefile-*-
#
# Copyright (C) 2003-2006 Robert Schwebel <r.schwebel@pengutronix.de>
#                         Pengutronix <info@pengutronix.de>, Germany
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ATK) += atk

#
# Paths and names
#
ATK_VERSION	:= 2.36.0
ATK_MD5		:= 01aa5ec5138f5f8c9b3a4e3196ed2900
ATK		:= atk-$(ATK_VERSION)
ATK_SUFFIX	:= tar.xz
ATK_URL		:= $(call ptx/mirror, GNOME, atk/$(basename $(ATK_VERSION))/$(ATK).$(ATK_SUFFIX))
ATK_SOURCE	:= $(SRCDIR)/$(ATK).$(ATK_SUFFIX)
ATK_DIR		:= $(BUILDDIR)/$(ATK)
ATK_LICENSE	:= LGPL-2.0-or-later
ATK_LICENSE_FILES := \
	file://atk/atkaction.c;startline=1;endline=18;md5=6fd31cd2fdc9b30f619ca8d819bc12d3 \
	file://COPYING;md5=3bf50002aefd002f49e7bb854063f7e7

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# meson
#
ATK_CONF_TOOL	:= meson
ATK_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Ddocs=false \
	-Dintrospection=$(call ptx/truefalse, PTXCONF_ATK_INTROSPECTION)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/atk.targetinstall:
	@$(call targetinfo)

	@$(call install_init, atk)
	@$(call install_fixup, atk,PRIORITY,optional)
	@$(call install_fixup, atk,SECTION,base)
	@$(call install_fixup, atk,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, atk,DESCRIPTION,missing)

	@$(call install_lib, atk, 0, 0, 0644, libatk-1.0)
ifdef PTXCONF_ATK_INTROSPECTION
	@$(call install_copy, atk, 0, 0, 0644, -, \
		/usr/lib/girepository-1.0/Atk-1.0.typelib)
endif

	@$(call install_finish, atk)

	@$(call touch)

# vim: syntax=make
