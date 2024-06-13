# -*-makefile-*-
#
# Copyright (C) 2003-2006 Robert Schwebel <r.schwebel@pengutronix.de>
#                         Pengutronix <info@pengutronix.de>, Germany
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#               2024 Roland Hieber, Pengutronix
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_AT_SPI2_CORE) += at-spi2-core

#
# Paths and names
#
AT_SPI2_CORE_VERSION	:= 2.52.0
AT_SPI2_CORE_MD5	:= e6591545b2bf204fe9a58f777bd0b78a
AT_SPI2_CORE		:= at-spi2-core-$(AT_SPI2_CORE_VERSION)
AT_SPI2_CORE_SUFFIX	:= tar.xz
AT_SPI2_CORE_URL	:= $(call ptx/mirror, GNOME, at-spi2-core/$(basename $(AT_SPI2_CORE_VERSION))/$(AT_SPI2_CORE).$(AT_SPI2_CORE_SUFFIX))
AT_SPI2_CORE_SOURCE	:= $(SRCDIR)/$(AT_SPI2_CORE).$(AT_SPI2_CORE_SUFFIX)
AT_SPI2_CORE_DIR	:= $(BUILDDIR)/$(AT_SPI2_CORE)
AT_SPI2_CORE_LICENSE	:= LGPL-2.0-or-later AND LGPL-2.1-or-later AND AFL-2.1
AT_SPI2_CORE_LICENSE_FILES := \
	file://atk/atkaction.c;startline=1;endline=18;md5=6fd31cd2fdc9b30f619ca8d819bc12d3 \
	file://atspi/atspi-gmain.c;startline=4;endline=21;md5=5a40bca956865414952184669ef3985c \
	file://COPYING;md5=4fbd65380cdd255951079008b364516c

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# meson
#
AT_SPI2_CORE_CONF_TOOL	:= meson
AT_SPI2_CORE_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Datk_only=true \
	-Ddbus_broker=default \
	-Ddbus_daemon=default \
	-Ddbus_services_dir=default \
	-Ddefault_bus=dbus-daemon \
	-Ddisable_p2p=false \
	-Ddocs=false \
	-Dgtk2_atk_adaptor=false \
	-Dintrospection=$(call ptx/endis, PTXCONF_AT_SPI2_CORE_INTROSPECTION)d \
	-Dsystemd_user_dir=default \
	-Duse_systemd=false \
	-Dx11=disabled

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/at-spi2-core.targetinstall:
	@$(call targetinfo)

	@$(call install_init, at-spi2-core)
	@$(call install_fixup, at-spi2-core,PRIORITY,optional)
	@$(call install_fixup, at-spi2-core,SECTION,base)
	@$(call install_fixup, at-spi2-core,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, at-spi2-core,DESCRIPTION,missing)

	@$(call install_lib, at-spi2-core, 0, 0, 0644, libatk-1.0)

ifdef PTXCONF_AT_SPI2_CORE_INTROSPECTION
	@$(call install_copy, at-spi2-core, 0, 0, 0644, -, \
		/usr/lib/girepository-1.0/Atk-1.0.typelib)
endif

	@$(call install_finish, at-spi2-core)

	@$(call touch)

# vim: syntax=make
