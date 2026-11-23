# -*-makefile-*-
#
# Copyright (C) 2026 by Ladislav Michl <ladis@triops.cz>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBDECOR) += libdecor

#
# Paths and names
#
LIBDECOR_VERSION	:= 0.2.5
LIBDECOR_SHA256		:= 7fd50f780a4fee90a03f7b2c09055033e488654cbaff4a0c4bbae616bac9cd1c
LIBDECOR		:= libdecor-$(LIBDECOR_VERSION)
LIBDECOR_SUFFIX		:= tar.xz
LIBDECOR_URL		:= https://gitlab.freedesktop.org/libdecor/libdecor/-/releases/$(LIBDECOR_VERSION)/downloads/$(LIBDECOR).$(LIBDECOR_SUFFIX)
LIBDECOR_SOURCE		:= $(SRCDIR)/$(LIBDECOR).$(LIBDECOR_SUFFIX)
LIBDECOR_DIR		:= $(BUILDDIR)/$(LIBDECOR)
LIBDECOR_LICENSE	:= MIT
LIBDECOR_LICENSE_FILES	:= \
	file://LICENSE;md5=7ae2be7fb1637141840314b51970a9f7 \
	file://src/libdecor.c;startline=2;endline=23;md5=30eb694bfeee143cc679ea2769b05a49

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBDECOR_CONF_TOOL	:= meson
LIBDECOR_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Ddbus=$(call ptx/endis, PTXCONF_LIBDECOR_DBUS)d \
	-Ddemo=false \
	-Dgtk=$(call ptx/endis, PTXCONF_LIBDECOR_GTK)d \
	-Dinstall_demo=false

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libdecor.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libdecor)
	@$(call install_fixup, libdecor,PRIORITY,optional)
	@$(call install_fixup, libdecor,SECTION,base)
	@$(call install_fixup, libdecor,AUTHOR,"Ladislav Michl <ladis@triops.cz>")
	@$(call install_fixup, libdecor,DESCRIPTION,missing)

	@$(call install_lib, libdecor, 0, 0, 0644, libdecor-0)
	@$(call install_lib, libdecor, 0, 0, 0644, \
		libdecor/plugins-1/libdecor-cairo)
ifdef PTXCONF_LIBDECOR_GTK
	@$(call install_lib, libdecor, 0, 0, 0644, \
		libdecor/plugins-1/libdecor-gtk)
endif

	@$(call install_finish, libdecor)

	@$(call touch)

# vim: syntax=make
