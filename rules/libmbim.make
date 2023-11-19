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
PACKAGES-$(PTXCONF_LIBMBIM) += libmbim

#
# Paths and names
#
LIBMBIM_VERSION		:= 1.30.0
LIBMBIM_MD5		:= dcfb85bd4338f0aa8a851d5d80d123f7
LIBMBIM			:= libmbim-$(LIBMBIM_VERSION)
LIBMBIM_SUFFIX		:= tar.bz2
LIBMBIM_URL		:= https://gitlab.freedesktop.org/mobile-broadband/libmbim/-/archive/$(LIBMBIM_VERSION)/$(LIBMBIM).$(LIBMBIM_SUFFIX)
LIBMBIM_SOURCE		:= $(SRCDIR)/$(LIBMBIM).$(LIBMBIM_SUFFIX)
LIBMBIM_DIR		:= $(BUILDDIR)/$(LIBMBIM)
LIBMBIM_LICENSE		:= GPL-2.0-or-later AND LGPL-2.1-or-later
LIBMBIM_LICENSE_FILES	:= \
	file://LICENSES/GPL-2.0-or-later.txt;md5=b234ee4d69f5fce4486a80fdaf4a4263 \
	file://LICENSES/LGPL-2.1-or-later.txt;md5=4fbd65380cdd255951079008b364516c

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# meson
#
LIBMBIM_CONF_TOOL	:= meson
LIBMBIM_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Dudevdir=/usr/lib/udev \
	-Dintrospection=false \
	-Dgtk_doc=false \
	-Dman=false \
	-Dbash_completion=false

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libmbim.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libmbim)
	@$(call install_fixup, libmbim,PRIORITY,optional)
	@$(call install_fixup, libmbim,SECTION,base)
	@$(call install_fixup, libmbim,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, libmbim,DESCRIPTION,missing)

	@$(call install_copy, libmbim, 0, 0, 0755, -, /usr/bin/mbimcli)
	@$(call install_copy, libmbim, 0, 0, 0755, -, /usr/bin/mbim-network)

	@$(call install_copy, libmbim, 0, 0, 0755, -, /usr/libexec/mbim-proxy)
	@$(call install_lib, libmbim, 0, 0, 0644, libmbim-glib)

	@$(call install_finish, libmbim)

	@$(call touch)

# vim: syntax=make
