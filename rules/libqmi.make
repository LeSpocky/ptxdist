# -*-makefile-*-
#
# Copyright (C) 2015 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBQMI) += libqmi

#
# Paths and names
#
LIBQMI_VERSION	:= 1.32.0
LIBQMI_MD5	:= c3a279461dc71ebc596c1cbae4bad19c
LIBQMI		:= libqmi-$(LIBQMI_VERSION)
LIBQMI_SUFFIX	:= tar.bz2
LIBQMI_URL	:= https://gitlab.freedesktop.org/mobile-broadband/libqmi/-/archive/$(LIBQMI_VERSION)/$(LIBQMI).$(LIBQMI_SUFFIX)
LIBQMI_SOURCE	:= $(SRCDIR)/$(LIBQMI).$(LIBQMI_SUFFIX)
LIBQMI_DIR	:= $(BUILDDIR)/$(LIBQMI)
LIBQMI_LICENSE	:= GPL-2.0-or-later AND LGPL-2.1-or-later
LIBQMI_LICENSE_FILES := \
	file://COPYING;md5=b234ee4d69f5fce4486a80fdaf4a4263 \
	file://COPYING.LIB;md5=4fbd65380cdd255951079008b364516c

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# meson
#
LIBQMI_CONF_TOOL	:= meson
LIBQMI_CONF_OPT		:= \
	$(CROSS_MESON_USR) \
	-Dfirmware_update=false \
	-Dcollection=full \
	-Dmbim_qmux=$(call ptx/truefalse, PTXCONF_LIBQMI_MBIM_QMUX) \
	-Dmm_runtime_check=false \
	-Dqrtr=false \
	-Drmnet=false \
	-Dudev=false \
	-Dudevdir=/usr/lib/udev \
	-Dintrospection=false \
	-Dgtk_doc=false \
	-Dman=false \
	-Dbash_completion=false

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libqmi.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libqmi)
	@$(call install_fixup, libqmi,PRIORITY,optional)
	@$(call install_fixup, libqmi,SECTION,base)
	@$(call install_fixup, libqmi,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, libqmi,DESCRIPTION,missing)

	@$(call install_copy, libqmi, 0, 0, 0755, -, /usr/bin/qmicli)
	@$(call install_copy, libqmi, 0, 0, 0755, -, /usr/bin/qmi-network)

	@$(call install_copy, libqmi, 0, 0, 0755, -, /usr/libexec/qmi-proxy)
	@$(call install_lib, libqmi, 0, 0, 0644, libqmi-glib)

	@$(call install_finish, libqmi)

	@$(call touch)

# vim: syntax=make
